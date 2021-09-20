//
//  ToDoList.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-17.
//

import SwiftUI

struct ToDoList: View {
    //@State private var projectName: String = ""
    @State private var subtask: String = ""
    @State private var dueDate = Date()
    @StateObject var taskViewModel = TasksViewModel()
    
    @State private var isEditing = false
    

    func createFormatter() -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        let datetime = formatter.string(from: now)
        return datetime
        
    }

    
    var body: some View {

        VStack(alignment: .leading){
            // Title of the project
            
            Text("New Tasks/Assignments To Plan").textFieldStyle(PlainTextFieldStyle()).font(Font.system(size: 20, design: .default)).padding(20)
            
            
            Text(createFormatter()).frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
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
            
        }.frame( alignment: .center)
            
            
            
        }
    }

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList()
    }
}
