//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Foundation
import Combine

extension FeunoteApp {

    class ViewModel: ObservableObject {
        var sessionState: SessionState {
            authService.sessionState
        }

        private var authService: AuthServiceProtocol

        private var subscribers = Set<AnyCancellable>()

        init(manager: AppServiceManagerProtocol = AppServiceManager.shared) {
            self.authService = manager.authService
            observeState()
        }

        private func observeState() {
            authService.sessionStatePublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.objectWillChange.send()
                }
                .store(in: &subscribers)
        }
    }
}
