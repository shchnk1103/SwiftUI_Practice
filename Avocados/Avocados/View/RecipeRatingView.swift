//
//  RecipeRatingView.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/30.
//

import SwiftUI

struct RecipeRatingView: View {
    // MARK: - PROPERTY
    var recipe: Recipe
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach(1...recipe.rating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .font(.body)
                    .foregroundColor(.yellow)
            } //: LOOP
        } //: HSTACK
    }
}

struct RecipeRatingView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRatingView(recipe: recipesData[0])
    }
}
