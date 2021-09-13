//
//  ListTasks.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-12.
//

import SwiftUI



struct Task: Identifiable {
    let id = UUID()
    let description: String
    let complete: Bool
}

struct TaskRow: View {
    var task: Task
    //@State private var subtask: String =
    @State private var pic: String = "circle"
    @State var isClicked : Bool = false
    var body: some View {
        
        
        ZStack {
            Rectangle().fill(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30)
                .cornerRadius(10).shadow(color: .gray, radius: 4).padding(20)
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: nil, content:
            {
                // "add" button
                
                Button{
                    
                    self.isClicked.toggle()
                    
                } label:{
                    
                    Image(systemName: self.isClicked == true ? "checkmark.circle.fill" : "circle").resizable().opacity(1.0).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).colorScheme(.light)

                }.padding(25).opacity(1.0)
                
                
                
                VStack (alignment: .leading){
                    Text("\(task.description)").font(.headline)
                        .lineLimit(1).foregroundColor(.black).textFieldStyle(PlainTextFieldStyle())

                }.padding(25)
                Spacer()
        
            }
            )
            
        }
        
        
    }
}
struct ListTasks: View {
    let tasks = [
        Task(description: "T1", complete: false),
        Task(description: "T2", complete: false),
        Task(description: "T3", complete: false)
    ]
    
    
    var body: some View {
        List(tasks) { task in
                    TaskRow(task: task)
                }
    }
}

struct ListTasks_Previews: PreviewProvider {
    static var previews: some View {
        ListTasks()
    }
}
