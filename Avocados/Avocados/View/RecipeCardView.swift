//
//  RecipeCardView.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/29.
//

import SwiftUI

struct RecipeCardView: View {
    // MARK: - PROPERTY
    var recipe: Recipe
    var hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    @State private var showModel: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(recipe.image)
                .resizable()
                .scaledToFit()
                .overlay {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "bookmark")
                                .font(.title.weight(.bold))
                                .foregroundColor(.white)
                                .imageScale(.small)
                                .shadow(color: Color("ColorBlackTransparentLight"), radius: 2, x: 0, y: 0)
                                .padding(.trailing, 20)
                                .padding(.top, 22)
                        } //: HSTACK
                        Spacer()
                    } //: VSTACK
                } //: OVERLAY
            
            VStack(alignment: .leading, spacing: 12) {
                // TITLE
                Text(recipe.title)
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenMedium"))
                    .lineLimit(1)
                
                // HEADLINE
                Text(recipe.headline)
                    .font(.system(.body, design: .serif))
                    .foregroundColor(.gray)
                    .italic()
                
                // RATES
                RecipeRatingView(recipe: recipe)
                
                // COOKING
                RecipeCookingView(recipe: recipe)
            } //: VSTACK
            .padding()
            .padding(.bottom, 12)
        } //: VSTACK
        .background {
            Color.white
        }
        .cornerRadius(12)
        .shadow(
            color: Color("ColorBlackTransparentLight"),
            radius: 8,
            x: 0,
            y: 0
        )
        .onTapGesture {
            hapticImpact.impactOccurred()
            showModel = true
        }
        .sheet(isPresented: $showModel) {
            RecipeDetailView(recipe: recipe)
        }
    }
}

// MARK: - PREVIEW
struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: recipesData[0])
    }
}
