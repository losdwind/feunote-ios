//
//  SquadViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation
class SquadViewModel: ObservableObject {
    internal init(saveActionUseCase: SaveActionUseCaseProtocol, getMessagesUseCase: GetMessagesUseCaseProtocol, getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol, getProfileByIDUserCase: GetProfileByIDUseCaseProtocol, viewDataMapper: ViewDataMapperProtocol) {
        self.saveActionUseCase = saveActionUseCase
        self.getMessagesUseCase = getMessagesUseCase
        self.getParticipatedBranchesUseCase = getParticipatedBranchesUseCase
        self.getProfileByIDUserCase = getProfileByIDUserCase
        self.viewDataMapper = viewDataMapper
    }

    @Published var fetchedParticipatedBranches: [FeuBranch] = []
    @Published var fetchedParticipatedBranchesMessages: [[AmplifyAction]] = []
    @Published var newMessage: AmplifyAction = AmplifyAction(toBranchID: "", actionType: .message)
    @Published var searchInput:String = ""

    private var saveActionUseCase: SaveActionUseCaseProtocol
    private var getMessagesUseCase: GetMessagesUseCaseProtocol
    private var getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol
    private var getProfileByIDUserCase: GetProfileByIDUseCaseProtocol

    private var viewDataMapper: ViewDataMapperProtocol

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
            let action = AmplifyAction(toBranchID: branchID, actionType: actionType, content: content)
            try await saveActionUseCase.execute(action: action)

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
            let fetchedAmplifyBranches = try await getParticipatedBranchesUseCase.execute()

            self.fetchedParticipatedBranches = try await withThrowingTaskGroup(of: FeuBranch.self) { group -> [FeuBranch] in
                var feuBranches = [FeuBranch]()
                for branch in fetchedAmplifyBranches {
                    group.addTask {
                        try await self.viewDataMapper.branchDataTransformer(branch: branch)
                    }
                }
                for try await feuBranch in group {
                    print("fetched feuBranch with ID: \(feuBranch.id)")
                    feuBranches.append(feuBranch)
                }
                return feuBranches
            }

        } catch {
            self.hasError = true
            self.appError = error as? AppError
        }
    }
}
