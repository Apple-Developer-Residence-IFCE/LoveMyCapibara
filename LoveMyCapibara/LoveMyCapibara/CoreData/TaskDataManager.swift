//
//  TaskDataManager.swift
//  LoveMyCapibara
//
//  Created by Ravi on 29/06/23.
//

import Foundation
import CoreData

protocol TaskDataManagerProtocol {
    func getAllTasks() -> [TaskModel]?
    func getTaskById(_ id: UUID) -> TaskModel?
    func createTask(_ task: TaskModel) -> Bool
    func updateTask(_ task: TaskModel) -> Bool
    func deleteTaskById(_ id: UUID) -> Bool
    func getAllPetTasks(_ pet: PetModel) -> [TaskModel]?
}

class TaskDataManager: TaskDataManagerProtocol {
    var context: NSManagedObjectContext
    static let shared = TaskDataManager()
    
    private init() {
        self.context = CoreDataManager.shared.viewContext
    }
    
    func getAllTasks() -> [TaskModel]? {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result.map { task in
                    .init(taskCoreData: task)
            }
        } catch {
            return []
        }
    }
    
    func getTaskById(_ id: UUID) -> TaskModel? {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "taskId == %@", id as CVarArg)
        do {
            let result = try context.fetch(fetchRequest)
            guard let taskEntity = result.first else {
                return nil
            }
            return .init(.init(taskCoreData: taskEntity))
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    @discardableResult
    func createTask(_ task: TaskModel) -> Bool {
        let petManager = PetDataManager.shared
        let newTask = Task(context: context)
        
        newTask.taskId = task.id
        newTask.title = task.title
        newTask.date = task.date
        newTask.pet = petManager.getCoreDataPet(task.pet?.id ?? UUID())
        newTask.frequency = task.frequency?.rawValue
        newTask.type = task.type?.rawValue
        newTask.text = task.text
        newTask.rememberAt = task.rememberAt?.rawValue
        newTask.completed = [String: Bool]() as NSObject
        
        do {
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    func updateTask(_ task: TaskModel) -> Bool {
        let petManager = PetDataManager.shared
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "taskId == %@", task.id?.uuidString as? CVarArg ?? [0])
        
        do {
            let result = try context.fetch(fetchRequest)
            let taskEntity = result.first
            
            if let taskEntity = taskEntity {
                taskEntity.date = task.date
                taskEntity.title = task.title
                taskEntity.frequency = task.frequency?.rawValue
                taskEntity.pet = petManager.getCoreDataPet(task.pet?.id ?? UUID())
                taskEntity.type = task.type?.rawValue
                taskEntity.text = task.text
                taskEntity.rememberAt = task.rememberAt?.rawValue
                taskEntity.completed = task.completed as? NSObject
                try context.save()
            }
            return true
            
        } catch {
            print("Erro ao atualizar task do CoreData: \(error.localizedDescription)")
            return false
        }
    }
    
    @discardableResult
    func deleteTaskById(_ id: UUID) -> Bool {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "taskId == %@", id as CVarArg)
        
        do {
            let result = try context.fetch(fetchRequest)
            let taskEntity = result.first
            
            if let taskEntity {
                context.delete(taskEntity)
                try context.save()
            }
            return true
            
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getAllPetTasks(_ pet: PetModel) -> [TaskModel]? {
        let result = getAllTasks()?.filter({ $0.pet?.name == pet.name })
        guard let result = result else { return nil }
        return result
    }
}
