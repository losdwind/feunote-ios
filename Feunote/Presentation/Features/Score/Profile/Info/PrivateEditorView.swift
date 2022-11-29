//
//  ProfileEditorView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/29.
//

import MapKit
import SwiftUI

struct PrivateEditorView: View {
    @EnvironmentObject var profilevm: ProfileViewModel

    @State var user: AmplifyUser = AmplifyUser()
    @State var avatar: UIImage?

    @Environment(\.dismiss) var dismiss

    func saveUser() {
        Task {
            do {
                guard let avatar = avatar else { return }
                let avatarKey = try await SaveProfileAvatarUseCase().execute(image: avatar)
                self.user.avatarKey = avatarKey
                try await SaveProfileUseCase().execute(user: self.user)
            } catch {
                print("save user info failed ")
            }
        }
    }

    var body: some View {
        Form {
            PrivateEditorPublicInfoView(user: $user, avatar: $avatar)
            PrivateEditorPrivateInfoView(user: $user)
            PrivateEditorSocialConnectView()
            Section {
                // interedt
                HStack {
                    Text("Pending to add")
                }
            } header: {
                Text("Personal Interest")
            }
        }
        .task{
            if let user =  profilevm.currentUser {
                self.user = user
            } else {
                print("mannually retreived current user info")
                await profilevm.fetchCurrentUser()
                self.user = profilevm.currentUser ?? AmplifyUser()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("arrow-left-2")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.ewBlack)
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                   saveUser()
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.ewHeadline)
                        .foregroundColor(.ewBlack)
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Profile")
                    .font(.ewHeadline)
                    .foregroundColor(.ewBlack)
            }
        })
    }
}

struct PrivateEditorPublicInfoView: View {
    @Binding var user: AmplifyUser
    @Binding var avatar: UIImage?

    var body: some View {
        Section {
            // Avatar
            ZStack(alignment: .center) {
                if user.avatarKey != nil && avatar == nil {
                    PersonAvatarView(imageKey: user.avatarKey, style: .large)
                }
                if avatar != nil {
                    EWAvatarImage(avatar: avatar!, style: .large)
                }

                EWAvatarAdd(avatar: $avatar, style: .large)
                    .foregroundColor(.ewGray900)
                    .opacity((avatar != nil || user.avatarKey != nil) ? 0 : 1)
            }
            .frame(alignment: .center)

            // nickName
            HStack(spacing:.ewPaddingVerticalDefault){
                Text("Nick Name")
                TextField("Nick Name", text: $user.nickName ?? "", prompt: Text("e.g. elonmusk"))
            }

        } header: {
            Text("Public Info")
        }
    }
}

struct PrivateEditorPrivateInfoView: View {
    @State var birthday: Date = .init(timeIntervalSince1970: 0)
    @State var address: String = ""
    @State var jobCategory: String = "Architecture and engineering"
    @Binding var user: AmplifyUser
    var body: some View {
        Section {
            // fullname
            HStack(spacing:.ewPaddingVerticalDefault) {
                Text("Full Name")
                TextField("Full Name", text: $user.realName ?? "", prompt: Text("e.g. Adam Smith"))
            }

            // gender
            HStack(spacing:.ewPaddingVerticalDefault) {
                Text("Gender")
                Picker("Gender", selection: $user.gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Misc.").tag("Misc.")
                }
                .pickerStyle(.segmented)
            }

            // birthday
            DatePicker("Birthday", selection: $birthday, displayedComponents: .date)

            // address
            HStack(spacing:.ewPaddingVerticalDefault) {
                Text("Address")
                TextField("Address", text: $user.address ?? "", prompt: Text("Hechuan, Chongqing, CHINA "))
                    .autocorrectionDisabled(false)
                    .autocapitalization(.none)
            }

            // mobile
            HStack(spacing:.ewPaddingVerticalDefault) {
                Text("Mobile")
                TextField("mobile", text: $user.phone ?? "", prompt: Text("000-000-0000"))
            }

            // job
            HStack(spacing:.ewPaddingVerticalDefault) {
                Text("Job")
                Picker("Category", selection: $jobCategory) {
                    ForEach(Array(JOBS.keys), id: \.self) { key in
                        Text(key).tag(key)
                            .frame(width: 60)
                    }
                }
                .pickerStyle(.menu)

                Picker("Job", selection: $user.job) {
                    ForEach(JOBS[jobCategory]!, id: \.self) { job in
                        Text(job).tag(job)
                            .frame(width: 60)
                    }
                }
                .pickerStyle(.menu)
            }

            // income

            HStack(spacing:.ewPaddingVerticalDefault) {
                Text("Annual Income")
                TextField("Annual Income", text: $user.income ?? "", prompt: Text("$"))
            }

            // marital status

            HStack(spacing:.ewPaddingVerticalDefault) {
                Text("Marital Status")

                Picker("Marital Status", selection: $user.marriage) {
                    ForEach(Marriage.allCases, id: \.self) { m in
                        Text(m.rawValue).tag(m)
                    }
                }
                .pickerStyle(.menu)
            }

        } header: {
            Text("Private Info")
        }
    }
}

struct PrivateEditorSocialConnectView: View {
    @State var socialMediaCategory: SocialMediaCategory = .linkedin

    var body: some View {
        Section {
            Group {
                ForEach(SocialMediaCategory.allCases, id: \.self) { category in
                    HStack(spacing:.ewPaddingVerticalDefault) {
                        Label {
                            Text(category.rawValue)
                                .font(.headline)
                        } icon: {
                            Image("\(category.rawValue)-color")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20, alignment: .center)
                                .tag(category)
                        }

                        Spacer()
                        Button {
//                            profilevm.connectSocialMedia(source: socialMediaCategory, completion: { _ in })
                        } label: {
                            Text("Connect")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                    }
                }
            }

        } header: {
            Text("Social Media")
        }
    }
}

struct ProfileEditorView_Previews: PreviewProvider {
    static let user: AmplifyUser = .init()
    static var previews: some View {
        PrivateEditorView(user: user)
    }
}
