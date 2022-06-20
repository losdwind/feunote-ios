//
//  SaveMoment.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation
import Amplify

protocol SaveMomentUseCaseProtocol {
    func execute(existingMoment:Moment?, title:String?, content:String?, selectedImages:[UIImage?]?) async throws -> [Moment]
}

class SaveMomentUseCase: SaveMomentUseCaseProtocol{
    
    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(existingMoment:Moment?, title:String?, content:String?, selectedImages:[UIImage?]?) async throws -> Moment {
        guard let user = manager.dataStoreRepo.user else { return }
        
        var newMoment:Moment
        // check if this moment is an update or create
        if existingMoment {
            newMoment = existingMoment!
            if title {
                newMoment.title = title
            }
            if content {
                newMoment.content = content
            }
        } else {
            var newMoment = Moment(title: title ?? "", fromUser: user, content: content ?? "", wordCount: wordCounter(content: content))
            
        }
        if selectedImages {
            let uploadedPictureKeys = try await withThrowingTaskGroup(of: String.self){ group in
                var pictureKeys:[String] = [String]()
                
                for index,image in selectedImages {
                    }
                        if image {
                            group.addTask{
                                let pictureKey = "\(user.username)\Moment\(id)\index"
                                guard let pngData = image?.pngFlattened(isOpaque: true) else {throw AppStorageError.fileCompressionError}
                                return try await storageRepo.uploadImage(key: pictureKey, data: pngData)
                            
                        }
                        }
                            
                
                for try await pictureKey in group {
                    uploadedPictureKeys.append(pictureKey)
                }
                
                return uploadedPictureKeys
            }
            
            // update the new Moment imageURL key
            newMoment.imageURLs = uploadedPictureKeys
        }

        
        // save the moment
        return try await manager.dataStoreRepo.saveMoment(newMoment)
    }
    
    
    
}
