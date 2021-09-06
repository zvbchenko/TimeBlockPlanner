//
//  EmptyProject.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-05.
//

import SwiftUI


struct EmptyProject: View {
    @State private var projectName: String = ""
    var body: some View {
        VStack{
            // Title of the project
            
                
            TextField("Untitled Project",
                          text: $projectName).textFieldStyle(PlainTextFieldStyle()).font(Font.system(size: 30, design: .default))
            
            
            
            Text("Project Plan")
        }.multilineTextAlignment(.center)
        
    }
}

// Gets Rid of blue focus ring of a textfield
extension NSTextField {
        open override var focusRingType: NSFocusRingType {
                get { .none }
                set { }
        }
}

struct EmptyProject_Previews: PreviewProvider {
    static var previews: some View {
        EmptyProject()
    }
}
