//
//  FeunoteAppViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation
import Combine

extension FeunoteApp{
    class ViewModel: ObservableObject {
        var sessionState: SessionState {
            authRepo.sessionState
        }

        private var authRepo: AuthRepositoryProtocol

        private var subscribers = Set<AnyCancellable>()

        init(authRepo:AuthRepositoryProtocol) {
            self.authRepo = authRepo
            observeState()
        }

        private func observeState() {
            authRepo.sessionStatePublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.objectWillChange.send()
                }
                .store(in: &subscribers)
        }
    }
}

