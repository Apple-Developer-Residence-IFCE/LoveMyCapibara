//
//  TasksListView.swift
//  LoveMyCapibara
//
//  Created by Gustavo Holzmann on 28/06/23.
//

import SwiftUI

struct TasksListView: View {
    
    @StateObject var tasksListViewModel = TasksListViewModel()
    let columns = [GridItem()]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Tarefas pendentes")
                    .font(FontManager.poppinsBold(size: 20))
                    .foregroundColor(Color("PrimaryText"))
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(tasksListViewModel.tasks, id: \.id) { task in
                        NavigationLink {
                            // TaskDetailedView()
                        } label: {
                            TaskCardView(
                                task: task,
                                time: tasksListViewModel.timeFormatter(task: task)
                            )
                        }
                    }
                }
                .padding(.top)
                if !tasksListViewModel.showToDoTasks {
                    EmptyToDoList()
                }
                if tasksListViewModel.showCompletedTasks {
                    CompletedToDoList(tasksListViewModel: tasksListViewModel)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TasksListViewModel()
        viewModel.tasks = [
            TaskModel(
                id: UUID(),
                title: "Comprar brinquedo",
                type: TaskTypeModel.others,
                pet: PetModel(),
                date: .now,
                text: "no pet shop",
                completed: true
            )
        ]
//        viewModel.completedTasks = [
//            TaskModel(
//                id: UUID(),
//                title: "Comprar Comida",
//                type: TaskTypeModel.others,
//                pet: PetModel(),
//                date: .now,
//                text: "no supermercado",
//                completed: true
//            )
//        ]
        return VStack {
            TasksListView(tasksListViewModel: viewModel)
        }
    }
}
