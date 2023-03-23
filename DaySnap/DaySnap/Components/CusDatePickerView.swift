//
//  CusDatePickerView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/13.
//

import SwiftUI

struct CusDatePickerView: View {
    @Binding var selectedDate: Date
    var iconName: String = "calendar"
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
            
            Text("选择时间")
                .lineLimit(1)
                .foregroundColor(.black.opacity(0.25))
            
            Spacer()
            
            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                .labelsHidden()
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
    }
}

struct CusDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CusDatePickerView(selectedDate: .constant(Date()))
    }
}
