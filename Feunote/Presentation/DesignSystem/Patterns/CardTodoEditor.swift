//
//  SwiftUIView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct EWCardTodoEditor: View {
    
    @Binding var content: String?
    @Binding var description: String?
    @Binding var start: Date?
    @Binding var end: Date?
    var contentPlaceholder:String = "What is Your Goal"
    var descriptionPlaceholder:String = "Detail Description..."
    
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge){
            EWTextField(input: $content ?? "", icon: nil, placeholder: contentPlaceholder)
            EWTextField(input: $description ?? "", icon: nil, placeholder: descriptionPlaceholder)
            HStack(alignment: .top, spacing: .ewPaddingHorizontalLarge) {
                Image("date")
                    .foregroundColor(.ewGray100)
                    .cornerRadius(.ewCornerRadiusRound)
                    .foregroundColor(.ewGray50)
                
                VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
                    Text("Start Date").font(.ewFootnote).foregroundColor(.ewGray900)
                    DatePicker("DatePicker", selection: $start ?? Date.now, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                }
                
            }
        }

    }
}

struct EWCardTodoEditor_Previews: PreviewProvider {
    @State static var content:String?
    @State static var description:String?
    @State static var start:Date?
    @State static var end:Date? //Date.now.advanced(by: TimeInterval.hours(1))

    
    static var previews: some View {
        EWCardTodoEditor(content: $content, description: $description, start: $start, end: $end)
    }
}
