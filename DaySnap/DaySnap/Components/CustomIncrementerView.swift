//
//  CustomIncrementerView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/7/19.
//

import SwiftUI

struct ButtonFrame: Identifiable, Equatable {
    var id: UUID = .init()
    var value: Int
    var offset: CGSize = .zero
    var opacity: CGFloat = 1.0
    var triggerKeyFrame: Bool = false
}

struct CustomIncrementerView: View {
    @Binding var count: String
    @State private var buttonFrames: [ButtonFrame] = []
    @State private var countInt: Int = 0
    
    var body: some View {
        if #available(iOS 17.0, *) {
            content17
        } else {
            content
        }
    }
    
    var content: some View {
        HStack(spacing: 12, content: {
            Button(action: {
                if countInt != 0 {
                    let frame = ButtonFrame(value: countInt)
                    buttonFrames.append(frame)
                    toggleAnimation(frame.id, false)
                }
            }, label: {
                Image(systemName: "minus")
            })
            .font(.body.weight(.bold))
            
            Text("\(countInt)")
                .fontWeight(.bold)
                .frame(width: 36, height: 36)
                .background(in: .rect(cornerRadius: 10))
        
            Button(action: {
                let frame = ButtonFrame(value: countInt)
                buttonFrames.append(frame)
                toggleAnimation(frame.id)
            }, label: {
                Image(systemName: "plus")
            })
            .font(.body.weight(.bold))
        })
        .onChange(of: countInt, perform: { value in
            count = String(value)
        })
    }
    
    @available(iOS 17.0, *)
    var content17: some View {
        HStack(spacing: 12, content: {
            Button(action: {
                if countInt != 0 {
                    let frame = ButtonFrame(value: countInt)
                    buttonFrames.append(frame)
                    toggleAnimation(frame.id, false)
                }
            }, label: {
                Image(systemName: "minus")
            })
            .fontWeight(.bold)
            .buttonRepeatBehavior(.enabled)
            
            Text("\(countInt)")
                .fontWeight(.bold)
                .frame(width: 36, height: 36)
                .background(.white.shadow(.drop(color: .black.opacity(0.15), radius: 5)), in: .rect(cornerRadius: 10))
                .overlay {
                    ForEach(buttonFrames) { btFrame in
                        KeyframeAnimator(initialValue: ButtonFrame(value: 0), trigger: btFrame.triggerKeyFrame) { frame in
                            Text("\(btFrame.value)")
                                .fontWeight(.bold)
                                .background(.black.opacity(0.6 - frame.opacity))
                                .offset(frame.offset)
                                .opacity(frame.opacity)
                                .blur(radius: (1 - frame.opacity) * 10)
                        } keyframes: { _ in
                            KeyframeTrack(\.offset) {
                                LinearKeyframe(CGSize(width: 0, height: -20), duration: 0.2)
                                LinearKeyframe(CGSize(width: .random(in: -2...2), height: -40), duration: 0.2)
                                LinearKeyframe(CGSize(width: .random(in: -2...2), height: -70), duration: 0.4)
                            }
                            
                            KeyframeTrack(\.opacity) {
                                LinearKeyframe(1, duration: 0.2)
                                LinearKeyframe(1, duration: 0.2)
                                LinearKeyframe(0.7, duration: 0.2)
                                LinearKeyframe(0, duration: 0.2)
                            }
                        }
                    }
                }
            
            Button(action: {
                let frame = ButtonFrame(value: countInt)
                buttonFrames.append(frame)
                toggleAnimation(frame.id)
            }, label: {
                Image(systemName: "plus")
            })
            .fontWeight(.bold)
            .buttonRepeatBehavior(.enabled)
        })
        .onChange(of: countInt) { oldCount, newCount in
            count = String(newCount)
        }
    }
    
    func toggleAnimation(_ id: UUID, _ incerment: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if let index = buttonFrames.firstIndex(where: { $0.id == id }) {
                buttonFrames[index].triggerKeyFrame = true
                
                if incerment {
                    countInt += 1
                } else {
                    countInt -= 1
                }
                
                removeFrame(id)
            }
        }
    }
    
    func removeFrame(_ id: UUID) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            buttonFrames.removeAll(where: { $0.id == id })
        }
    }
}

//#Preview {
//    CustomIncrementerView(count: .constant(0))
//}
@available(iOS 17.0, *)
struct CustomIncrementerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomIncrementerView(count: .constant("0"))
    }
}
