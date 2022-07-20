//
//  DataMapperProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Foundation
protocol ViewDataMapperProtocol {
    func commitDataTransformer(commit:FeuCommit) async throws -> AmplifyCommit
    func commitDataTransformer(commit:AmplifyCommit) async throws -> FeuCommit
    func branchDataTransformer(branch:FeuBranch) async throws -> AmplifyBranch
    func branchDataTransformer(branch:AmplifyBranch) async throws -> FeuBranch
    func userDataTransformer(user:FeuUser) async throws -> AmplifyUser
    func userDataTransformer(user:AmplifyUser) async throws -> FeuUser
}
