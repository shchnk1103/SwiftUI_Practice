//
//  WarnView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/15.
//

import SwiftUI

struct WarnView: View {
    @Binding var flag: Bool
    // status: 0 -> text, 1 -> isSubscription
    @Binding var status: Int
    
    @State private var appear: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.15)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(alignment: .center) {
                    Spacer()
                    
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 80))
                    
                    Spacer()
                    
                    if status == 0 {
                        Text("请您填写完整！")
                            .foregroundColor(.primary.opacity(0.7))
                    } else {
                        VStack(spacing: 10) {
                            Text("抱歉")
                                .font(.headline)
                                .foregroundColor(.primary.opacity(0.7))
                                .multilineTextAlignment(.center)
                            
                            Text("基础用户最多只能各创建5项")
                                .font(.headline)
                                .foregroundColor(.primary.opacity(0.7))
                                .multilineTextAlignment(.center)
                            
                            NavigationLink {
                                PayWallView()
                            } label: {
                                Text("点击前往升级 ->")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .frame(
                    width: geo.frame(in: .global).width / 3 * 2,
                    height: geo.frame(in: .global).height / 3
                )
                .background(.regularMaterial)
                .cornerRadius(12)
                .opacity(appear ? 1 : 0.5)
                .position(x: geo.size.width / 2, y: appear ? geo.size.height / 2 : geo.size.height / 2 + 100)
            }
        }
        .onAppear(perform: {
            withAnimation(.default.delay(0.2)) {
                appear = true
            }
        })
        .onTapGesture {
            flag.toggle()
        }
    }
}

struct WarnView_Previews: PreviewProvider {
    static var previews: some View {
        WarnView(flag: .constant(false), status: .constant(1))
    }
}
