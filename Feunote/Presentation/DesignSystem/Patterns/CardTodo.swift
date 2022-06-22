//
//  CardTask.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/9.
//

import SwiftUI

struct EWCardTodo: View {
    
    var content: String
    var description: String?
    @Binding var completion: Bool
    var start: Date?
    var end: Date?

    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
            EWRadio(isChecked: $completion)
            VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                Text(content).font(Font.ewHeadline)
                if start != nil {
                    Text(start!.formatted()).font(Font.ewFootnote).foregroundColor(.ewGray900)
                }
            }
            Spacer(minLength: .ewPaddingHorizontalLarge)
            
        // MARK: - Todo Add the team members
            
        }
        .cornerRadius(.ewCornerRadiusLarge)
        .border(Color.ewPrimary100, width: 1)
    }
}

struct EWCardTask_Previews: PreviewProvider {
    @State static var completion:Bool = true
    static var previews: some View {
        EWCardTodo(content: "Research Project Upload to System", completion: $completion, start: Date.init(timeIntervalSinceNow: .hours(2)), end: Date.init(timeIntervalSinceNow: .hours(3)))
    }
}
