//
//  AnyPublisher+Extension.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/27.
//

import Foundation
import Combine
extension AnyPublisher {
    func asyncThrowing(error: AppError) async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            var finishedWithoutValue = true
            cancellable = first()
                .sink { result in
                    switch result {
                    case .finished:
                        if finishedWithoutValue {
                            print("finished without value")
                            continuation.resume(throwing: error)
                        }
                    case let .failure(failure):
                        print(failure.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    finishedWithoutValue = false
                    continuation.resume(returning: value)
                }
        }
    }
    
    
//    func asyncStreamThrowing(error:AppError) async throws -> AsyncThrowingStream {
//        
//        AsyncThrowingStream{ continuation in
//            var cancellable: AnyCancellable?
//            var finishedWithoutValue = true
//            cancellable = first()
//                .sink { result in
//                    switch result {
//                    case .finished:
//                        if finishedWithoutValue {
//                            continuation.resume(throwing: error)
//                        }
//                    case let .failure(error):
//                        continuation.resume(throwing: error)
//                    }
//                    cancellable?.cancel()
//                } receiveValue: { value in
//                    finishedWithoutValue = false
//                    continuation.resume(returning: value)
//                }
//            
//        }
//    }
    
    
}
