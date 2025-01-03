//
//  MyListEmptyStateModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 03/01/25.
//

import SwiftUI

struct MyListEmptyStateModifier: ViewModifier {
    private let sectionsData: [MyListSectionData]
    private let isLoading: Bool
    
    init(sectionsData: [MyListSectionData], isLoading: Bool) {
        self.sectionsData = sectionsData
        self.isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        if sectionsData.isEmpty && !isLoading {
            VStack {
                Text("Você ainda não adicionou nenhum item à Minha Lista...")
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            content
        }
    }
}
