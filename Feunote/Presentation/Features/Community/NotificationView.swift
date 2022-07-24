//
//  NotificationView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Text("Notifications")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()

                    } label: {
                        Image("arrow-left-2")
                            .foregroundColor(.ewBlack)
                    }
                }
            }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
