//
//  MyListView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import SwiftUI

struct MyListView: View {
    @StateObject private var viewModel: MyListViewModel
    
    private init(viewModel: MyListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.sectionsData, id: \.mediaItemType) { sectionData in
                MyListSectionView(sectionData: sectionData)
            }
        }
        .myListReviewAlert(
            selectedMediaItem: $viewModel.selectedMediaItem,
            action: { mediaItem, reviewScore in
                Task {
                    await viewModel.setReview(for: mediaItem, of: reviewScore)
                }
            }
        )
        .loaderOverlay(isLoading: viewModel.isLoading)
        .toast($viewModel.toastMessage)
        .navigationBarBackButtonHidden()
        .navigationTitle("Minha Lista")
        .navigationBarTitleDisplayMode(.large)
        .environmentObject(viewModel)
        .task { await viewModel.setup() }
    }
}

extension MyListView {
    static func create() -> Self {
        return MyListView(viewModel: MyListViewModel())
    }
}

#Preview {
    MyListView.create()
}
