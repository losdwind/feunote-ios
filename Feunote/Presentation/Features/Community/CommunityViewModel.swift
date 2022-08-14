//
//  CommunityViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import Amplify
import Foundation

@MainActor
class CommunityViewModel: ObservableObject {
    // for branch
    @Published var fetchedOpenBranches: [AmplifyBranch] = []

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

    func getOpenBranches(page: Int) async {
            do {
                self.fetchedOpenBranches = try await getOpenBranchesUseCase.execute(page: page)
                print("get open branches \(fetchedOpenBranches.count)")
            } catch {
                hasError = true
                appError = error as? Error
            }
    }
}
