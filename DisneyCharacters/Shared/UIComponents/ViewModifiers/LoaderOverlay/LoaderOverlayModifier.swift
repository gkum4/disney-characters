//
//  LoaderOverlayModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import SwiftUI

struct LoaderOverlayModifier: ViewModifier {
    private let loading: Bool
    private let interactionEnabled: Bool
    
    init(loading: Bool, interactionEnabled: Bool = false) {
        self.loading = loading
        self.interactionEnabled = interactionEnabled
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if loading {
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .allowsHitTesting(loading ? interactionEnabled : true)
    }
}

#Preview {
    VStack {}
    .modifier(LoaderOverlayModifier(loading: true))
}
