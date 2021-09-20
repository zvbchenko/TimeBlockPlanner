//
//  ListTasks.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-12.
//

import SwiftUI

struct Task: Identifiable, Equatable {
    var id = UUID()
    var description: String
    var complete: Bool
}



struct TaskRow: View {
    @State var task: Task
    
    @State var isClicked : Bool = false
    
    var body: some View {
    
        ZStack {
            Rectangle().fill(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30)
                .cornerRadius(10).shadow(color: .gray, radius: 4).padding(20)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: nil, content:
            {
                Button{
                    self.isClicked.toggle()
                    task.complete = false

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
        }.padding(.vertical, -18)
        
        
    }
}

struct ListTasks: View {
    @ObservedObject var taskview : TasksViewModel
    
    
    @State var isClicked : Bool = false
    @State var draggedTask : Task?
    var body: some View {
        
        ForEach(taskview.tasks) { task in
            ZStack {
                Rectangle().fill(Color.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30)
                    .cornerRadius(10).shadow(color: .gray, radius: 4).padding(20)
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: nil, content:
                {
                    Button{
                        guard let index = self.taskview.tasks.firstIndex(of: task) else { return }
                        self.taskview.completedTasks.append( taskview.tasks[index])
                        self.taskview.tasks.remove(at: index)

                    } label:{
                        Image(systemName: "circle").resizable().opacity(1.0).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).colorScheme(.light)
                    }.padding(25).opacity(1.0)
                    VStack (alignment: .leading){
                        Text("\(task.description)").font(.headline)
                            .lineLimit(1).foregroundColor(.black).textFieldStyle(PlainTextFieldStyle())
                    }.padding(25)
                    Spacer()
                }
                )
            }.padding(.vertical, -18)
                   
            }
                
        
    }

}




struct ListCompleteTasks: View {
    @ObservedObject var taskview : TasksViewModel
    
    
    @State var isClicked : Bool = false
    var body: some View {
            if taskview.completedTasks.count != 0 {
                
                Text("Completed").foregroundColor(.white)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background(Color.green)
                    .clipShape(Capsule())
                
                ForEach(taskview.completedTasks) { task in
                    ZStack {
                        Rectangle().fill(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30)
                            .cornerRadius(10).shadow(color: .gray, radius: 4).padding(20)
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: nil, content:
                        {
                            Button{
                                // self.isClicked.toggle()
                                //task.complete = false
                               guard let index = self.taskview.completedTasks.firstIndex(of: task) else { return }
                               self.taskview.tasks.append( taskview.completedTasks[index])
                               self.taskview.completedTasks.remove(at: index)

                            } label:{
                                Image(systemName: "checkmark.circle.fill").resizable().opacity(1.0).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).colorScheme(.light)
                            }.padding(25).opacity(1.0)
                            VStack (alignment: .leading){
                                Text("\(task.description)").font(.headline)
                                    .lineLimit(1).foregroundColor(.black).textFieldStyle(PlainTextFieldStyle())
                            }.padding(25)
                            Spacer()
                            
                            Button{
                               guard let index = self.taskview.completedTasks.firstIndex(of: task) else { return }
                               self.taskview.completedTasks.remove(at: index)

                            } label:{
                                Image(systemName: "trash.circle.fill").resizable().opacity(1.0).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).colorScheme(.light)
                            }.padding(25).opacity(1.0)
                        }
                        )
                    }.padding(.vertical, -18)
                }
                
                
                
                
            }
            }
}

