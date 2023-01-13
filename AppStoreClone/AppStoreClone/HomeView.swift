//
//  HomeView.swift
//  AppStoreClone
//
//  Created by DoubleShy0N on 2023/1/12.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("1月12日 星期四")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    Text("Today")
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .frame(height: 50)
                }
                
                Spacer()
                
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .mask(Circle())
            }
            
            VStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("释放创意")
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(size: 14, weight: .medium))
                    
                    Text("迈开创作第一步")
                        .font(.system(size: 28, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.leading, 20)
                .padding(.top, 20)
                
                VStack(spacing: 10) {
                    HStack(spacing: 12) {
                        Image("APP1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP4")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                    }
                    .offset(x: -12)
                    
                    HStack(spacing: 12) {
                        Image("APP5")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP6")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP7")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP8")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP9")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                    }
                    
                    HStack(spacing: 12) {
                        Image("APP10")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP11")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP12")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                        
                        Image("APP13")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .frame(width: 80, height: 80)
                    }
                    .offset(x: -12)
                }
                .mask(Rectangle())
                .frame(width: 350)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 350, height: 380)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
            .mask {
                RoundedRectangle(cornerRadius: 12)
            }
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
            .padding(.bottom, 32)
            
            VStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("编辑最爱")
                        .foregroundColor(.white.opacity(0.6))
                        .font(.system(size: 14, weight: .medium))
                    
                    Text("王者归来，《魔戒》身临")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.leading, 20)
                .padding(.top, 20)
                
                Spacer()
            }
            .frame(width: 350, height: 380)
            .background(
                Image("Photo1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(1.3)
                    .offset(y: 45)
            )
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
            .mask {
                RoundedRectangle(cornerRadius: 12)
            }
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
            .padding(.bottom, 32)

            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
