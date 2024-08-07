//
//  CharactersScreen.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 05.08.2024.
//

import SwiftUI

struct CharactersScreen: View {
    
    @StateObject private var viewModel: RickAndMortyViewModel = RickAndMortyViewModel()
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.characterState {
                case .initial:
                    ProgressView()
                case .loading:
                    ProgressView()
                case .error(let errorMessage):
                    Text(errorMessage)
                case .loaded(let characters):
                    ScrollView {
                        ForEach(characters.results) { result in
                            HStack {
                                AsyncImage(url: URL(string: result.image)) { image in
                                    image.resizable()
                                        .cornerRadius(30)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
                                VStack(alignment: .leading) {
                                    Text(result.name)
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    Text(result.gender)
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                Text(result.species)
                                    .font(.footnote)
                                    .fontWeight(.light)
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Characters")
         }
    }
}

#Preview {
    CharactersScreen()
}
