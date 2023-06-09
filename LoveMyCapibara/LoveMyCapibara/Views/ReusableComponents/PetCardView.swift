//
//  PetCardView.swift
//  LoveMyCapibara
//
//  Created by userext on 25/05/23.
//

import SwiftUI

struct PetCardView: View {
    var petName: String
    var petSpecies: String
    var petImage: Data?
    
    var body: some View {
            HStack {
                if let data = petImage, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(Circle())
                        .padding(.trailing, 4)
                        .frame(width: 80, height: 80)
                } else {
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                }
                VStack(alignment: .leading) {
                    Text(petName)
                        .font(FontManager.poppinsBold(size: 16))
                        .foregroundColor(Color("PrimaryText"))
                    Text(petSpecies)
                        .font(FontManager.poppinsRegular(size: 13))
                        .foregroundColor(Color("PrimaryText"))
                }
                
                Spacer()
                
                Image("ArrowRight")
            }
            .frame(alignment: .leading)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color("CardBorderColor"), lineWidth: 2))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("CardBackgroundColor"))
            )
    }
}

struct PetCardView_Previews: PreviewProvider {
    static var previews: some View {
        PetCardView(petName: "Bud", petSpecies: "Husky Siberiano", petImage: Data())
    }
}
