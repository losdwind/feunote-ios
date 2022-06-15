//
//  GetAllPersons.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation

protocol GetAllPersonsUseCaseProtocol {
    func execute(page:Int) async -> [Person]
}



class GetAllPersonsUseCase : GetAllPersonsUseCaseProtocol{

    private let dataStoreRepo: DataStoreRepositoryProtocol

    init(dataStoreRepo:DataStoreRepositoryProtocol)
        self.dataStoreRepo = dataStoreRepo
    }

func execute(page: Int) async throws -> [Person] {
        
        let predicateInput = Person.keys.fromUser == DataStoreRepo.user?.id
        let sortInput = QuerySortInput.descending(Post.keys.createdAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
    return try await dataStoreRepo.query(Person.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
}
