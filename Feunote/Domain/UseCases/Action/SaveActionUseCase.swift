//
//  SaveActionUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

class SaveActionUseCase: SaveActionUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func execute(action:AmplifyAction) async throws{

        try await manager.dataStoreRepo.saveAction(action)

    }
    
    }
