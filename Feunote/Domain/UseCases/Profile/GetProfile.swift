//
//  GetAllProfiles.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation

protocol GetAllProfilesUseCaseProtocol {
    func execute(profile:User) async -> [Profile]
}



class GetAllProfilesUseCase : GetAllProfilesUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func execute(profile:User) async throws -> User {
        
        let predicateInput = Profile.keys.fromUser == DataStoreRepo.user?.id
        let sortInput = QuerySortInput.descending(Profile.keys.createdAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
    return try await dataStoreRepo.query(Profile.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
}
}
