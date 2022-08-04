//
//  RemoteApiProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/3.
//

import Foundation
protocol RemoteApiRepositoryProtocol {
    func queryOECDInfo(location: String) async -> BetterLifeIndexData?
}
