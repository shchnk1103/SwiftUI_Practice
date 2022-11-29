//
//  PlaySound.swift
//  Learn by Doing
//
//  Created by 沈晨凯 on 2022/11/28.
//

import Foundation
import AVFoundation

// MARK: - AUDIO PLAYER
var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file.")
        }
    }
}
