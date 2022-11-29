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
    func queryAction(branchID: String, actionType: ActionType) async throws -> AmplifyAction? {
        let predicate = AmplifyAction.keys.toBranch.eq(branchID) && AmplifyAction.keys.actionType.eq(actionType.rawValue)
        return try await dataStoreService.query(AmplifyAction.self, where: predicate, sort: nil, paginate: nil).first
    }


    func querySources(creatorID: String ) async throws -> [AmplifySource] {
        return try await dataStoreService.query(AmplifySource.self, where: (AmplifySource.keys.creatorID == creatorID) as QueryPredicate, sort: .ascending(AmplifySource.CodingKeys.createAt), paginate: .page(20))
    }

    func saveMessage(message: AmplifyMessage) async throws -> AmplifyMessage {
        return try await dataStoreService.save(message, where: nil)
    }

    func deleteMessage(message: AmplifyMessage) async throws {
        try await dataStoreService.delete(message, where: nil)
    }

    func saveComment(comment: AmplifyComment) async throws -> AmplifyComment {
        return try await dataStoreService.save(comment, where: nil)
    }

    func deleteComment(comment: AmplifyComment) async throws {
        try await dataStoreService.delete(comment, where: nil)
    }


    func queryParticipants(userID: String) async throws -> [AmplifyAction] {

        let predicate = (AmplifyAction.keys.actionType == ActionType.participate.rawValue && AmplifyAction.keys.creator == userID)

        return try await dataStoreService.query(AmplifyAction.self, where: predicate, sort: .ascending(AmplifyAction.keys.createdAt), paginate: nil)
    }


    func queryOpenBranch(page:QueryPaginationInput?) async throws -> [AmplifyBranch] {

        let predicate = (AmplifyBranch.keys.privacyType == PrivacyType.open)

        return try await dataStoreService.query(AmplifyBranch.self, where: predicate, sort: .descending(AmplifyBranch.keys.numOfSubs), paginate: page)
    }

    func queryOpenBranchByID(branchID: String) async throws -> AmplifyBranch? {
        return try await dataStoreService.query(AmplifyBranch.self, byId: branchID)
    }

    func saveAction(action: AmplifyAction) async throws -> AmplifyAction {
        return try await dataStoreService.save(action, where: nil)
    }

    func deleteAction(action: AmplifyAction) async throws {
        try await dataStoreService.delete(action, where: nil)
    }


    func queryComments(branchID: String) async throws -> [AmplifyComment] {
        let predicate = (AmplifyComment.keys.toBranch == branchID)
        return try await dataStoreService.query(AmplifyComment.self, where: predicate, sort: .descending(AmplifyComment.keys.createdAt), paginate: .firstPage)
    }

    func querySubs(where predicate: QueryPredicate) async throws -> [AmplifyAction]{
        return try await dataStoreService.query(AmplifyAction.self, where: predicate, sort: .descending(AmplifyAction.keys.createdAt), paginate: .firstPage)

    }

    func queryMessages(branchID: String) async throws -> [AmplifyMessage] {
        let predicate = (AmplifyAction.keys.toBranch == branchID)
        return try await dataStoreService.query(AmplifyMessage.self, where: predicate, sort: .ascending(AmplifyMessage.keys.createdAt), paginate: .firstPage)
    }

    func queryMembers(branchID: String) async throws -> [AmplifyUser] {
        let predicate = (AmplifyAction.keys.toBranch == branchID) && (AmplifyAction.keys.actionType == ActionType.participate.rawValue)
        return try await dataStoreService.query(AmplifyAction.self, where: predicate, sort: .ascending(AmplifyAction.keys.createdAt), paginate: .firstPage).map { $0.creator }
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

    func observeQueryCommits(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyCommit>, DataStoreError> {
        return dataStoreService.observeQuery(AmplifyCommit.self, where: predicate, sort: sortInput, paginate: paginationInput)
    }

    func observeQueryBranches(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyBranch>, DataStoreError> {
        return dataStoreService.observeQuery(AmplifyBranch.self, where: predicate, sort: sortInput, paginate: paginationInput)
    }

    func observeQueryMessages(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyMessage>, DataStoreError> {
        return dataStoreService.observeQuery(AmplifyMessage.self, where: predicate, sort: sortInput, paginate: paginationInput)
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
        return try await dataStoreService.save(user, where: nil)
    }

    func saveBranch(_ branch: AmplifyBranch) async throws -> AmplifyBranch {

        return try await dataStoreService.save(branch, where: nil)
    }

    func deleteBranch(_ branchID: String) async throws {


        try await dataStoreService.delete(AmplifyBranch.self, withId: branchID, where: nil)
    }

    func saveCommit(_ commit: AmplifyCommit) async throws -> AmplifyCommit {

        return try await dataStoreService.save(commit, where: nil)
    }

    func deleteCommit(_ commitID: String) async throws {
        return try await dataStoreService.delete(AmplifyCommit.self, withId: commitID, where: nil)
    }


    // Source
    func saveSource(source: AmplifySource) async throws -> AmplifySource {
        return try await dataStoreService.save(source, where: nil)
    }
}
