//
//  TaskDataManager.swift
//  LoveMyCapibara
//
//  Created by Ravi on 29/06/23.
//

import Foundation
import CoreData

class TaskDataManager {
    var context: NSManagedObjectContext

    init() {
        self.context = CoreDataManager.shared.viewContext
    }
    
//    func getAllTasks() -> [TaskModel] {
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//
//        do {
//            let result = try context.fetch(request)
//            return result.map { task in
//                convertToPetModel(pet)
//            }
//        } catch {
//            return []
//        }
//    }

    func getPetById(_ id: UUID) -> PetModel? {
        let fetchRequest: NSFetchRequest<Pet> = Pet.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
        do {
            let result = try context.fetch(fetchRequest)
            guard let petEntity = result.first else {
                return nil
            }
            return convertToPetModel(petEntity)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func createPet(_ pet: PetModel) {
        let newPet = Pet(context: context)
        newPet.image = pet.imageName
        newPet.name = pet.name
        newPet.gender = pet.gender.description
        newPet.specie = pet.specie
        newPet.race = pet.race
        newPet.birthdate = pet.birthDate
        newPet.weight = pet.weight
        newPet.castrated = pet.castrated
        newPet.id = UUID()

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func updatePet(_ pet: PetModel) {
        let fetchRequest: NSFetchRequest<Pet> = Pet.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", pet.id as CVarArg)
    
        do {
            let result = try context.fetch(fetchRequest)
            let petEntity = result.first
        
            if let petEntity = petEntity {
                petEntity.name = pet.name
                petEntity.gender = pet.gender.rawValue
                petEntity.specie = pet.specie
                petEntity.race = pet.race
                petEntity.birthdate = pet.birthDate
                petEntity.weight = pet.weight
                petEntity.castrated = pet.castrated
                petEntity.image = pet.imageName
            
                try context.save()
            }
        } catch {
            print("Erro ao atualizar pet do CoreData: \(error.localizedDescription)")
        }
    }

    func deletePetById(_ id: UUID) {
        let fetchRequest: NSFetchRequest<Pet> = Pet.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
        do {
            let result = try context.fetch(fetchRequest)
            let playerEntity = result.first
        
            if let playerEntity = playerEntity {
                // Remover o petEntity do contexto e salvar as mudanças
                context.delete(playerEntity)
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func convertToPetModel(_ petEntity: Pet) -> PetModel {
        var petModel = PetModel()
        petModel.id = petEntity.id ?? UUID()
        petModel.name = petEntity.name ?? ""
        petModel.gender = GenderModel(rawValue: petEntity.gender ?? "") ?? .none
        petModel.specie = petEntity.specie ?? ""
        petModel.race = petEntity.race ?? ""
        petModel.birthDate = petEntity.birthdate ?? Date.now
        petModel.weight = petEntity.weight
        petModel.castrated = petEntity.castrated
        petModel.imageName = petEntity.image ?? Data()

        return petModel
    }
}