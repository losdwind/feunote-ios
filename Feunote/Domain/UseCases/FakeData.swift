//
//  FakeData.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Amplify
import Foundation
import SwiftUI

let fakeAmplifyMoment1 = AmplifyCommit(id: "M1", owner: "s524256521", commitType: .moment, titleOrName: "One Night in Beijing", description: "One night in Beijing \n 我留下許多情 \n 不管你愛與不愛 \n 都是歷史的塵埃", photoKeys: ["demo-picture-1", nil, "demo-picture-2"], audioKeys: ["audio-1"], videoKeys: ["video-1"], toBranch: fakeAmplifyBranchOpen1, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: nil, personAddress: nil, personBirthday: nil, personContact: nil, personAvatarKey: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyMoment2 = AmplifyCommit(id: "M2", owner: "s524256521", commitType: .moment, titleOrName: "金融推荐书", description: "When Genius Failed(营救华尔街）\n Too big to fail (大而不倒) \n The essavs of Warren Buffett (巴菲特致股东的信）\n Freakonomics (魔鬼经济学）\n Principles (原则)", photoKeys: ["demo-picture-1", nil, "demo-picture-2", "demo-picture-3", "demo-picture-4"], audioKeys: ["audio-1"], videoKeys: ["video-1"], toBranch: fakeAmplifyBranchOpen1, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: nil, personAddress: nil, personBirthday: nil, personContact: nil, personAvatarKey: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyTodo1 = AmplifyCommit(id: "T1", owner: "s524256521", commitType: .todo, titleOrName: "Organize yourwork and life, finally.", description: "Become focused, organized, and calm with Todoist. The world’s #1 task manager and to-do list app.", photoKeys: nil, audioKeys: nil, videoKeys: nil, toBranch: fakeAmplifyBranchOpen1, todoCompletion: false, todoReminder: true, todoStart: Temporal.DateTime.now(), todoEnd: Temporal.DateTime.now(), personPriority: nil, personAddress: nil, personBirthday: nil, personContact: nil, personAvatarKey: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyTodo2 = AmplifyCommit(id: "T2", owner: "s524256521", commitType: .todo, titleOrName: "写文：幸福指数与GDP", description: "", photoKeys: nil, audioKeys: nil, videoKeys: nil, toBranch: fakeAmplifyBranchOpen1, todoCompletion: false, todoReminder: true, todoStart: Temporal.DateTime.now(), todoEnd: Temporal.DateTime.now(), personPriority: nil, personAddress: nil, personBirthday: nil, personContact: nil, personAvatarKey: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyPerson1 = AmplifyCommit(id: "P1", owner: "s524256521", commitType: .person, titleOrName: "Martin Elias Peter Seligman", description: "an American psychologist, educator, and author of self-help books. Seligman is a strong promoter within the scientific community of his theories of positive psychology[1] and of well-being. His theory of learned helplessness is popular among scientific and clinical psychologists.[2] A Review of General Psychology survey, published in 2002, ranked Seligman as the 31st most cited psychologist of the 20th century.[3]", photoKeys: [], audioKeys: [], videoKeys: [], toBranch: fakeAmplifyBranchOpen1, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: 9, personAddress: "711-2880 Nulla St., Mankato Mississippi, 96522", personBirthday: Temporal.Date(Date.distantPast.addingTimeInterval(10000)), personContact: "(257) 563-7401", personAvatarKey: "demo-person-1", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyPerson2 = AmplifyCommit(id: "P2", owner: "s524256521", commitType: .person, titleOrName: "Andrew Yan-Tak Ng", description: "a British-born American computer scientist and technology entrepreneur focusing on machine learning and AI.[2] Ng was a co-founder and head of Google Brain and was the former chief scientist at Baidu, building the company's Artificial Intelligence Group into a team of several thousand people.[3]", photoKeys: [], audioKeys: nil, videoKeys: nil, toBranch: fakeAmplifyBranchOpen1, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: 9, personAddress: "", personBirthday: Temporal.Date(Date.distantPast.addingTimeInterval(1000)), personContact: "(257) 523-7421", personAvatarKey: "demo-person-2", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyBranchOpen1 = AmplifyBranch(id: "BO1", owner: "s524256521", privacyType: .open, title: "Smart Ring for the Blind", description: "We plan to create a smart ring for people thant cannot see. It support text input, voice recording and mobile payment.", squadName: "Goldeb Fish", commits: [], actions: [], numOfLikes: 135_233, numOfDislikes: 123_123, numOfComments: 123_123, numOfShares: 1231, numOfSubs: 4242, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyBranchPrivate1 = AmplifyBranch(id: UUID().uuidString, owner: "s524256521", privacyType: .private, title: "Let's Play COD", description: "We plan to form a team for the Warzon. Requres high COD Level and dedicated personal computer", commits: [fakeAmplifyMoment1, fakeAmplifyTodo1, fakeAmplifyPerson1], numOfLikes: 13_123_233, numOfDislikes: 123, numOfComments: 123, numOfShares: 11, numOfSubs: 4, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyBranchLimited1 = AmplifyBranch(id: UUID().uuidString, owner: "s524256521", privacyType: .open, title: "Let's Play COD", description: "We plan to form a team for the Warzon. Requres high COD Level and dedicated personal computer", commits: [fakeAmplifyMoment1, fakeAmplifyTodo1, fakeAmplifyPerson1], numOfLikes: 13_123_233, numOfDislikes: 123, numOfComments: 123, numOfShares: 11, numOfSubs: 4, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyUser1 = AmplifyUser(id: UUID().uuidString, owner: "s524256521", nickName: " losdwind ", username: "s524256521", avatarKey: "demo-person-3", bio: "I am a good guy, I am a bad COD player", email: "s524256521@gmail.com", realName: "Iris Watson", gender: "male", birthday: Temporal.Date(Date.distantPast.addingTimeInterval(10000)), address: "P.O. Box 283 8562 Fusce Rd., Frederick Nebraska 20620, United States", phone: "(372) 587-2335", job: "Retired", income: "18K/Month", marriage: "Divorced", socialMedia: "TikTok", interest: "Play Music", bigFive: "{a:dawdw, b: werqewrq}", wellbeingIndex: "928", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeAmplifyUser2 = AmplifyUser(id: UUID().uuidString, owner: "s524256522", nickName: " tasksf ", username: "s524256522", avatarKey: "demo-person-4", bio: "I am a bad guy, I am a good COD player", email: "s524256522@gmail.com", realName: "Cob Diabd", gender: "female", birthday: Temporal.Date(Date.distantPast.addingTimeInterval(123_123)), address: "soemth sai, fas3, CdjasD", phone: "(372) 123-23425", job: "Engineering", income: "10K/Month", marriage: "Signle", socialMedia: "Instagram", interest: "Play Game", bigFive: "{a:dawdw, b: werqewrq}", wellbeingIndex: "812", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())

let fakeActionLike1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", creator: fakeAmplifyUser1, toBranch: fakeAmplifyBranchOpen1, actionType: .like, content: nil)
let fakeActionLike2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", creator: fakeAmplifyUser2, toBranch: fakeAmplifyBranchOpen1, actionType: .like, content: nil)

let fakeActionDislike1 = AmplifyAction(id: UUID().uuidString, owner: "s524256523", creator: fakeAmplifyUser1, toBranch: fakeAmplifyBranchOpen1, actionType: .dislike, content: nil)
let fakeActionDislike2 = AmplifyAction(id: UUID().uuidString, owner: "s524256524", creator: fakeAmplifyUser2, toBranch: fakeAmplifyBranchOpen1, actionType: .dislike, content: nil)

let fakeActionSub1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", creator: fakeAmplifyUser1, toBranch: fakeAmplifyBranchOpen1, actionType: .sub, content: nil)
let fakeActionSub2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", creator: fakeAmplifyUser2, toBranch: fakeAmplifyBranchOpen1, actionType: .sub, content: nil)

let fakeActionShare1 = AmplifyAction(id: UUID().uuidString, owner: "s524256521", creator: fakeAmplifyUser1, toBranch: fakeAmplifyBranchOpen1, actionType: .share, content: nil)
let fakeActionShare2 = AmplifyAction(id: UUID().uuidString, owner: "s524256522", creator: fakeAmplifyUser2, toBranch: fakeAmplifyBranchOpen1, actionType: .share, content: nil)

let fakeActionMessage1 = AmplifyMessage(id: UUID().uuidString, owner: "s524256521", creator: fakeAmplifyUser1, toBranch: fakeAmplifyBranchOpen1, content: "hello my friend")
let fakeActionMessage2 = AmplifyMessage(id: UUID().uuidString, owner: "s524256522", creator: fakeAmplifyUser2, toBranch: fakeAmplifyBranchOpen1, content: "good morning, gooday")

let fakeActionComment1 = AmplifyComment(id: UUID().uuidString, owner: "s524256521", creator: fakeAmplifyUser1, toBranch: fakeAmplifyBranchOpen1, content: "that is awesome, i am in")
let fakeActionComment2 = AmplifyComment(id: UUID().uuidString, owner: "s524256522", creator: fakeAmplifyUser2, toBranch: fakeAmplifyBranchOpen1, content: "how to solve the problem of user engagement")

public class ChartData: ObservableObject, Identifiable {
    @Published var points: [(String, Double)]
    var valuesGiven: Bool = false
    var ID = UUID()

    public init<N: BinaryFloatingPoint>(points: [N]) {
        self.points = points.map { ("", Double($0)) }
    }

    public init<N: BinaryInteger>(values: [(String, N)]) {
        points = values.map { ($0.0, Double($0.1)) }
        valuesGiven = true
    }

    public init<N: BinaryFloatingPoint>(values: [(String, N)]) {
        points = values.map { ($0.0, Double($0.1)) }
        valuesGiven = true
    }

    public init<N: BinaryInteger>(numberValues: [(N, N)]) {
        points = numberValues.map { (String($0.0), Double($0.1)) }
        valuesGiven = true
    }

    public init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues: [(N, N)]) {
        points = numberValues.map { (String($0.0), Double($0.1)) }
        valuesGiven = true
    }
}

public struct GradientColor {
    public let start: Color
    public let end: Color

    public init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }

    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}

public class MultiLineChartData: ChartData {
    var gradient: GradientColor

    public init<N: BinaryFloatingPoint>(points: [N], gradient: GradientColor) {
        self.gradient = gradient
        super.init(points: points)
    }

    public init<N: BinaryFloatingPoint>(points: [N], color: Color) {
        gradient = GradientColor(start: color, end: color)
        super.init(points: points)
    }

    public func getGradient() -> GradientColor {
        return gradient
    }
}

public enum TestData {
    public static var data: ChartData = .init(points: [37, 72, 51, 22, 39, 47, 66, 85, 50])
    public static var values: ChartData = .init(values: [("2017 Q3", 220),
                                                         ("2017 Q4", 1550),
                                                         ("2018 Q1", 8180),
                                                         ("2018 Q2", 18440),
                                                         ("2018 Q3", 55840),
                                                         ("2018 Q4", 63150), ("2019 Q1", 50900), ("2019 Q2", 77550), ("2019 Q3", 79600), ("2019 Q4", 92550)])
}
