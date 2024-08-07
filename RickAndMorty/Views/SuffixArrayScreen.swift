//
//  SuffixArrayScreen.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 05.08.2024.
//

import SwiftUI

private enum Constants {
    static let placeholder: String = "e.g. \"abracadabra\""
    static let picker: String = "Picker"
    static let allSegment: String = "All suffixes"
    static let topSegment: String = "Top 10 popular suffixes"
    static let ascSortType: String = "ASC"
    static let descSortType: String = "DESC"
}

enum SegmentedType {
    case all
    case top
}

struct SuffixArrayScreen: View {
    
    @State private var segmentedType: SegmentedType = .all
    @State var suffixSortType: SortType = .ASC
    @ObservedObject var viewModel = SuffixArrayViewModel()
    
    var body: some View {
        VStack {
            TextField(Constants.placeholder, text: $viewModel.searchText)
                .padding()
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            Picker(Constants.picker, selection: $segmentedType) {
                Text(Constants.allSegment).tag(SegmentedType.all)
                Text(Constants.topSegment).tag(SegmentedType.top)
            }
            .padding([.leading, .trailing], 16)
            .pickerStyle(.segmented)
            
            switch segmentedType {
            case .all:
                List(viewModel.allSuffixes, id:\.key) { key, value in
                    HStack {
                        Text(key)
                        Spacer()
                        Text("\(value)")
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                
                Button {
                    suffixSortType = suffixSortType == .ASC ? .DESC : .ASC
                    viewModel.sortSuffixes(by: suffixSortType)
                    
                } label: {
                    Text(suffixSortType == .ASC ? Constants.ascSortType : Constants.descSortType)
                }
                .padding()
            case .top:
                List(viewModel.topSuffixes, id:\.key) { key, value in
                    HStack {
                        Text(key)
                        Spacer()
                        Text("\(value)")
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    SuffixArrayScreen()
}
