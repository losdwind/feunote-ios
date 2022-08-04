//
//  ScoreCommunityViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/3.
//



import Foundation
class ScoreCommunityViewModel:ObservableObject {
    @Published var betterLifeIndex:BetterLifeIndexData?
    @Published var location:String

    init(location:String){
        self.location = location
    }
    
}
