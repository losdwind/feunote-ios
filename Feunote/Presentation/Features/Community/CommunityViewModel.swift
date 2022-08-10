//
//  CommunityViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import Foundation
import Amplify

class CommunityViewModel: ObservableObject {


    // for branch
    @Published var fetchedOpenBranches:[AmplifyBranch] = [AmplifyBranch]()

    @Published var selectedLocation:WorldCityJsonReader.N?

    @Published var selectedCategory:CategoryOfBranch = CategoryOfBranch.Hobby
    @Published var selectedCommunityTab:CommunityTab = CommunityTab.Hot

    @Published var searchInput:String = ""

    @Published var isShowingLocationPickerView: Bool = false
    @Published var isShowingNotificationView: Bool = false
    
    @Published var hasError = false
    @Published var appError:AppError?
    

    private var getOpenBranchesUseCase:GetBranchesUseCaseProtocol = GetOpenBranchesUseCase()



    
    // MARK: get public branches
    func getOpenBranches(page:Int) {
        Task {
            do {
                let fetchedOpenBranches = try await getOpenBranchesUseCase.execute(page: page)

            } catch(let error){
                hasError = true
                appError = error as? AppError
            }
        }

    }
}
