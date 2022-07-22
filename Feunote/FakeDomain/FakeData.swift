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

let fakeAmplifyPerson1 = AmplifyCommit(id: UUID().uuidString, owner: "s524256521", commitType: .person, titleOrName: "Martin Elias Peter Seligman", description: "an American psychologist, educator, and author of self-help books. Seligman is a strong promoter within the scientific community of his theories of positive psychology[1] and of well-being. His theory of learned helplessness is popular among scientific and clinical psychologists.[2] A Review of General Psychology survey, published in 2002, ranked Seligman as the 31st most cited psychologist of the 20th century.[3]", photoKeys: [], audioKeys: [], videoKeys: [], toBranch: "", momentWordCount: nil, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: 9, personAddress: "711-2880 Nulla St., Mankato Mississippi, 96522", personBirthday: Temporal.Date.init(Date.distantPast.addingTimeInterval(10000)), personContact: "(257) 563-7401", personAvatarKey: "demo-person-1",createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyBranchOpen1 = AmplifyBranch(id: UUID().uuidString, owner: "s524256521", privacyType: .open , title: "Smart Ring for the Blind", description: "We plan to create a smart ring for people thant cannot see. It support text input, voice recording and mobile payment.", members: ["s524256522", "s524256523"], commits: [fakeAmplifyMoment1.id, fakeAmplifyTodo1.id, fakeAmplifyPerson1.id], numOfLikes: 135233, numOfDislikes: 123123, numOfComments: 123123, numOfShares: 1231, numOfSubs: 4242, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyBranchOpen2 = AmplifyBranch(id: UUID().uuidString, owner: "s524256521", privacyType: .open , title: "Smart Ring for the Blind", description: "We plan to create a smart ring for people thant cannot see. It support text input, voice recording and mobile payment.", members: ["s524256522", "s524256523"], commits: [fakeAmplifyMoment1.id, fakeAmplifyTodo1.id, fakeAmplifyPerson1.id], numOfLikes: 135233, numOfDislikes: 123123, numOfComments: 123123, numOfShares: 1231, numOfSubs: 4242, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())
let fakeAmplifyBranchOpen3 = AmplifyBranch(id: UUID().uuidString, owner: "s524256521", privacyType: .open , title: "Smart Ring for the Blind", description: "We plan to create a smart ring for people thant cannot see. It support text input, voice recording and mobile payment.", members: ["s524256522", "s524256523"], commits: [fakeAmplifyMoment1.id, fakeAmplifyTodo1.id, fakeAmplifyPerson1.id], numOfLikes: 135233, numOfDislikes: 123123, numOfComments: 123123, numOfShares: 1231, numOfSubs: 4242, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())



let fakeAmplifyBranchPrivate = AmplifyBranch(id: UUID().uuidString, owner: "s524256521", privacyType: .open , title: "Let's Play COD", description: "We plan to form a team for the Warzon. Requres high COD Level and dedicated personal computer", members: ["s524256522", "s524256523"], commits: [fakeAmplifyMoment1.id, fakeAmplifyTodo1.id, fakeAmplifyPerson1.id], numOfLikes: 13123233, numOfDislikes: 123, numOfComments: 123, numOfShares: 11, numOfSubs: 4, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyUser1 = AmplifyUser(id: UUID().uuidString, owner: "s524256521", nickName: " losdwind ", avatarKey: "demo-person-3", bio: "I am a good guy, I am a bad COD player", username: "s524256521", email: "s524256521@gmail.com", realName: "Iris Watson", gender: "male", birthday: Temporal.Date.init(Date.distantPast.addingTimeInterval(10000)), address: "P.O. Box 283 8562 Fusce Rd., Frederick Nebraska 20620, United States", phone: "(372) 587-2335", job: "Retired", income: "18K/Month", marriage: "Divorced", socialMedia: "TikTok", interest: "Play Music", bigFive: "{a:dawdw, b: werqewrq}", wellbeingIndex: "928", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyUser2 = AmplifyUser(id: UUID().uuidString, owner: "s524256522", nickName: " tasksf ", avatarKey: "demo-person-4", bio: "I am a bad guy, I am a good COD player", username: "s524256522", email: "s524256522@gmail.com", realName: "Cob Diabd", gender: "female", birthday: Temporal.Date.init(Date.distantPast.addingTimeInterval(123123)), address: "soemth sai, fas3, CdjasD", phone: "(372) 123-23425", job: "Engineering", income: "10K/Month", marriage: "Signle", socialMedia: "Instagram", interest: "Play Game", bigFive: "{a:dawdw, b: werqewrq}", wellbeingIndex: "812", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeActionLike1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .like, content: nil)
let fakeActionLike2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .like, content: nil)

let fakeActionDislike1 = AmplifyAction(id: UUID().uuidString, owner: "s524256523", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .dislike, content: nil)
let fakeActionDislike2 = AmplifyAction(id: UUID().uuidString, owner: "s524256524", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .dislike, content: nil)

let fakeActionSub1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .sub, content: nil)
let fakeActionSub2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .sub, content: nil)

let fakeActionShare1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .share, content: nil)
let fakeActionShare2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .share, content: nil)

let fakeActionMessage1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .message, content: "hello my friend")
let fakeActionMessage2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .message, content: "good morning, gooday")

let fakeActionComment1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .comment, content: "that is awesome, i am in")
let fakeActionComment2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", toBranchID: fakeAmplifyBranchOpen1.id, actionType: .comment, content: "how to solve the problem of user engagement")

