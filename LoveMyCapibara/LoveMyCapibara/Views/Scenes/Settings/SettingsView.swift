import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Configurações")
                    .font(FontManager.poppinsBold(size: 32))
                    .foregroundColor(Color("PrimaryText"))
                Text("APARÊNCIA")
                    .font(FontManager.poppinsBold(size: 11))
                    .foregroundColor(Color("PrimaryText"))
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 80))
            
            ThemesSelector()
            
            Spacer()
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct ThemesSelector: View {
    @State var selectedOption = 1
    
    var body: some View {
        HStack(alignment: .center, spacing: 40) {
            ThemeOption(imageName: "DefaultTheme", label: "Sistema", selectedID: $selectedOption, id: 1)
            ThemeOption(imageName: "LightModeTheme", label: "Light", selectedID: $selectedOption, id: 2)
            ThemeOption(imageName: "Dark mode", label: "Dark", selectedID: $selectedOption, id: 3)
        }
    }
}

struct ThemeOption: View {
    var imageName: String
    var label: String
    @Binding var selectedID: Int
    var id: Int
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 160)
            Text(label)
                .font(FontManager.poppinsRegular(size: 13))
                .foregroundColor(Color("PrimaryText"))
            if selectedID == id {
                Image("Icon Select _ Selected")
                    .resizable()
                    .frame(width: 20, height: 20)
            } else {
                Circle()
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color("PrimaryColor"))
                    )
                    .foregroundColor(.clear)
            }
        }.onTapGesture {
            selectedID = id
        }
    }
}
