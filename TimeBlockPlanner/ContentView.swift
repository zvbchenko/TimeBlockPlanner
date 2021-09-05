//
//  ContentView.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
