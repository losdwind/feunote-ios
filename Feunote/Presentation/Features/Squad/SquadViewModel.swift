//
//  SquadViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation
class SquadViewModel: ObservableObject {
    internal init(getMessagesUseCase: GetMessagesUseCaseProtocol, getParticipatedBranchesUseCase: GetBranchesUseCaseProtocol) {
        self.getMessagesUseCase = getMessagesUseCase
        self.getParticipatedBranchesUseCase = getParticipatedBranchesUseCase
    }

    @Published var fetchedParticipatedBranches: [AmplifyBranch] = []

    @Published var searchInput: String = ""

    private var getMessagesUseCase: GetMessagesUseCaseProtocol
    private var getParticipatedBranchesUseCase: GetBranchesUseCaseProtocol

    @Published var hasError = false
    @Published var appError: Error?


    // MARK: get public branches

    func getParticipatedBranches(page _: Int) async {
        do {
            fetchedParticipatedBranches = try await getParticipatedBranchesUseCase.execute(page: 1)
        } catch {
            hasError = true
            appError = error as? Error
        }
    }
}
