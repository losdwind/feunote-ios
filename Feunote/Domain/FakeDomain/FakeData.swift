//
//  FakeData.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Foundation
import Amplify

let fakeAmplifyMoment1 = AmplifyCommit(id: UUID().uuidString, owner: "s524256521", commitType: .moment, titleOrName: "One Night in Beijing", description: "One night in Beijing, 我留下許多情 \n 不管你愛與不愛 \n 都是歷史的塵埃", photoKeys: ["demo-picture-1", nil, "demo-picture-2" ], audioKeys: ["audio-1"], videoKeys: ["video-1"], toBranch: "", momentWordCount: 15, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: nil, personAddress: nil, personBirthday: nil, personContact: nil, personAvatarKey: nil,createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyTodo1 = AmplifyCommit(id: UUID().uuidString, owner: "s524256521", commitType: .todo, titleOrName: "Organize yourwork and life, finally.", description: "Become focused, organized, and calm with Todoist. The world’s #1 task manager and to-do list app.", photoKeys: [], audioKeys: [], videoKeys: [], toBranch: "", momentWordCount: nil, todoCompletion: false, todoReminder: true, todoStart: Temporal.DateTime.now(), todoEnd: Temporal.DateTime.now(), personPriority: nil, personAddress: nil, personBirthday: nil, personContact: nil, personAvatarKey: nil,createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyPerson1 = AmplifyCommit(id: UUID().uuidString, owner: "s524256521", commitType: .todo, titleOrName: "Martin Elias Peter Seligman", description: "an American psychologist, educator, and author of self-help books. Seligman is a strong promoter within the scientific community of his theories of positive psychology[1] and of well-being. His theory of learned helplessness is popular among scientific and clinical psychologists.[2] A Review of General Psychology survey, published in 2002, ranked Seligman as the 31st most cited psychologist of the 20th century.[3]", photoKeys: [], audioKeys: [], videoKeys: [], toBranch: "", momentWordCount: nil, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: 9, personAddress: "711-2880 Nulla St., Mankato Mississippi, 96522", personBirthday: Temporal.Date.init(Date.distantPast.addingTimeInterval(10000)), personContact: "(257) 563-7401", personAvatarKey: "demo-person-1",createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyBranch = AmplifyBranch(id: UUID().uuidString, owner: "s524256521" , title: "Smart Ring for the Blind", description: "We plan to create a smart ring for people thant cannot see. It support text input, voice recording and mobile payment.", members: ["s524256522", "s524256523"], commits: [], actions: nil, numOfLikes: 135233, numOfDislikes: 123123, numOfComments: 123123, numOfShares: 1231, numOfSubs: 4242, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyUser = AmplifyUser(id: UUID().uuidString, owner: "s524256521", nickName: " losdwind ", avatarKey: "demo-person-3", bio: "I am a good guy, I am a bad COD player", username: "s524256521", email: "s524256521@gmail.com", realName: "Iris Watson", gender: "male", birthday: Temporal.Date.init(Date.distantPast.addingTimeInterval(10000)), address: "P.O. Box 283 8562 Fusce Rd., Frederick Nebraska 20620, United States", phone: "(372) 587-2335", job: "Retired", income: "18K/Month", marriage: "Divorced", socialMedia: "TikTok", interest: "Play Music", bigFive: "{a:dawdw, b: werqewrq}", wellbeingIndex: "928", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())
