//
//  CardPerson.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/9.
//

import SwiftUI

struct CommitPersonView: View {
    var person: AmplifyCommit

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                PersonAvatarView(imageKey: person.personAvatarKey, style: .medium)

                VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                    Text(person.titleOrName ?? "No Name").font(Font.ewHeadline).lineLimit(1)
                        .frame(alignment: .leading)
                    if person.personAddress != nil {
                        Label(person.personAddress!, image: "globe")
                            .font(.ewFootnote)
                            .foregroundColor(.ewGray900)
                            .frame(alignment: .leading)
                            .lineLimit(1)
                    }
                    if person.personBirthday != nil {
                        Label(person.personBirthday!.foundationDate.formatted().description, image: "id-card")
                            .font(.ewFootnote)
                            .foregroundColor(.ewGray900)
                            .frame(alignment: .leading)
                            .lineLimit(1)
                    }
                }
                .layoutPriority(1)

                Spacer()
            }

            Text(person.description ?? "No Description")
                .font(.ewBody)
                .foregroundColor(.ewGray900)
                .frame(alignment: .topLeading)

            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                Button {} label: {
                    Image("phone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                }

                Button {} label: {
                    Image("messaging")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                }

                Button {} label: {
                    Image("twitter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                }

                Button {} label: {
                    Image("linkedin")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                }
            }
            .frame(alignment: .leading)
        }
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct EWCardPerson_Previews: PreviewProvider {
    static var previews: some View {
        CommitPersonView(person: AmplifyCommit(commitType: .person))
            .previewLayout(.sizeThatFits)
    }
}
