//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 25.07.2024.
//

import SwiftUI

struct MainTabView: View {
    
    @State var tabSelected: Int = 1
    
    var body: some View {
        TabView(selection: $tabSelected) {
            CharactersScreen()
                .tabItem {
                    Label("Characters",
                          systemImage: "person.3.sequence.fill")
                }
                .tag(0)
            SuffixArrayScreen()
                .tabItem {
                    Label("Suffix search", systemImage: "magnifyingglass.circle.fill")
                }
                .tag(1)
        }
        
    }
}

#Preview {
    MainTabView()
}
