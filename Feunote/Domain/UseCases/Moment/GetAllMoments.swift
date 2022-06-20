//
//  getAllPosts.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation
import Amplify

protocol GetAllMomentsUseCaseProtocol {
    func execute(page:Int) async throws-> [Moment]
}



class GetAllMomentsUseCase : GetAllMomentsUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }

    func execute(page: Int) async throws -> [Moment] {
        let predicateInput = Moment.keys.fromUser == manager.dataStoreRepo.user?.id
            let sortInput = QuerySortInput.descending(Moment.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
        return try await manager.dataStoreRepo.query(Moment.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
