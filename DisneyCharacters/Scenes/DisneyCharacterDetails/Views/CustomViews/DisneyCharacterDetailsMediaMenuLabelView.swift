//
//  DisneyCharacterDetailsMediaMenuLabelView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

struct DisneyCharacterDetailsMediaMenuLabelView: View {
    let name: String
    let mediaType: DisneyMediaItemType
    
    init(name: String, mediaType: DisneyMediaItemType) {
        self.name = name
        self.mediaType = mediaType
    }
    
    var body: some View {
        Text(name)
            .foregroundStyle(.foreground)
            .font(.headline)
            .padding(DisneyCharacterDetailsMetrics.MediaButtonItem.padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(mediaType.getBackgroundColor())
            .clipShape(.rect(cornerRadius: GlobalLayoutMetrics.cornerRadius))
    }
}
