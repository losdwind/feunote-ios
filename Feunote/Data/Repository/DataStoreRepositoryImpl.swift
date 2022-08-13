//
//  DataStoreRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Amplify
import Combine
import Foundation
import UIKit

class DataStoreRepositoryImpl: DataStoreRepositoryProtocol {


    func queryOpenBranch(field: String, location: String, status: String) async throws -> [AmplifyBranch] {
        return try await dataStoreService.queryOpenBranch(field: field, location: location, status: status)
    }

    func queryOpenBranchByID(branchID: String) async throws -> AmplifyBranch? {
        return try await dataStoreService.queryOpenBranchByID(branchID: branchID)
    }

    func saveAction(action: AmplifyAction) async throws -> AmplifyAction {
        return try await dataStoreService.saveAction(action: action)
    }

    func deleteAction(action: AmplifyAction) async throws {
        try await dataStoreService.deleteAction(action: action)
    }


    func queryComments(branchID: String) async throws -> [AmplifyAction] {
        return try await dataStoreService.queryActions(branchID: branchID, actionType: ActionType.comment, limit: 100)
    }

    func queryMessages(branchID: String) async throws -> [AmplifyAction] {
        return try await dataStoreService.queryActions(branchID: branchID, actionType: ActionType.message, limit: 100)
    }

    func queryMembers(branchID: String) async throws -> [AmplifyUser] {
        return try await dataStoreService.queryActions(branchID: branchID, actionType: .participate, limit: 10).map { $0.creator }
    }


    func queryUsers(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyUser] {
        return try await dataStoreService.query(AmplifyUser.self, where: predicate, sort: sortInput, paginate: paginationInput)
    }

    func queryCommits(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyCommit] {
        return try await dataStoreService.query(AmplifyCommit.self, where: predicate, sort: sortInput, paginate: paginationInput)
    }

    func queryBranches(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyBranch] {
        return try await dataStoreService.query(AmplifyBranch.self, where: predicate, sort: sortInput, paginate: paginationInput)
    }


    func queryUser(byID: String) async throws -> AmplifyUser? {
        return try await dataStoreService.query(AmplifyUser.self, byId: byID)
    }

    func queryBranch(byID: String) async throws -> AmplifyBranch? {
        return try await dataStoreService.query(AmplifyBranch.self, byId: byID)
    }

    func queryCommit(byID: String) async throws -> AmplifyCommit? {
        return try await dataStoreService.query(AmplifyCommit.self, byId: byID)
    }

    func query<M: Model>(_ model: M.Type, where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [M] {
        return try await dataStoreService.query(model, where: predicate, sort: sortInput, paginate: paginationInput)
    }

    func query<M:Model>(_ model: M.Type, byId: String) async throws -> M? {
        return try await dataStoreService.query(model, byId: byId)
    }

    private let dataStoreService: DataStoreServiceProtocol
    private let storageService: StorageServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    internal init(dataStoreService: DataStoreServiceProtocol, storageService: StorageServiceProtocol) {
        self.dataStoreService = dataStoreService
        self.storageService = storageService
    }

    var amplifyUser: AmplifyUser? {
        dataStoreService.user
    }

    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> {
        dataStoreService.eventsPublisher
    }

    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher) {
        dataStoreService.configure(sessionStatePublisher)
    }

    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError> {
        dataStoreService.dataStorePublisher(for: model)
    }

    func saveUser(_ user: AmplifyUser) async throws -> AmplifyUser {
        return try await dataStoreService.saveUser(user)
    }

    func saveBranch(_ branch: AmplifyBranch) async throws -> AmplifyBranch {

        return try await dataStoreService.saveBranch(branch)
    }

    func deleteBranch(_ branchID: String) async throws {


        try await dataStoreService.deleteBranch(branchID)
    }

    func saveCommit(_ commit: AmplifyCommit) async throws -> AmplifyCommit {

        return try await dataStoreService.saveCommit(commit)
    }

    func deleteCommit(_ commitID: String) async throws {
        return try await dataStoreService.deleteCommit(commitID)
    }
}
