//
//  MyListReviewAlertModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 03/01/25.
//

import SwiftUI

typealias MyListReviewAlertModifierAction = (_ mediaItem: DisneyMediaItem, _ reviewScore: DisneyMediaItemReviewScore) -> Void

struct MyListReviewAlertModifier: ViewModifier {
    @Binding private var selectedMediaItem: DisneyMediaItem?
    private let action: MyListReviewAlertModifierAction
    
    init(selectedMediaItem: Binding<DisneyMediaItem?>, action: @escaping MyListReviewAlertModifierAction) {
        self._selectedMediaItem = selectedMediaItem
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .alert(
                getAlertTitle(),
                isPresented: Binding(
                    get: { selectedMediaItem != nil },
                    set: { _ in selectedMediaItem = nil }
                ),
                presenting: selectedMediaItem,
                actions: { mediaItem in
                    ForEach(
                        DisneyMediaItemReviewScore.allCases.reversed(),
                        id: \.self
                    ) { reviewScore in
                        Button {
                            action(mediaItem, reviewScore)
                        } label: {
                            Text([String](repeating: "⭐️", count: reviewScore.rawValue).joined())
                        }

                    }
                }
            )
    }
}

extension MyListReviewAlertModifier {
    private func getAlertTitle() -> String {
        guard let selectedMediaItem else { return "Dê uma nota" }
        return "Dê uma nota para \(selectedMediaItem.name)"
    }
}

#if DEBUG
struct MyListReviewAlertModifier_Previews: PreviewProvider {
    struct ContainerView: View {
        @State private var selectedMediaItem: DisneyMediaItem?
            
        var body: some View {
            VStack {
                Button("Mostrar review alert") {
                    selectedMediaItem = .mock()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(
                MyListReviewAlertModifier(
                    selectedMediaItem: $selectedMediaItem
                ) { mediaItem, review in
                    print(review)
                }
            )
        }
    }
    
    static var previews: some View {
        ContainerView()
    }
}
#endif
