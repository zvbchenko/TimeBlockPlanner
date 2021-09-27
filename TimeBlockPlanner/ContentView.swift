//
//  ContentView.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-04.
//

import SwiftUI



struct ContentView: View {
    
    @State private var showSchedule = false
    var body: some View {
        
        NavigationView{
            
            ProjectListView(showSchedule:$showSchedule)
            HStack{
                MainView().offset(y: 120)
                if showSchedule{
                    Divider()
                    ScheduleView().frame(minWidth: 50, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                            
            }
            
        }.frame(minWidth: 600, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity).toolbar{
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
            ToolbarItem(placement: .primaryAction) {
                Button(action: {withAnimation {showSchedule.toggle()}}, label: {
                    Image(systemName: "sidebar.trailing")
                })
            }

        }
        
    }
}


private func toggleSidebar() {
       #if os(iOS)
       #else
       NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
       #endif
}



struct ScheduleView: View{
    var body:some View{
        DaySchedule()
    }
}
struct MainView: View{
    var body:some View{
        //Text("project description/Todo tasks")
        EmptyProject().padding().offset(y:-100)
        
        
    }
}




struct CreateEmptyProject:View{
    @Binding var showSchedule : Bool
    
    var body:some View{
        //Text("project description/Todo tasks")
        HStack{
            MainView().offset(y: 120)
            if showSchedule{
                Divider()
                ScheduleView().frame(minWidth: 50, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
                        
        }
    }
}


struct Project: Identifiable, Equatable, Hashable  {
    var id = UUID()
    var name: String
}




struct ToDoToday:View{
    @Binding var showSchedule: Bool
    
    @State var projects = [Project(name: "A"), Project(name: "B"), Project(name: "C"), Project(name: "D")]
    @State private var dragging: Project?
    var body:some View{
        HStack{
            ToDoList().offset(y: 0)
            Divider()
            // make a draggable list here
            List{
                ForEach(projects,
                            id: \.self
                        ) { project in
                    project_item( project: project).onDrag{
                        self.dragging = project
                        return NSItemProvider(object: project.name as NSString)
                        
                    }.onDrop(of: ["public.text"], delegate: MyDropDelegate(item: project, listData: $projects, current: $dragging))
                }
            }
            
            if showSchedule{
                Divider()
                ScheduleView().frame(minWidth: 50, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
                        
        }
        
        
    }
}

struct project_item: View{
    
    @State var project: Project
    
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

                } label:{
                    Image(systemName: self.isClicked == true ? "checkmark.circle.fill" : "circle").resizable().opacity(1.0).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).colorScheme(.light)
                }.padding(25).opacity(1.0)
                VStack (alignment: .leading){
                    Text("\(project.name)").font(.headline)
                        .lineLimit(1).foregroundColor(.black).textFieldStyle(PlainTextFieldStyle())
                }.padding(25)
                Spacer()
            }
            )
        }.padding(.vertical, -18)
        
        
    }
}






struct MyDropDelegate: DropDelegate {
    let item: Project
    @Binding var listData: [Project]
    @Binding var current: Project?
    
    func dropEntered(info: DropInfo) {
        if item != current {
              let from = listData.firstIndex(of: current!)!
              let to = listData.firstIndex(of: item)!
              if listData[to] != current! {
                  listData.move(fromOffsets: IndexSet(integer: from),
                      toOffset: to > from ? to + 1 : to)
              }
    }
    }
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }


    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}

struct ProjectListView: View{
    @Binding var showSchedule : Bool
    var body:some View{
        VStack(alignment: .center,
               spacing: 0){
            NavigationLink(destination: ToDoToday(showSchedule: $showSchedule).padding()) {
                Text("To-Do")
            }.buttonStyle(BorderlessButtonStyle())
            NavigationLink(destination: CreateEmptyProject(showSchedule: $showSchedule).padding()) {
                Text("New Project/Assignment")
            }.buttonStyle(BorderlessButtonStyle()).padding()
            
            Divider()
            List{
                ForEach(1...100,
                            id: \.self
                        ) {
                            Text("Item \($0)")
                }
            }

            Spacer()
               }.padding().offset(y:-10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
