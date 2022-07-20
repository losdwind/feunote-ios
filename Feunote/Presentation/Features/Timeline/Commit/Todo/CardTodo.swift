//
//  CardTask.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/9.
//

import SwiftUI

struct EWCardTodo: View {
    
    var content: String?
    var description: String?
    var completion: Bool?
    var start: Date?
    var end: Date?
    var action:() -> Void
    
    @State private var isCompleted:Bool?

    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
            EWRadio(isChecked: $isCompleted ?? false)
                .onTapGesture {
                        isCompleted?.toggle()
                        action()
                }
            VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                Text(content ?? "Too important, cannot say it").font(Font.ewHeadline)
                if description != nil {
                    Text(content!).font(Font.ewFootnote).foregroundColor(.ewGray900)
                }
                if start != nil {
                    Text(start!.formatted().description) .font(Font.ewFootnote).foregroundColor(.ewGray900)
                }
                if end != nil {
                    Text(end!.formatted().description).font(Font.ewFootnote).foregroundColor(.ewGray900)
                }
                
            }
            Spacer(minLength: .ewPaddingHorizontalLarge)
            
        // MARK: - Todo Add the team members
            
        }
        .onAppear(perform: {
            isCompleted = completion
        })
        .padding(.horizontal, .ewPaddingHorizontalLarge)
        .padding(.vertical, .ewPaddingVerticalLarge)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct EWCardTask_Previews: PreviewProvider {
    @State static var completion:Bool? = true
    static var previews: some View {
        EWCardTodo(content: "Research Project Upload to System", completion: completion, start: Date.init(timeIntervalSinceNow: .hours(2)), end: Date.init(timeIntervalSinceNow: .hours(3)), action: {})
            .previewLayout(.sizeThatFits)
    }
}
