//
//  SquadViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation

class SquadViewModel: ObservableObject {
    init(getMessagesUseCase: GetMessagesUseCaseProtocol, getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol, getOwnedOpenBranchesUseCase:GetBranchesUseCaseProtocol) {
        self.getMessagesUseCase = getMessagesUseCase
        self.getParticipatedBranchesUseCase = getParticipatedBranchesUseCase
        self.getOwnedOpenBranchesUseCase = getOwnedOpenBranchesUseCase
    }

    @Published var fetchedParticipatedBranches: [AmplifyBranch] = []

    @Published var searchInput: String = ""

    private var getMessagesUseCase: GetMessagesUseCaseProtocol
    private var getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol
    private var getOwnedOpenBranchesUseCase: GetBranchesUseCaseProtocol

    @Published var hasError = false
    @Published var appError: Error?

    // MARK: get public branches

    func getParticipatedBranches() async {
            do {
                guard let userID = AppRepoManager.shared.dataStoreRepo.amplifyUser?.id else { return }
                let participatedBranches = try await getParticipatedBranchesUseCase.execute(userID: userID)
                let ownedOpenBranches = try await getOwnedOpenBranchesUseCase.execute(page: 0)
                DispatchQueue.main.async {
                    self.fetchedParticipatedBranches  = participatedBranches + ownedOpenBranches
                    print("get participated branches: \(participatedBranches.count)")
                    print("get owned open branches: \(ownedOpenBranches.count)")
                }

            } catch {
                hasError = true
                appError = error as? Error
            }
        }


}
