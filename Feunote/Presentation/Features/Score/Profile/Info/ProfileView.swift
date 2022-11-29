//
//  ProfileView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/24.
//
/*
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profilevm: ProfileViewModel
    @State var isEditing: Bool = false
    @State var isShowingLocationPickerView: Bool = false
    @State var location: WorldCityJsonReader.N?
    @State var isShowingLocationView: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
                // title card
                if isEditing {
                    ProfileUpdateAvatarView()
                } else {
                    PersonAvatarView(imageKey: profilevm.user.avatarKey, style: .large)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text(profilevm.user.nickName ?? "N.A")
                        .font(.ewHeadline)
                        .foregroundColor(.ewPrimary700)
                    Text("@\(profilevm.user.username ?? "N.A")")
                        .font(.ewFootnote)
                }

                if isEditing {
                    EWTextFieldMultiline(input: $profilevm.user.bio ?? "", placeholder: "")
                } else {
                    Text(profilevm.user.bio ?? "The user didn't have an bio")
                        .font(.ewBody)
                        .foregroundColor(.ewBlack)
                }

                HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                    Text("Location")
                        .font(.ewHeadline)
                        .foregroundColor(.ewGray900)
                    if isEditing {
                        Button {
                            isShowingLocationView.toggle()
                        } label: {
                            Text(profilevm.user.address ?? "N.A")
                                .font(.ewBody)
                                .foregroundColor(.ewBlack)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                    } else {
                        Text(profilevm.user.address ?? "N.A")
                            .font(.ewBody)
                            .foregroundColor(.ewBlack)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .fullScreenCover(isPresented: $isShowingLocationPickerView, content: {
                LocationPickerView(selectedLocation: $location)
            })
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
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
                if isEditing {
                    Button {
                        isEditing.toggle()
                        profilevm.user.address = location?.c
//                        Task {
//                            await profilevm.saveUser()
//                            await profilevm.fetchCurrentUser()
//                        }

                    } label: {
                        Image("save")
                    }
                } else {
                    Button {
                        isEditing.toggle()
                    } label: {
                        Image("compose")
                    }
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Profile")
                    .font(.ewHeadline)
                    .foregroundColor(.ewBlack)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
*/
