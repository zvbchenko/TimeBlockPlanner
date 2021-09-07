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
            
            ProjectListView()
            HStack{
                MainView().offset(y: 120)
                if showSchedule{
                    Divider()
                    ScheduleView().frame(minWidth: 50, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                            
            }.multilineTextAlignment(.center)
            
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
        Text("schedule")
    }
}
struct MainView: View{
    var body:some View{
        //Text("project description/Todo tasks")
        EmptyProject().padding().offset(y:-100)
    }
}

struct ProjectListView: View{
    var body:some View{
        VStack(alignment: .center,
               spacing: 10){
            
            Text("projectlist").padding()
            Divider()
            ForEach(1...5,
                        id: \.self
                    ) {
                        Text("Item \($0)")
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
