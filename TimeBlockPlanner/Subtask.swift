//
//  Subtask.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-07.
//

import SwiftUI


struct Subtask: View {
    @State var text: String = ""
    var placeholder: String = "Describe your Subtask"
    var body: some View {
        ZStack{
            
            if text.isEmpty {
              Text(placeholder)
                .foregroundColor(Color.primary.opacity(0.25))
                .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
                .padding(5)
            }
            TextEditor(text: $text).textFieldStyle(PlainTextFieldStyle()).font(Font.system(size: 10, design: .default))
            Text(text).opacity(0).padding(.all, 1)
        }.shadow(radius: 0)
        
        
    }
}

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear //<<here clear
            drawsBackground = true
        }

    }
}

struct Subtask_Previews: PreviewProvider {
    static var previews: some View {
        Subtask()
    }
}
