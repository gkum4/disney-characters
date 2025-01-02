//
//  View+LoaderOverlayModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import SwiftUI

extension View {
    func loaderOverlay(isLoading: Bool) -> some View {
        self.modifier(LoaderOverlayModifier(loading: isLoading))
    }
}
