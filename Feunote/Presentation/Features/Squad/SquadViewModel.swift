//
//  SquadViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation
class SquadViewModel: ObservableObject {
    internal init(saveActionUseCase: SaveActionUseCaseProtocol, getMessagesUseCase: GetMessagesUseCaseProtocol, getParticipatedBranchesUseCase: GetBranchesUseCaseProtocol, getProfileByIDUserCase: GetProfileByIDUseCaseProtocol) {
        self.saveActionUseCase = saveActionUseCase
        self.getMessagesUseCase = getMessagesUseCase
        self.getParticipatedBranchesUseCase = getParticipatedBranchesUseCase
        self.getProfileByIDUserCase = getProfileByIDUserCase
        
    }

    @Published var fetchedParticipatedBranches: [AmplifyBranch] = []
    @Published var fetchedParticipatedAmplifyBranches: [AmplifyBranch] = []

    @Published var fetchedParticipatedBranchesMessages: [[AmplifyAction]] = []
    @Published var newMessage: AmplifyAction = AmplifyAction(creator: AmplifyUser(), toBranch: AmplifyBranch(privacyType: .private, title: "", description: ""), actionType: .message)
    @Published var searchInput:String = ""

    private var saveActionUseCase: SaveActionUseCaseProtocol
    private var getMessagesUseCase: GetMessagesUseCaseProtocol
    private var getParticipatedBranchesUseCase: GetBranchesUseCaseProtocol
    private var getProfileByIDUserCase: GetProfileByIDUseCaseProtocol


    @Published var hasError = false
    @Published var appError: AppError?

    func sendAction(branchID: String, actionType: ActionType, content: String?) async {
        do {
            switch actionType {
            case .message:
                guard let content = content, !content.isEmpty else {
                    throw AppError.failedToSave
                }
            case .comment:
                guard let content = content, !content.isEmpty else {
                    throw AppError.failedToSave
                }
            default:
                break
            }
            try await saveActionUseCase.execute(branchID: branchID, actionType: actionType, content: content)

        } catch {
            self.hasError = true
            self.appError = error as? AppError
        }
    }

    func getMessages() async {
        do {
            self.fetchedParticipatedBranchesMessages = try await withThrowingTaskGroup(of: Array<AmplifyAction>.self) { group -> [[AmplifyAction]] in
                var messagesCollector = [[AmplifyAction]]()
                for branch in self.fetchedParticipatedBranches {
                    group.addTask {
                        return try await self.getMessagesUseCase.execute(branchID: branch.id)
                    }
                }
                for try await messages in group {
                    print("fetched messages: \(messages)")
                    messagesCollector.append(messages)
                }
                return messagesCollector
            }
        } catch {
            self.hasError = true
            self.appError = error as? AppError
        }
    }

    // MARK: get public branches

    func getParticipatedBranches(page: Int) async {
        do {
            self.fetchedParticipatedBranches = try await getParticipatedBranchesUseCase.execute(page: 1)

        } catch {
            self.hasError = true
            self.appError = error as? AppError
        }
    }
}
