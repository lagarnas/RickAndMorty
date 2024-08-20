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
    static let topSegment: String = "Top 10 suffixes"
    static let historySegment: String = "History"
    static let ascSortType: String = "ASC"
    static let descSortType: String = "DESC"
}

enum SegmentedType {
    case all
    case top
    case history
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
                Text(Constants.historySegment).tag(SegmentedType.history)
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
            case .history:
                VStack {
                    List(0..<viewModel.historySuffixes.count, id:\.self) { index in
                        HStack{
                            Text(viewModel.historySuffixes[index].key)
                                .lineLimit(3)
                                .truncationMode(.middle)
                            Spacer()
                            Text("\(viewModel.historySuffixes[index].value) s")
                        }
                        .listRowBackground(getRowBackgroundColor(for: index,
                                                                 maxIndex: viewModel.historySuffixes.count - 1))
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
    
    func getRowBackgroundColor(for index: Int, maxIndex: Int) -> Color {
        let redColor = Double(index) / Double(maxIndex)
        let greenColor = 1.0 - redColor
        return Color(red: redColor, green: greenColor, blue: 0.0)
    }
}

#Preview {
    SuffixArrayScreen()
}
