//
//  CinematicAsset.swift
//  DDOY
//
//  Created by DoubleShy0N on 2023/10/24.
//

import AVFoundation
import Cinematic
import Photos

struct CinematicAsset: Identifiable {
    
    let id = UUID()
    
    let localIdentifier: String
    
    let pathComponent: String
    
    let player: AVPlayer
    
    let cinematicAssetData: CinematicAssetData
    
    var currentEditTime: CMTime = .zero
    
    var editTimelinePosition = Double.zero
    
    var fNumber: Float
    
    init?(localIdentifier: String) async {
        self.localIdentifier = localIdentifier
        
        pathComponent = localIdentifier.replacingOccurrences(of: "/", with: "_")
        
        let result = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil)
        
        guard let phAsset = result.firstObject else { return nil }
        
        let videoRequestOptions = PHVideoRequestOptions()
        videoRequestOptions.version = .original
        videoRequestOptions.deliveryMode = .highQualityFormat
        videoRequestOptions.isNetworkAccessAllowed = true
        
        let asset = await withCheckedContinuation { continuation in
            PHImageManager.default().requestAVAsset(forVideo: phAsset, options: videoRequestOptions) { avAsset, _, _ in
                continuation.resume(returning: avAsset)
            }
        }
        
        guard let asset else { return nil }
        
        do {
            cinematicAssetData = try await CinematicAsset.loadData(from: asset, pathComponent: pathComponent)
        } catch {
            print("Failed to load cinematic asset: \(error.localizedDescription)")
            return nil
        }
        
        fNumber = cinematicAssetData.script.fNumber
        
        do {
            let (avComposition, videoComposition) = cinematicAssetData.makeVideoComposition()

            let playerItem = AVPlayerItem(asset: avComposition)

            playerItem.videoComposition = videoComposition

            player = AVPlayer(playerItem: playerItem)
        }
    }
    
    static private func loadData(from asset: AVAsset, pathComponent: String) async throws -> CinematicAssetData {
        let cinematicAssetInfo = try await CNAssetInfo(asset: asset)
        
        let renderingSessionAttributes = try await CNRenderingSession.Attributes(asset: asset)
        
        guard let renderingCommandQueue = MTLCreateSystemDefaultDevice()?.makeCommandQueue() else { 
            fatalError("Couldn't create command queue")
        }
        
        let renderingSession = CNRenderingSession(
            commandQueue: renderingCommandQueue, 
            sessionAttributes: renderingSessionAttributes,
            preferredTransform: cinematicAssetInfo.preferredTransform,
            quality: CNRenderingQuality.export
        )
        
        let cinematicScript = try await CNScript(asset: asset)
        
        let url = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let fileURL = url.appendingPathComponent(pathComponent, conformingTo: .archive)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            let scriptFileData = try Data(contentsOf: fileURL)
            let cinematicScriptChanges = CNScript.Changes(dataRepresentation: scriptFileData)
            cinematicScript.reload(changes: cinematicScriptChanges)
        }
        
        let nominalFrameRate = try await cinematicAssetInfo.frameTimingTrack.load(.nominalFrameRate)
        let naturalTimeScale = try await cinematicAssetInfo.frameTimingTrack.load(.naturalTimeScale)

        let cinematicAssetData = CinematicAssetData(avAsset: asset,
                                                    assetInfo: cinematicAssetInfo,
                                                    renderingSessionAttributes: renderingSessionAttributes,
                                                    renderingSession: renderingSession,
                                                    commandQueue: renderingCommandQueue,
                                                    script: cinematicScript,
                                                    nominalFrameRate: nominalFrameRate,
                                                    naturalTimeScale: naturalTimeScale)
        
        return cinematicAssetData
    }
}
