//
//  PayWallView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/14.
//

import SwiftUI
import RevenueCat

struct PayWallView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var currentOffering: Offering?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "laurel.leading")
                        .font(.title)
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .padding(.horizontal)
                    Image(systemName: "laurel.trailing")
                        .font(.title)
                    Spacer()
                }
                .padding()
                
                Text("升级到高级版")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("将解锁全部功能")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TabView {
                    basicPage
                    
                    proPage
                }
                .frame(height: 700)
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                
                Spacer()
            }
            .navigationTitle("获取高级版")
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: 88)
            }
        }
        .onAppear {
            Purchases.shared.getOfferings { offerings, error in
                if let offer = offerings?.current, error == nil {
                    currentOffering = offer
                }
            }
        }
    }
    
    var basicPage: some View {
        VStack {
            Text("基础")
                .font(.headline)
                .frame(width: 80, height: 80)
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke())
                .padding(.bottom, 32)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("免费功能")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                InfoRow(icon: "list.bullet", text: "可创建5个倒数日")
                
                InfoRow(icon: "list.bullet.clipboard", text: "可创建5个打卡")
                
                InfoRow(icon: "wave.3.left.circle", text: "可实现定期通知功能")
                
                InfoRow(icon: "sun.max.circle", text: "可根据定位显示当前天气状况")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            Image("astronaut")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding()
        .strokeStyle(cornerRadius: 8)
    }
    
    var proPage: some View {
        VStack {
            Text("高级")
                .font(.headline)
                .frame(width: 80, height: 80)
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke())
                .padding(.bottom)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("高级功能")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                InfoRow(icon: "list.bullet", text: "可创建无限个倒数日")
                
                InfoRow(icon: "list.bullet.clipboard", text: "可创建无限个打卡")
                
                InfoRow(icon: "rectangle.and.pencil.and.ellipsis", text: "可添加专属的分类")
                
                InfoRow(icon: "macstudio.fill", text: "更多实用小组件")
                
                HStack(spacing: 15) {
                    Text("...")
                        .font(.title2)
                        .frame(width: 24, height: 24)
                    
                    Text("还有很多值得期待的新功能")
                        .font(.subheadline)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            if currentOffering != nil {
                ForEach(currentOffering!.availablePackages) { pkg in
                    Button {
                        Purchases.shared.purchase(package: pkg) { transaction, customerInfo, error, userCancelled in
                            if customerInfo?.entitlements["pro"]?.isActive == true {
                                userViewModel.isSubscriptionActive = true
                                
                                dismiss()
                                print("000000000")
                            }
                        }
                    } label: {
                        Text("订阅 \(pkg.storeProduct.subscriptionPeriod!.periodTitle) \(pkg.storeProduct.localizedPriceString)")
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .strokeStyle(cornerRadius: 8)
                    }
                }
            }
            
            Image("astronaut-pro")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding()
        .strokeStyle(cornerRadius: 8)
    }
}

struct PayWallView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallView()
    }
}
