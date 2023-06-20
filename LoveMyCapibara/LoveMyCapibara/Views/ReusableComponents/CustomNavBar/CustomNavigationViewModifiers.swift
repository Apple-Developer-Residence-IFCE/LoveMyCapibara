//
//  SwiftUIView.swift
//  LoveMyCapibara
//
//  Created by José Winny on 16/06/23.
//


import SwiftUI


struct NavBarViewPet: ViewModifier {
    @State var isShowingSheet = false
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(false)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pets")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Adicionar"){
                        isShowingSheet.toggle()
                    }.sheet(isPresented: $isShowingSheet) {
                        //TO-DO adicionar o sheet do add form.
                        Text("Hi")
                    }
                    
                }
            }
    }
}


struct NavBarViewInfoPet: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    @State var isShowingSheet = false
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image("BackArrow")
                            Text("Pets")
                        }
                    }
                    
                }
                ToolbarItem(placement: .principal) {
                    Text("Informações do pet")
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Editar"){
                        isShowingSheet.toggle()
                    }.sheet(isPresented: $isShowingSheet) {
//                        EditPetView()
                        Text("HI")
                    }
                }
            }
    }
}

struct NavBarViewAddPet: ViewModifier {
    var action : () -> Void
    @State var isShowingSheet = true
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar"){
                        isShowingSheet.toggle()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Adicionar Pet")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Adicionar"){
                        action()
                    }
                }
            }
    }
}

struct NavBarViewEditPet: ViewModifier {
    @State var isShowingSheet = true
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar"){
                        isShowingSheet.toggle()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Editar Pet")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar"){
                        //TO-DO: Colocar a funçao de Update do Core Data
                    }
                }
            }
    }
}


extension View {
    ///This modifiers need to be use in the last line of NavigationView.
    ///- Important This modifier needs a NavigationView
    func navBarPet() -> some View{
        self.modifier(NavBarViewPet())
    }
    ///This modifiers need to be use in the last line of NavigationView.
    ///- Important This modifier needs a NavigationView
    func navBarInfoPet() -> some View{
        self.modifier(NavBarViewInfoPet())
    }
    ///This modifiers need to be use in the last line of NavigationView.
    ///- Important This modifier needs a NavigationView
    func navBarAddPet(action: @escaping ()->Void) -> some View{
        self.modifier(NavBarViewAddPet(action: action))
    }
    ///This modifiers need to be use in the last line of NavigationView.
    ///- Important This modifier needs a NavigationView
    func navBarEditPet() -> some View{
        self.modifier(NavBarViewEditPet())
    }
}
