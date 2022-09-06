//
//  File.swift
//  custom-text-field
//
//  Created by mijeong ko on 2022/09/06.
//

import SwiftUI


struct TextEditorView: View {
    @State private var didStartEditing: Bool = false
    @Binding var message: String
    var hint: String = ""
    var lineLimit: Int = 0
    var maxLength: Int = 0
    let height: CGFloat
    let enabledEnter: Bool = false
    var showToast: (() -> ())? = nil
    var keyboardType: UIKeyboardType = .default
    var isEditable: Bool = true

    var body: some View {
        EditText(
          text: $message,
          didStartEditing: $didStartEditing,
          textSize: 16,
          placeHolder: hint,
          limitLine: lineLimit,
          maxLength: maxLength,
          keyboardType: keyboardType,
          isEditable: isEditable
        )
           .frame(height: height, alignment: .topTrailing)
           .padding(EdgeInsets(top: 4, leading: 12, bottom: 0, trailing: 12))
           .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray))
           .onAppear {
               didStartEditing = hint.isEmpty
           }
           .onTapGesture {
               didStartEditing = true
           }
           .onChange(of: message) { (newValue: String) in
               if (message.count == maxLength) {
                   showToast?()
               }
           }
    }
}
