//
//  ToastModifier.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toastMessage: String?
    
    @State private var opacity: CGFloat = 0
    
    func getToast(_ message: String) -> some View {
        Text(message)
            .padding(.horizontal)
            .padding(.vertical, ToastModifierMetrics.smallPadding)
            .background(Color(Colors.gray6))
            .clipShape(.capsule(style: .circular))
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if let message = toastMessage {
                    VStack {
                        Spacer()
                        getToast(message)
                            .padding()
                    }
                    .opacity(opacity)
                    .onAppear {
                        withAnimation {
                            opacity = 0.8
                        }
                        
                        Task {
                            try await Task.sleep(for: .seconds(4))
                            
                            await MainActor.run {
                                withAnimation {
                                    opacity = 0
                                    toastMessage = nil
                                }
                            }
                        }
                    }
                }
            }
    }
}


#if DEBUG
struct ToastModifier_Previews: PreviewProvider {
    struct ContainerView: View {
        @State private var toastMessage: String?
            
        var body: some View {
            VStack {
                Button("Mostrar toast") {
                    toastMessage = "Meu toast"
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(ToastModifier(toastMessage: $toastMessage))
        }
    }
    
    static var previews: some View {
        ContainerView()
    }
}
#endif
