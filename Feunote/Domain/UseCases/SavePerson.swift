//
//  SavePerson.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol SavePersonUseCaseProtocol {
    func execute(page:Int) async throws -> [Branch]
}



class SavePersonUseCase: SavePersonUseCaseProtocol{

    

    private let dataStoreRepo: DataStoreRepositoryProtocol

    init(dataStoreRepo:DataStoreRepositoryProtocol){
        self.dataStoreRepo = dataStoreRepo
    }
    
    
    func execute() async throws {
        
        print("saved a moment")
    }
    
    
    }
