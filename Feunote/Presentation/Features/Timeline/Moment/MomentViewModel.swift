//
//  MomentViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit

class MomentViewModel:ObservableObject {
    
    @Published var moment = Moment()
    @Published var fetchedMoments = [Moment]()
    
    
    @Published var images:[UIImage] = [UIImage]()
    @Published var audios:[NSData] = [NSData]()
    @Published var videos:[NSData] = [NSData]()
    @Published var OwnerItemID: String = ""
    
    private var saveMomentUseCase:SaveMomentUseCaseProtocol
    private var deleteMomentUseCase:DeleteMomentUseCaseProtocol
    private var getAllMomentsUseCase:GetAllMomentsUseCaseProtocol

    
    
    func saveMoment() async -> Moment {
        
    }
    
    
    func deleteMoment(moment: Moment) async {
        
        
    }
    
    
    func getAllMoments() async -> [Moment] {
        
    }
    
    
    func getTodayMoments() async -> [Moment] {

    }

    
    
    
}
