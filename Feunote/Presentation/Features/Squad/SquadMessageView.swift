//
//  SquadMessageView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI
import Amplify

struct SquadMessageView: View {
    var message:AmplifyAction

    var body: some View {
        if message.owner == AppRepoManager.shared.authRepo.authUser?.username {
            Text(message.content ?? "Message is Invalid")
                .foregroundColor(.ewBlack)
                .font(.ewBody)
                .padding(.ewPaddingVerticalDefault)
                .background(Color.ewPrimary100)
                .cornerRadius(.ewCornerRadiusDefault, corners:[.topLeft, .topRight, .bottomLeft])
                .frame(maxWidth:.infinity, alignment: .trailing)
        } else {
            HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault){
                EWAvatarImage(image: UIImage(named: "demo-person-4")!)
                Text(message.content ?? "Message is Invalid")
                    .foregroundColor(.ewBlack)
                    .font(.ewBody)
                    .padding(.ewPaddingVerticalDefault)
                    .background(Color.ewGray50)
                    .cornerRadius(.ewCornerRadiusDefault, corners:[.topLeft, .topRight, .bottomRight])
                    .frame(maxWidth:.infinity, alignment: .leading)

            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        SquadMessageView(message: fakeActionMessage2)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
