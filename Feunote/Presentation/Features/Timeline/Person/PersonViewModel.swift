//
//  PersonViewModel.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/25.
//

import Foundation
import CoreData
import MapKit

class PersonViewModel: ObservableObject {
    internal init(savePersonUserCase: SavePersonUseCaseProtocol, getAllPersons: GetAllPersonsUseCaseProtocol, deletePersonUseCase: DeletePersonUseCaseProtocol) {
        self.savePersonUserCase = savePersonUserCase
        self.getAllPersons = getAllPersons
        self.deletePersonUseCase = deletePersonUseCase
    }
    
    private var savePersonUserCase:SavePersonUseCaseProtocol
    private var getAllPersons:GetAllPersonsUseCaseProtocol
    private var deletePersonUseCase:DeletePersonUseCaseProtocol
    
    @Published var person:Person = Person(fromUser: User(avatarURL: "", nickName: ""), description: "", name: "")
    @Published var avatarImage:UIImage = UIImage()
    @Published var images:[UIImage] = [UIImage]()
    @Published var audios:[NSData] = [NSData]()
    @Published var videos:[NSData] = [NSData]()
    @Published var birthday:Date = Date()
    
    @Published var fetchedPersons:[Person] = [Person]()
    
    @Published var hasError = false
    @Published var appError:AppError?
    
    func savePerson() async {
        do {
            try await savePersonUserCase.execute(existingPerson: person, description: person.description, name: person.name, avatarImage: avatarImage)
            playSound(sound: "sound-ding", type: "mp3")
            person = Person(fromUser: User(avatarURL: "", nickName: ""), description: "", name: "")
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }

    }
    
    
    func deletePerson(person: Person) async{
        do {
            try await deletePersonUseCase.execute(person: person)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    
    
    
    func fetchAllPersons(page:Int) async {
        do {
            fetchedPersons = try await getAllPersons.execute(page: 1)
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func fetchTodayPersons(page:Int) async {
    }
    
    
    
    
    
    
}
