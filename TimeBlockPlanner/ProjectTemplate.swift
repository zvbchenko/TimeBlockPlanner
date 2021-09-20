//
//  EmptyProject.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-05.
//

import SwiftUI

class TasksViewModel: ObservableObject{
    @Published var tasks : [Task] = [
        Task(description: "T1", complete: false),
        Task(description: "T2", complete: false),
        Task(description: "T3", complete: false)
    ]
    @Published var completedTasks : [Task] = []
    
}


struct EmptyProject: View {
    @State private var projectName: String = ""
    @State private var subtask: String = ""
    @State private var dueDate = Date()
    @StateObject var taskViewModel = TasksViewModel()
    
    @State private var isEditing = false
    
    var body: some View {

        VStack(alignment: .center){
            // Title of the project
            HStack{
                
            TextField("Untitled Project",
                      text: $projectName).textFieldStyle(PlainTextFieldStyle()).font(Font.system(size: 30, design: .default)).padding(20)
                
                
                Button{
                    if !subtask.isEmpty{
                        taskViewModel.tasks.append(Task(description: subtask, complete: false))
                    }
                    
                } label:{
                    Image(systemName: "plus.rectangle.fill").resizable().foregroundColor(.blue).edgesIgnoringSafeArea(.all).imageScale(.large)
                    
                }.opacity(1.0)
                
            }
            
            DatePicker(
                    "Due Date:",
                     selection: $dueDate,
                     in: dateRange,
                     displayedComponents: [.date, .hourAndMinute]
            ).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            
            // View for holding a list of tasks
            List{
                ListTasks(taskview: taskViewModel)
                ListCompleteTasks(taskview: taskViewModel)
            }.cornerRadius(15)   
            // Defining subtasks
            ZStack {
                Rectangle().fill(Color.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30)
                    .cornerRadius(10).shadow(color: .gray, radius: 4).padding(20)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: nil, content:
                {
                    // "add" button
                    Button{
                        if !subtask.isEmpty{
                            taskViewModel.tasks.append(Task(description: subtask, complete: false))
                        }
                        
                    } label:{
                        Image(systemName: "plus").resizable().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        
                    }.padding(25).opacity(1.0)
                    
                    
                    
                    VStack (alignment: .leading){
                        TextField("Add task",text: $subtask){ isEditing in
                            self.isEditing = isEditing
                        } onCommit: {
                            if !subtask.isEmpty{
                                taskViewModel.tasks.append(Task(description: subtask, complete: false))
                                subtask = ""
                            }
                        }.font(.headline)
                            .lineLimit(1).colorScheme(.light).textFieldStyle(PlainTextFieldStyle())

                    }.padding(25)
                    Spacer()
            
                }
                )
                
            }
                
            Text("Project Plan:")
            Text("List of subtasks")
            
            Spacer() // Has to be last
            
        }.frame( alignment: .top)
            
            
            
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
