//
//  DaySchedule.swift
//  TimeBlockPlanner
//
//  Created by Anton Zubchenko on 2021-09-26.
//

import SwiftUI

struct DaySchedule: View {

    
    
    func createTimeSlots() -> [String]{
    
        var array: [String] = []

        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm a"

        let startDate = "6:00 AM"
        let endDate = "11:30 PM"

        let date1 = formatter.date(from: startDate)
        let date2 = formatter.date(from: endDate)

        var i = 1
        var date = date1
        while true {
                date = date1?.addingTimeInterval(TimeInterval(i*30*60))
            let string = formatter2.string(from: date!)
            i += 1
            if date! >= date2! {
                break
            }
            array.append(string)
        }
        return array
    }
    

        

    
    
    var body: some View {
        VStack{
            List(createTimeSlots(), id: \.self) { timeslot in
                Text(timeslot)
                  }
            
            Spacer()
        }

        
    }
}

struct DaySchedule_Previews: PreviewProvider {
    static var previews: some View {
        DaySchedule()
    }
}
