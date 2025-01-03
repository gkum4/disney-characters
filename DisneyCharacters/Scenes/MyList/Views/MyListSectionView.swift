//
//  MyListSectionView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 03/01/25.
//

import SwiftUI

struct MyListSectionView: View {
    @EnvironmentObject private var viewModel: MyListViewModel
    private let sectionData: MyListSectionData
    
    init(sectionData: MyListSectionData) {
        self.sectionData = sectionData
    }
    
    var body: some View {
        Section {
            ForEach(sectionData.mediaItems, id: \.name) { mediaItem in
                Button {
                    viewModel.selectedMediaItem = mediaItem
                } label: {
                    HStack(spacing: 0) {
                        Text(mediaItem.watched ? "✅" : "👀")
                            .padding(.trailing, MyListMetrics.smallPadding)
                            .onTapGesture {
                                Task {
                                    await viewModel.markWatched(mediaItem)
                                }
                            }
                        
                        Text(mediaItem.name)
                        
                        Spacer()
                        
                        if let reviewScore = mediaItem.reviewScore {
                            Text([String](repeating: "⭐️", count: reviewScore.rawValue).joined())
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .onDelete { indexSet in
                guard let index = indexSet.first else { return }
                let mediaItem = sectionData.mediaItems[index]
                
                Task {
                    await viewModel.delete(mediaItem)
                }
            }
        } header: {
            Text(sectionData.mediaItemType.getTitle())
                .fontWeight(.semibold)
                .foregroundStyle(sectionData.mediaItemType.getBackgroundColor())
        }
    }
}
