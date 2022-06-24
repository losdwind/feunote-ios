//
//  SaveMoment.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation
import Amplify

protocol SaveMomentUseCaseProtocol {
    func execute(existingMoment:Moment?, title:String?, content:String?, selectedImages:[UIImage?]?) async throws -> Moment
}

class SaveMomentUseCase: SaveMomentUseCaseProtocol{

    
    
    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(existingMoment:Moment?, title:String?, content:String?, selectedImages:[UIImage?]?) async throws -> Moment {
        guard let user = manager.dataStoreRepo.user else { throw AppError.failedToSave }
        
        var newMoment:Moment
        // check if this moment is an update or create
        if (existingMoment != nil) {
            newMoment = existingMoment!
            if (title != nil) {
                newMoment.title = title!
            }
            if (content != nil) {
                newMoment.content = content!
            }
        } else {
            newMoment = Moment(title: title ?? "", fromUser: user, content: content ?? "", wordCount: wordCounter(content: content))
            
        }
        if (selectedImages != nil) {
            let pictureKey = "\(user.id)/moment/\(newMoment.id)"
            let uploadedPictureKeys = try await withThrowingTaskGroup(of: String.self){ group -> [String] in
                
                var PictureKeys:[String] = [String]()
                
                for index in selectedImages!.indices {
                    
                        if let image = selectedImages![index] {
                            group.addTask{
                                let newPictureKey = pictureKey + "/image_\(index)"
                                guard let pngData = image.pngFlattened(isOpaque: true) else {throw AppStorageError.fileCompressionError}
                                return try await self.manager.storageRepo.uploadImage(key: newPictureKey, data: pngData)
                            
                        }
                        }
                }
                            
                
                for try await pictureKey in group {
                    PictureKeys.append(pictureKey)
                }
                
                return PictureKeys
            }
            
            // update the new Moment imageURL key
            newMoment.imageURLs = uploadedPictureKeys
        }

        
        // save the moment
        return try await manager.dataStoreRepo.saveMoment(newMoment)
    }
    
    
    
}
