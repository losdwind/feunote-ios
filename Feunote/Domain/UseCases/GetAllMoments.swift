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

    private let dataStoreRepo: DataStoreRepositoryProtocol
    
    init(dataStoreRepo:DataStoreRepositoryProtocol){
        self.dataStoreRepo = dataStoreRepo
    }

    func execute(page: Int) async throws -> [Moment] {
        let predicateInput = Moment.keys.fromUser == dataStoreRepo.user?.id
            let sortInput = QuerySortInput.descending(Moment.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
        return try await dataStoreRepo.query(Moment.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
