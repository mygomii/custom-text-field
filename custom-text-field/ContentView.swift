//
//  ContentView.swift
//  custom-text-field
//
//  Created by mijeong ko on 2022/09/06.
//

import SwiftUI

struct ContentView: View {
    @State var message1: String = ""
    @State var message2: String = ""
    
    var body: some View {
        VStack {
            TextEditorView(message: $message1, hint: "입력하세요", lineLimit: 10, height: 100)
            
            EditText(text: $message2,
                     didStartEditing: .constant(true),
                     textSize: 14,
                     placeHolder:  "입력하세요",
                     limitLine: 9,
                     dynamicHeight: true,
                     fixedWidth: 270)
            .padding(14)
            .background(.red)
            .padding(3)
            
        }.frame(width: .infinity, alignment: .top)
        
        
        
                            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(message: "")
    }
}
