//
//  DataStoreRepositoryProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Amplify
import Combine
import Foundation

protocol DataStoreRepositoryProtocol {
    var amplifyUser: AmplifyUser? { get }

    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }
    func configure(_ sessionState: Published<SessionState>.Publisher)
    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>

    func queryUsers(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyUser]

    func queryCommits(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyCommit]

    func queryBranches(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyBranch]
    func observeQueryCommits(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyCommit>, DataStoreError>

    func observeQueryBranches(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyBranch>, DataStoreError>

    func observeQueryMessages(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyMessage>, DataStoreError>

    func queryUser(byID: String) async throws -> AmplifyUser?
    func queryBranch(byID: String) async throws -> AmplifyBranch?
    func queryCommit(byID: String) async throws -> AmplifyCommit?

    // User
    func saveUser(_ user: AmplifyUser) async throws -> AmplifyUser
    func queryMembers(branchID: String) async throws -> [AmplifyUser]


    // AmplifyBranch
    func saveBranch(_ branch: AmplifyBranch) async throws -> AmplifyBranch
    func deleteBranch(_ branchID: String) async throws

    // AmplifyCommit
    func saveCommit(_ commit: AmplifyCommit) async throws -> AmplifyCommit
    func deleteCommit(_ commitID: String) async throws

    // AmplifyAction
    func saveAction(action: AmplifyAction) async throws -> AmplifyAction
    func deleteAction(action: AmplifyAction) async throws
    func querySubs(where predicate: QueryPredicate) async throws -> [AmplifyAction]
    func queryParticipants(userID: String) async throws -> [AmplifyAction]
    func queryAction(branchID: String, actionType:ActionType) async throws -> AmplifyAction?

    // AmplifyMessage
    func saveMessage(message: AmplifyMessage) async throws -> AmplifyMessage
    func deleteMessage(message: AmplifyMessage) async throws
    func queryMessages(branchID: String) async throws -> [AmplifyMessage]

    // AmplifyComments
    func saveComment(comment: AmplifyComment) async throws -> AmplifyComment
    func deleteComment(comment: AmplifyComment) async throws
    func queryComments(branchID: String) async throws -> [AmplifyComment]

    // AmplifySource
    func saveSource(source: AmplifySource) async throws -> AmplifySource
    func querySources(creatorID: String) async throws -> [AmplifySource]


    // Open Branch from Remote API
    func queryOpenBranch(page: QueryPaginationInput?) async throws -> [AmplifyBranch]
    func queryOpenBranchByID(branchID: String) async throws -> AmplifyBranch?


}
