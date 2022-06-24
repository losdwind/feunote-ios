//
//  MomentViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import Foundation
import SwiftUI

class MomentViewModel:ObservableObject {
    internal init(saveMomentUseCase: SaveMomentUseCaseProtocol, deleteMomentUseCase: DeleteMomentUseCaseProtocol, getAllMomentsUseCase: GetAllMomentsUseCaseProtocol) {
        self.saveMomentUseCase = saveMomentUseCase
        self.deleteMomentUseCase = deleteMomentUseCase
        self.getAllMomentsUseCase = getAllMomentsUseCase
    }
    
    
    
    @Published var moment = Moment(title: "", fromUser: User(avatarURL: "", nickName: ""), content: "", wordCount: 0)
    @Published var fetchedAllMoments:[Moment] = [Moment]()
    
    
    @Published var images:[UIImage] = [UIImage]()
    @Published var audios:[NSData] = [NSData]()
    @Published var videos:[NSData] = [NSData]()
    @Published var OwnerItemID: String = ""
    
    private var saveMomentUseCase:SaveMomentUseCaseProtocol
    private var deleteMomentUseCase:DeleteMomentUseCaseProtocol
    private var getAllMomentsUseCase:GetAllMomentsUseCaseProtocol

    @Published var hasError = false
    @Published var appError:AppError?
    
    func saveMoment() async{
        do {
            try await saveMomentUseCase.execute(existingMoment: moment, title: moment.title, content: moment.content, selectedImages: images)
            playSound(sound: "sound-ding", type: "mp3")
            moment = Moment(title: "", fromUser: User(avatarURL: "", nickName: ""), content: "", wordCount: 0)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    
    func deleteMoment(moment: Moment) async {
        
        do {
            try await deleteMomentUseCase.execute(moment: moment)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func getAllMoments(page: Int) async{
        do {
            fetchedAllMoments = try await getAllMomentsUseCase.execute(page: page)
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func getTodayMoments() async -> [Moment] {
        return [Moment]()
    }

    
    
    
}
