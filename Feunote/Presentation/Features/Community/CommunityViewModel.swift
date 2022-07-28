//
//  CommunityViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import Foundation
import Amplify

class CommunityViewModel: ObservableObject {
    internal init(saveActionUseCase: SaveActionUseCaseProtocol, deleteActionUseCase: DeleteActionUseCaseProtocol, getCommentsUseCase: GetCommentsUseCaseProtocol, getOpenBranchesUseCase: GetOpenBranchesUseCaseProtocol, getOpenBranchByIDUseCase: GetOpenBranchByIDUseCaseProtocol, getProfilesByIDsUserCase: GetProfilesByIDsUseCaseProtocol, viewDataMapper: ViewDataMapperProtocol) {
        self.saveActionUseCase = saveActionUseCase
        self.deleteActionUseCase = deleteActionUseCase
        self.getCommentsUseCase = getCommentsUseCase
        self.getOpenBranchesUseCase = getOpenBranchesUseCase
        self.getOpenBranchByIDUseCase = getOpenBranchByIDUseCase
        self.getProfilesByIDsUserCase = getProfilesByIDsUserCase
        self.viewDataMapper = viewDataMapper
    }


    // for branch
    @Published var fetchedFilteredBranches:[FeuBranch] = [FeuBranch]()
    @Published var currentBranch:FeuBranch = FeuBranch()
    @Published var fetchedCurrentBranchComments:[AmplifyAction] = [AmplifyAction]()
    
    
    lazy var worldCity = WorldCityJsonReader.shared.worldCity
    lazy var chinaCity = ChinaCityJsonReader.shared.chinaCity
    
    @Published var selectedLocation:WorldCityJsonReader.N? 
    @Published var selectedCategory:CategoryOfBranch = CategoryOfBranch.Hobby
    @Published var selectedCommunityTab:CommunityTab = CommunityTab.Hot



    @Published var isShowingLocationPickerView: Bool = false
    @Published var isShowingNotificationView: Bool = false
    
    @Published var hasError = false
    @Published var appError:AppError?
    
    
    private var saveActionUseCase:SaveActionUseCaseProtocol
    private var deleteActionUseCase:DeleteActionUseCaseProtocol
    private var getCommentsUseCase:GetCommentsUseCaseProtocol
    private var getOpenBranchesUseCase:GetOpenBranchesUseCaseProtocol
    private var getOpenBranchByIDUseCase:GetOpenBranchByIDUseCaseProtocol
    private var getProfilesByIDsUserCase:GetProfilesByIDsUseCaseProtocol
    private var viewDataMapper:ViewDataMapperProtocol
    
    
    
    // this function check if the current user liked/disliked/subed current branch
    func getStatus(branch:FeuBranch){
        
    }
    
    
    
    func getUserGivenSubsList() {
        
    }
    
    
    func getUserGivenSubs() {
        
    }
    
    func getUserReceivedSubs() {
        
    }
    
    
    
    func sendAction(branchID:String, actionType:ActionType, content:String?) async {
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
            let action = AmplifyAction(toBranchID:branchID, actionType: actionType, content: content)
            try await saveActionUseCase.execute(action: action)

                
        }catch(let error) {
            hasError = true
            appError = error as? AppError
        }
    }
    

    
    
    
    func getComments(branchID:String) async {
        do {
            self.fetchedCurrentBranchComments = try await getCommentsUseCase.execute(branchID: branchID)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    
    
    
    
    // MARK: get public branches
    func getPublicBranches(page:Int) async {
        do {
            let fetchedAmplifyBranches = try await getOpenBranchesUseCase.execute(page: page)
            
            self.fetchedFilteredBranches = try await withThrowingTaskGroup(of: FeuBranch.self){ group -> [FeuBranch] in
                var feuBranches:[FeuBranch] = [FeuBranch]()
                for branch in fetchedAmplifyBranches {
                    group.addTask {
                        return try await self.viewDataMapper.branchDataTransformer(branch: branch)
                    }
                }
                for try await feuBranch in group {
                    print("fetched feuBranch with ID: \(feuBranch.id)")
                    feuBranches.append(feuBranch)
                }
                return feuBranches
                
            }
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
}
