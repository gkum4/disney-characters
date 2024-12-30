//
//  DisneyCharacterDetailsMediaButtonItemView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

struct DisneyCharacterDetailsMediaButtonItemView: View {
    let name: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(name)
                .foregroundStyle(.foreground)
                .font(.headline)
                .padding(DisneyCharacterDetailsMetrics.MediaButtonItem.padding)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.red)
                .clipShape(.rect(cornerRadius: GlobalLayoutMetrics.cornerRadius))
        }
    }
}

#Preview {
    DisneyCharacterDetailsMediaButtonItemView(
        name: "Tangled: Before Ever After", 
        action: {}
    )
    .padding()
}
