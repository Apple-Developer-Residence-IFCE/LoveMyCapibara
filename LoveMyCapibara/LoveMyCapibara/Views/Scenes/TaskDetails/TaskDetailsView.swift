//
//  TaskDetailsView.swift
//  LoveMyCapibara
//
//  Created by Maurício de Moura on 27/06/23.
//

import SwiftUI

struct TaskDetailsView: View {
    @StateObject var viewModel = TaskDetailsViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            
            Image("tortinhaImage")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
                .clipped()
                
            Group{
                
                HStack{
                    Text(viewModel.task.title)
                        .font(FontManager.poppinsBold(size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Group{
                    HStack{
                        Image("Icon Pet _ Filled2")
                        Text(viewModel.task.pet.name)
                    }
                    
                    HStack{
                        Image("Icon Calendar_Outline")
                        Text(viewModel.dateFormatted)
                    }
                    
                    HStack{
                        Image("Icon Clock_Outline")
                        Text(viewModel.timeFormatted)
                    }
                    
                    HStack{
                        Image("Icon Alarm _ Filled")
                        Text("30 min antes do horário")
                    }
                }
                .padding(.top, 8)
                
                Text(viewModel.task.description)
                    .padding(.top, 24)
                
                CustomButton(buttonLabel: "Marcar como concluída", buttonAction: { print("Check task") }, buttonColor: "DarkColor")
            }
            .padding(.horizontal, 24)
            .font(FontManager.poppinsRegular(size: 16))
            
            Spacer()
        }
        .background(Color("BackgroundColor"))
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView()
    }
}