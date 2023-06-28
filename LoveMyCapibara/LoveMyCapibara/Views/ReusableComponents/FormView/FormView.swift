//
//  FormView.swift
//  LoveMyCapibara
//
//  Created by Maurício de Moura on 07/06/23.
//

import SwiftUI

struct FormView: View {
    @EnvironmentObject var viewModel: FormViewModel
    
    func renderLine() -> some View{
        Divider()
            .padding(EdgeInsets(top: 0, leading: -16, bottom: 0, trailing: -16))
            .offset(y: -2)
    }
    
    var body: some View {
        ScrollView{
            VStack{
                
                ImagePicker(currentImage: $viewModel.pet.imageName)
                    .padding(.bottom, 36)
                
                Group{
                    VStack{
                        InputText(placeholder: "Nome do pet", value: $viewModel.pet.name)
                            .foregroundColor(Color("SecondaryText"))
                        renderLine()
                        
                        InputPicker(label: "Gênero", value: $viewModel.pet.gender, options: GenderModel.allCases)
                        renderLine()
                        
                        InputPicker(label: "Espécie", value: $viewModel.pet.specie, options: viewModel.speciesOptions)
                        renderLine()
                        
                        InputPicker(label: "Raça", value: $viewModel.pet.race, options: viewModel.getRaces())
                        renderLine()
                        
                        DatePickerView(birthdayDate: $viewModel.pet.birthDate)
                    }
                    
                    VStack{
                        ButtonWeightPicker(weight: $viewModel.pet.weight)
                        renderLine()
        
                        InputPicker(label: "Castrado(a)?", value: $viewModel.pet.castrated, options: [false, true])
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color("FieldBackgroundColor"))
                .font(FontManager.poppinsRegular(size: 16))
                .foregroundColor(Color("PrimaryText"))
                .cornerRadius(16)
            }
            .padding(.horizontal)
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static private var viewModel = FormViewModel()
    
    static var previews: some View {
        FormView()
            .environmentObject(FormViewModel())
    }
}
