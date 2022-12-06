//
//  ContentView.swift
//  Slot Machine
//
//  Created by 沈晨凯 on 2022/12/3.
//

import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTY
  @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
  @State private var showingInfoView: Bool = false
  @State private var reels: Array = [0, 1, 2]
  @State private var coins: Int = 100
  @State private var betAmount: Int = 10
  @State private var isActiveBet10: Bool = true
  @State private var isActiveBet20: Bool = false
  @State private var showingModal: Bool = false
  @State private var animatingSymbol: Bool = false
  @State private var animatingModal: Bool = false
  
  let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
  let haptic = UIImpactFeedbackGenerator()
  
  // MARK: - FUNCTINO
  // SPIN THE REELS
  func spinReels() {
    reels = reels.map({ _ in
      Int.random(in: 0...symbols.count - 1)
    })
  }
  
  // CHECK THE WINNING
  func checkWinning() {
    if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
      // PLAYER WINS
      playerWins()
      
      // NEW HIGH SCORE
      if coins > highscore {
        newHighScore()
      } else {
        playSound(sound: "win", type: "mp3")
      }
    } else {
      // PLAYER LOSES
      playerLoses()
    }
  }
  
  func playerWins() {
    coins += betAmount * 10
  }
  
  func newHighScore() {
    highscore = coins
    UserDefaults.standard.set(highscore, forKey: "HighScore")
    playSound(sound: "high-score", type: "mp3")
  }
  
  func playerLoses() {
    coins -= betAmount
  }
  
  func activateBet20() {
    betAmount = 20
    isActiveBet20 = true
    isActiveBet10 = false
    playSound(sound: "casino-chips", type: "mp3")
  }
  
  func activateBet10() {
    betAmount = 10
    isActiveBet10 = true
    isActiveBet20 = false
    playSound(sound: "casino-chips", type: "mp3")
  }
  
  // GAME IS OVER
  func isGameOver() {
    if coins <= 0 {
      showingModal = true
      playSound(sound: "game-over", type: "mp3")
    }
  }
  
  func resetGame() {
    UserDefaults.standard.set(0, forKey: "HighScore")
    highscore = 0
    coins = 100
    activateBet10()
    playSound(sound: "chimeup", type: "mp3")
  }
  
  // MARK: - BODY
  var body: some View {
    ZStack {
      // MARK: - BACKGROUND
      LinearGradient(
        colors: [Color("ColorPink"), Color("ColorPurple")],
        startPoint: .top,
        endPoint: .bottom
      )
      .ignoresSafeArea()
      
      // MARK: - INTERFACE
      VStack(alignment: .center, spacing: 5) {
        // MARK: - HEADER
        LogoView()
        
        Spacer()
        
        // MARK: - SCORE
        HStack {
          HStack {
            Text("Your\nCoins".uppercased())
              .scoreLabelStyle()
              .multilineTextAlignment(.trailing)
            
            Text("\(coins)")
              .scoreNumberStyle()
              .modifier(ScoreNumberModifier())
          }
          .modifier(ScoreContainerModifier())
          
          Spacer()
          
          HStack {
            Text("\(highscore)")
              .scoreNumberStyle()
              .modifier(ScoreNumberModifier())
            
            Text("High\nScore".uppercased())
              .scoreLabelStyle()
              .multilineTextAlignment(.leading)
          }
          .modifier(ScoreContainerModifier())
        }
        
        // MARK: - SLOT MACHINE
        VStack(alignment: .center, spacing: 0) {
          // REEL #1
          ZStack {
            ReelView()
            
            Image(symbols[reels[0]])
              .resizable()
              .modifier(ImageModifier())
              .opacity(animatingSymbol ? 1 : 0)
              .offset(y: animatingSymbol ? 0 : -50)
              .animation(.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingSymbol)
              .onAppear {
                animatingSymbol.toggle()
                playSound(sound: "riseup", type: "mp3")
              }
          } //: ZSTACK
          
          HStack(alignment: .center, spacing: 0) {
            // REEL #2
            ZStack {
              ReelView()
              
              Image(symbols[reels[1]])
                .resizable()
                .modifier(ImageModifier())
                .opacity(animatingSymbol ? 1 : 0)
                .offset(y: animatingSymbol ? 0 : -50)
                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingSymbol)
                .onAppear {
                  animatingSymbol.toggle()
                }
            } //: ZSTACK
            
            Spacer()
            
            // REEL #3
            ZStack {
              ReelView()
              
              Image(symbols[reels[2]])
                .resizable()
                .modifier(ImageModifier())
                .opacity(animatingSymbol ? 1 : 0)
                .offset(y: animatingSymbol ? 0 : -50)
                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)), value: animatingSymbol)
                .onAppear {
                  animatingSymbol.toggle()
                }
            } //: ZSTACK
          } //: HSTACK
          .frame(maxWidth: 500)
          
          // SPIN BUTTON
          Button {
            withAnimation {
              animatingSymbol = false
            }
            spinReels()
            withAnimation {
              animatingSymbol = true
            }
            checkWinning()
            isGameOver()
            playSound(sound: "spin", type: "mp3")
          } label: {
            Image("gfx-spin")
              .renderingMode(.original)
              .resizable()
              .modifier(ImageModifier())
          } //: BUTTON
        } //: VSTACK
        .layoutPriority(2)
        
        // MARK: - FOOTER
        Spacer()
        
        HStack {
          // BET 20
          HStack(alignment: .center, spacing: 10) {
            Button {
              activateBet20()
            } label: {
              Text("20")
                .fontWeight(.heavy)
                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : .white)
                .modifier(BetNumberModifier())
            } //: BUTTON
            .modifier(BetCapsuleModifier())
            
            Image("gfx-casino-chips")
              .resizable()
              .opacity(isActiveBet20 ? 1 : 0)
              .offset(x: isActiveBet20 ? 0 : 20)
              .modifier(CasinoChipsModifier())
              .animation(.easeOut, value: isActiveBet20)
          } //: HSTACK
          
          Spacer()
          
          // BET 10
          HStack(alignment: .center, spacing: 10) {
            Image("gfx-casino-chips")
              .resizable()
              .opacity(isActiveBet10 ? 1 : 0)
              .offset(x: isActiveBet10 ? 0 : -20)
              .modifier(CasinoChipsModifier())
              .animation(.easeOut, value: isActiveBet10)
            
            Button {
              activateBet10()
            } label: {
              Text("10")
                .fontWeight(.heavy)
                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : .white)
                .modifier(BetNumberModifier())
            } //: BUTTON
            .modifier(BetCapsuleModifier())
          } //: HSTACK
        } //: HSTACK
      } //: VSTACK
      .overlay(alignment: .topLeading, content: {
        Button {
          resetGame()
        } label: {
          Image(systemName: "arrow.2.circlepath.circle")
        }
        .modifier(ButtonModifier())
      }) //: RESET BUTTON
      .overlay(alignment: .topTrailing, content: {
        Button {
          showingInfoView = true
        } label: {
          Image(systemName: "info.circle")
        }
        .modifier(ButtonModifier())
      }) //: INFO BUTTON
      .padding()
      .frame(maxWidth: 720)
      .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
      
      // MARK: - POPUP
      if $showingModal.wrappedValue {
        ZStack {
          Color("ColorTransparentBlack")
            .ignoresSafeArea()
          
          // MODAL
          VStack(spacing: 0) {
            // TITLE
            Text("GAME OVER")
              .font(.system(.title, design: .rounded))
              .fontWeight(.heavy)
              .frame(maxWidth: .infinity)
              .padding()
              .background {
                Color("ColorPink")
              }
              .foregroundColor(.white)
            
            Spacer()
            
            // MESSAGE
            VStack(alignment: .center, spacing: 16) {
              Image("gfx-seven-reel")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 72)
              
              Text("Bad luck! You lost all of the coins. \nLet's play again!")
                .font(.system(.body, design: .rounded))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .layoutPriority(1)
              
              Button {
                showingModal = false
                animatingModal = false
                activateBet10()
                coins = 100
              } label: {
                Text("New Game".uppercased())
                  .accentColor(Color("ColorPink"))
                  .font(.system(.body, design: .rounded))
                  .fontWeight(.semibold)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 8)
                  .frame(minWidth: 128)
                  .background {
                    Capsule()
                      .strokeBorder(lineWidth: 1.75)
                      .foregroundColor(Color("ColorPink"))
                  }
              }
            } //: VSTACK
            
            Spacer()
          } //: VSTACK
          .frame(
            minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center
          )
          .background(content: {
            Color.white
          })
          .cornerRadius(20)
          .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
          .opacity($animatingModal.wrappedValue ? 1 : 0)
          .offset(y: $animatingModal.wrappedValue ? 0 : -100)
          .animation(.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0), value: animatingModal)
          .onAppear {
            animatingModal = true
          }
        } //: ZSTACK
      } //: IF STATEMENT
    } //: ZSTACK
    .sheet(isPresented: $showingInfoView) {
      InfoView()
    }
  }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
