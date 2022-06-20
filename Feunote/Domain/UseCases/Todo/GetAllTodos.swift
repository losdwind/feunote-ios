//
//  GetAllTodos.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation
import Amplify

protocol GetAllTodosUseCaseProtocol {
    func execute(page:Int) async throws-> [Todo]
}



class GetAllTodosUseCase : GetAllTodosUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }

    func execute(page: Int) async throws -> [Todo] {
        
            
        let predicateInput = Todo.keys.fromUser == manager.dataStoreRepo.user?.id
            let sortInput = QuerySortInput.descending(Todo.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
        return try await manager.dataStoreRepo.query(Todo.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
