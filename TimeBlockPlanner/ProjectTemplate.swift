//
//  EmptyProject.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-05.
//

import SwiftUI


struct EmptyProject: View {
    @State private var projectName: String = ""
    @State private var dueDate = Date()
   
    var body: some View {

        VStack{
            // Title of the project
            
            TextField("Untitled Project",
                              text: $projectName).textFieldStyle(PlainTextFieldStyle()).font(Font.system(size: 30, design: .default))
            
            DatePicker(
                    "Due Date:",
                     selection: $dueDate,
                     in: dateRange,
                     displayedComponents: [.date, .hourAndMinute]
            ).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            Text("Project Plan")
            
        }
            
            
            
        }
    }


// Gets Rid of blue focus ring of a textfield
extension NSTextField {
        open override var focusRingType: NSFocusRingType {
                get { .none }
                set { }
        }
}

// Closure for Date range
let dateRange: ClosedRange<Date> = {
    let calendar = Calendar.current
    let startComponents = DateComponents(year: 2021, month: 1, day: 1)
    let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
    return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
}()

struct EmptyProject_Previews: PreviewProvider {
    static var previews: some View {
        EmptyProject()
    }
}
