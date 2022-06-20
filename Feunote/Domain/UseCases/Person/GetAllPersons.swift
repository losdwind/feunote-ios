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

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }

func execute(page: Int) async throws -> [Person] {
        
    let predicateInput = Person.keys.fromUser == manager.dataStoreRepo.user?.id
        let sortInput = QuerySortInput.descending(Person.keys.createdAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
    return try await manager.dataStoreRepo.query(Person.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
}
