//
//  CommunityViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import Amplify
import Foundation

class CommunityViewModel: ObservableObject {
    // for branch
    @Published var fetchedOpenBranches: [AmplifyBranch] = .init()

    @Published var selectedLocation: WorldCityJsonReader.N?

    @Published var selectedCategory: CategoryOfBranch = .Hobby
    @Published var selectedCommunityTab: CommunityTab = .Hot

    @Published var searchInput: String = ""

    @Published var isShowingLocationPickerView: Bool = false
    @Published var isShowingNotificationView: Bool = false

    @Published var hasError = false
    @Published var appError: Error?

    private var getOpenBranchesUseCase: GetBranchesUseCaseProtocol = GetOpenBranchesUseCase()

    // MARK: get public branches

    func getOpenBranches(page: Int) {
        Task {
            do {
                let fetchedOpenBranches = try await getOpenBranchesUseCase.execute(page: page)

            } catch {
                hasError = true
                appError = error as? Error
            }
        }
    }
}
