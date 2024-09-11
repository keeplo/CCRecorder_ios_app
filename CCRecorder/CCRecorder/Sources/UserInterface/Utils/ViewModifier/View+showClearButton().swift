//
//  View+showClearButton().swift
//  CCRecorder
//
//  Created by 김용우 on 9/11/24.
//

import SwiftUI

extension View {
    
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(text: text))
    }
    
}

struct TextFieldClearButton: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if !text.isEmpty {
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                text = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                            }
                        )
                        .foregroundColor(.secondary)
                        .padding(.trailing, 4)
                    }
                }
            }
    }
}
