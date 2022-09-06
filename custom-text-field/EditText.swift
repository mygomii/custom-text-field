//
//  EditText.swift
//  custom-text-field
//
//  Created by mijeong ko on 2022/09/06.
//

import SwiftUI

struct EditText: UIViewRepresentable {
    @Binding var text: String
    @Binding var didStartEditing: Bool

    var textSize: Int
    var placeHolder: String
    var limitLine: Int = 0
    var maxLength: Int = 0
    var keyboardType: UIKeyboardType = .default
    var focused: Bool = false
    var isEditable: Bool = true
    var dynamicHeight: Bool = false
    var fixedWidth: CGFloat = 0

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()

        textView.delegate = context.coordinator

        textView.font = .systemFont(ofSize: CGFloat(textSize))
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.keyboardType = keyboardType
        textView.isEditable = isEditable

        if (dynamicHeight) {
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.widthAnchor.constraint(equalToConstant: fixedWidth - 30).isActive = true
            textView.isScrollEnabled = false
        }

        if (focused) {
            textView.becomeFirstResponder()
        }


        if (limitLine > 0) {
            textView.textContainer.maximumNumberOfLines = limitLine
        }
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if (didStartEditing) {
            uiView.text = text
            uiView.textColor = .black
            uiView.font = .systemFont(ofSize: CGFloat(textSize))
        } else {
            uiView.text = placeHolder
            uiView.textColor = .gray
            uiView.font = .systemFont(ofSize: CGFloat(textSize))
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator($text, limitLine, maxLength, dynamicHeight)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var limitLine: Int
        var maxLength: Int
        var dynamicHeight: Bool

        init(_ text: Binding<String>, _ limitLine: Int, _ maxLength: Int, _ dynamicHeight: Bool) {
            self.limitLine = limitLine
            self.text = text
            self.maxLength = maxLength
            self.dynamicHeight = dynamicHeight
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if (maxLength == 0) {
                return true
            } else {
                guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
                    return false
                }

                let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
                return newText.count <= maxLength
            }
        }


        func textViewDidChange(_ textView: UITextView) {
            let line = textView.contentSize.height / (textView.font?.lineHeight ?? 0)
            let floor = floor(line)
            let currentLine = Int(floor)

            if (limitLine == 0) {
                text.wrappedValue = textView.text
            } else {
                if (currentLine <= limitLine) {
                    text.wrappedValue = textView.text
                } else {
                    text.wrappedValue = textView.text
                }
            }
        }
    }
}
