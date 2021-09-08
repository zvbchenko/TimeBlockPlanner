//
//  Subtask.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-07.
//

import SwiftUI

struct Subtask: View {
    @State var text: String = "Describe your Subtask"
    var body: some View {
        ZStack{
            TextEditor(text: $text)
            Text(text).opacity(0).padding(.all, 1)
        }.shadow(radius: 0)
        
        
    }
}

struct Subtask_Previews: PreviewProvider {
    static var previews: some View {
        Subtask()
    }
}
