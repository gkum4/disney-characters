//
//  View+MyListEmptyStateModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 03/01/25.
//

import SwiftUI

extension View {
    func myListEmptyState(sectionsData: [MyListSectionData], isLoading: Bool) -> some View {
        return self.modifier(MyListEmptyStateModifier(sectionsData: sectionsData, isLoading: isLoading))
    }
}
