//
//  XPrimaryTextField.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import SwiftUI


struct XPrimaryTextField: TextFieldStyle {
    
    let systemImageString: String
    
    // Hidden function to conform to this protocol
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(.mainGreen),
                            Color(.mainPurple)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 40)
            
            HStack {
                Image(systemName: systemImageString)
                Divider()
                    .frame(width: 1, height: 25)
                    .background(Color.gray)
                    
                // Reference the TextField here
                configuration

   
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
}

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
                
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                }.padding(.trailing, 5)

            }.padding(.trailing, 0)

        }
    }
}
