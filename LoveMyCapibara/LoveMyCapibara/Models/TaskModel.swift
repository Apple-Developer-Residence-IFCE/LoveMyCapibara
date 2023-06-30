//
//  TaskModel.swift
//  LoveMyCapibara
//
//  Created by Ravi on 28/06/23.
//

import Foundation

struct TaskModel {
    var title: String?
    var type: TaskTypeModel?
    var pet: PetModel?
    var date: Date?
    var frequency: FrequencyModel?
    var text: String?
    var id: UUID?
    
    init(title: String? = nil, type: TaskTypeModel? = nil, pet: PetModel? = nil, date: Date? = nil, frequency: FrequencyModel? = nil, text: String? = nil, id: UUID? = nil) {
        self.title = title
        self.type = type
        self.pet = pet
        self.date = date
        self.frequency = frequency
        self.text = text
        self.id = id
    }
    
    init(taskCoreData: Task, pet: PetModel) {
        self.title = taskCoreData.title
        self.type = TaskTypeModel(rawValue: taskCoreData.type ?? "") ?? .empty
        self.pet = pet
        self.date = taskCoreData.date
        self.frequency = FrequencyModel(rawValue: taskCoreData.frequency ?? "") ?? .none
        self.text = taskCoreData.text
        self.id = UUID()
    }
    
    static var mock: TaskModel = .init(title: "Piedro", type: TaskTypeModel.leisure, pet: PetModel(), date: .now, frequency: FrequencyModel.daily, id: UUID())
}

