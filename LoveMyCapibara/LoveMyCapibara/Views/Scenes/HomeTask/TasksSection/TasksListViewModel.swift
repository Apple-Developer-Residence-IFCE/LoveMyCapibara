//
//  TaskListViewModel.swift
//  LoveMyCapibara
//
//  Created by Gustavo Holzmann on 29/06/23.
//

import Foundation

class TasksListViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
   
    var completedTasks: [TaskModel] {
        return tasks.filter({ $0.completed ?? false })
    }

    var unfinishedTasks: [TaskModel] {
        return tasks.filter({ !($0.completed ?? false)})
    }
    
    let taskManager = TaskDataManager()
    
    var showToDoTasks: Bool {
        if unfinishedTasks.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var showCompletedTasks: Bool {
        if completedTasks.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func updateList() {
        self.tasks = taskManager.getAllTasks()
    }

    func timeFormatter(task: TaskModel) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: task.date)
    }
    
}
