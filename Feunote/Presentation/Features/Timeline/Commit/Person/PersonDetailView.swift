//
//  PersonDetailView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/17.
//

import SwiftUI

struct PersonDetailView: View {
    var commit:FeuCommit
    var body: some View {
        Text("Here is the detail info of a person")
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(commit: FeuCommit(commitType: CommitType.person, owner: FeuUser(username: "nameless", email: "133456@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "test")))

    }
}
