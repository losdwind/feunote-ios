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

        LazyVStack {

            // invitation
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .trailing, spacing: .ewPaddingVerticalDefault) {
                    HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                        EWAvatarImage(avatar: UIImage(named: "demo-person-4")!)
                        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
                            Text("Emilia Gates").foregroundColor(.ewPrimaryBase).font(.ewHeadline)
                            Text("Sent you an invite to connect.")
                        }
                        .frame(maxWidth:.infinity, alignment: .topLeading)
                    }

                    HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault){
                        EWButton(text: "Decline", image: nil, style: .secondarySmall, action: {
                            print("declined invitation")
                        })
                        EWButton(text: "Accept", image: nil, style: .primarySmall, action: {
                            print("accepted invitation")
                        })
                    }

                }
                Image("close")
                    .padding(.ewPaddingVerticalSmall)
                    .foregroundColor(.ewGray900)
                
            }
            .padding(.vertical, .ewPaddingVerticalDefault)
            .padding(.horizontal, .ewPaddingVerticalDefault)
            .background(Color.ewGray50)
            .cornerRadius(.ewCornerRadiusDefault)

            // comments
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .trailing, spacing: .ewPaddingVerticalDefault) {
                    HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                        EWAvatarImage(avatar: UIImage(named: "demo-person-4")!)
                        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
                            Text("Emilia Gates").foregroundColor(.ewPrimaryBase).font(.ewHeadline)
                            Text("Your work is fantastic")
                        }
                        .frame(maxWidth:.infinity, alignment: .topLeading)
                    }
                }
                Image("close")
                    .padding(.ewPaddingVerticalSmall)
                    .foregroundColor(.ewGray900)
            }
            .padding(.vertical, .ewPaddingVerticalDefault)
            .padding(.horizontal, .ewPaddingVerticalDefault)
            .background(Color.ewGray50)
            .cornerRadius(.ewCornerRadiusDefault)

            Spacer()


        }

            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()

                    } label: {
                        Image("arrow-left-2")
                            .foregroundColor(.ewBlack)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Notifications")
                        .font(.ewHeadline)
                        .foregroundColor(.ewBlack)
                }
            }
            .navigationBarBackButtonHidden(true)
            .frame(maxHeight:.infinity, alignment: .top)
            .padding()
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
