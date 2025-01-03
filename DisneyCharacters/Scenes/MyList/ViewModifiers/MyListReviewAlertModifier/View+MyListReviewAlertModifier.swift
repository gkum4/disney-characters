//
//  View+MyListReviewAlertModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 03/01/25.
//

import SwiftUI

extension View {
    func myListReviewAlert(
        selectedMediaItem: Binding<DisneyMediaItem?>,
        action: @escaping MyListReviewAlertModifierAction
    ) -> some View {
        self.modifier(
            MyListReviewAlertModifier(
                selectedMediaItem: selectedMediaItem,
                action: action
            )
        )
    }
}
