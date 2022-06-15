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

    private let dataStoreRepo: DataStoreRepositoryProtocol

    init(dataStoreRepo:DataStoreRepositoryProtocol){
        self.dataStoreRepo = dataStoreRepo
    }

    func execute(page: Int) async throws -> [Todo] {
            
            let predicateInput = Todo.keys.fromUser == dataStoreRepo.user?.id
            let sortInput = QuerySortInput.descending(Todo.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
        return try await dataStoreRepo.query(Todo.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
