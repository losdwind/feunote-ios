//
//  SquadViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation

class SquadViewModel: ObservableObject {
    init(getMessagesUseCase: GetMessagesUseCaseProtocol, getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol) {
        self.getMessagesUseCase = getMessagesUseCase
        self.getParticipatedBranchesUseCase = getParticipatedBranchesUseCase
    }

    @Published var fetchedParticipatedBranches: [AmplifyBranch] = []

    @Published var searchInput: String = ""

    private var getMessagesUseCase: GetMessagesUseCaseProtocol
    private var getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol

    @Published var hasError = false
    @Published var appError: Error?

    // MARK: get public branches

    func getParticipatedBranches() async {
            do {
                guard let userID = AppRepoManager.shared.dataStoreRepo.amplifyUser?.id else { return }
                let branches = try await getParticipatedBranchesUseCase.execute(userID: userID)
                DispatchQueue.main.async {
                    self.fetchedParticipatedBranches = branches
                    print("get participated branches: \(branches.count)")
                }

            } catch {
                hasError = true
                appError = error as? Error
            }
        }
}
