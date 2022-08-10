//
//  ImageLoader.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Combine
import Foundation
import Kingfisher
class GetKFImageSourceUseCase: GetKFImageSourceUseCaseProtocol {
    func execute(key: String) -> Source {
        return Source.provider(KFImageProvider(key: key))
    }
}
