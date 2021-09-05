//
//  ContentView.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-04.
//

import SwiftUI


struct ContentView: View {
    @State private var showSchedule = true
    var body: some View {
        
            
            if showSchedule {
                NavigationView {
                    ProjectListView()
                    MainView()
                    ScheduleView()
                }.toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: toggleSidebar, label: {
                            Image(systemName: "sidebar.leading")
                        })
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {showSchedule.toggle()}, label: {
                            Image(systemName: "sidebar.trailing")
                        })
                    }
                }
            }else{
                NavigationView {
                    ProjectListView()
                    MainView()
                }.toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: toggleSidebar, label: {
                            Image(systemName: "sidebar.leading")
                        })
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {showSchedule.toggle()}, label: {
                            Image(systemName: "sidebar.trailing")
                        })
                    }
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
private func toggleSchedule() {
       #if os(iOS)
       #else
       #endif
}


struct ScheduleView: View{
    var body:some View{
        Text("schedule")
    }
}
struct MainView: View{
    var body:some View{
        Text("project description/Todo tasks")
    }
}

struct ProjectListView: View{
    var body:some View{
        VStack(alignment: .leading,
               spacing: 10){
            Text("projectlist").padding()
            Divider()
            ForEach(1...5,
                        id: \.self
                    ) {
                        Text("Item \($0)")
            }
               }.padding().offset(y:-100)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
