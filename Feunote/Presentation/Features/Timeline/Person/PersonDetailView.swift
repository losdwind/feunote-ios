//
//  PersonDetailView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/17.
//

import SwiftUI

struct PersonDetailView: View {
    var person:Person
    var body: some View {
        Text("Here is the detail info of a person")
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Person(fromUser: User(avatarURL: "test avatar", nickName: "test name"), description: "test description", name: "testname"))
    }
}
