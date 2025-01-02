//
//  View+ToastModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import SwiftUI

extension View {
    func toast(_ toastMessage: Binding<String?>) -> some View {
        self.modifier(ToastModifier(toastMessage: toastMessage))
    }
}
