//
//  ContentView.swift
//  LoveMyCapibara
//
//  Created by userext on 25/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Pets", systemImage: "pawprint")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                
                SettingsView()
                    .tabItem {
                        Label("Configurações", systemImage: "gearshape")
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                
                TaskDetailsView()
                    .tabItem {
                        Text("Texto")
                    }
            }
            .tint(Color("DarkColor"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
