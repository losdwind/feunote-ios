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
            EWTextFieldMultiline(input: $description ?? "", placeholder: descriptionPlaceholder)
            
            VStack(alignment: .leading, spacing: .ewPaddingHorizontalSmall) {
                HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                    HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall){
                        Image("date")
                            .foregroundColor(.ewGray100)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Start")
                            .font(.ewSubheadline)
                            .foregroundColor(.ewGray900)
                            .frame(width: 50, alignment: .leading)
                    }
                    
                        DatePicker("Start DatePicker", selection: $start ?? Date.now, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(.automatic)
                            .labelsHidden()
                    
                }
                
                HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                    HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall){
                        Image("date")
                            .foregroundColor(.ewGray100)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("End")
                            .font(.ewSubheadline)
                            .foregroundColor(.ewGray900)
                            .frame(width: 50, alignment: .leading)

                    }
                    
                    
                    DatePicker("End DatePicker", selection: $end ?? Date.now, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.automatic)
                        .labelsHidden()
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
