//
//  ContentView.swift
//  ListSwiftUi
//
//  Created by Rahul on 02/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var todayTodos: [ToDoItem] = [
        .init(title: "Exercise 30 mins"),
        .init(title: "Read one Article"),
        .init(title: "Research SwiftUI")
    ]
    
    @State private var tomorrowTodos: [ToDoItem] = [
        .init(title: "Make a new friend"),
        .init(title: "Study English"),
        .init(title: "Research UIKit")
    ]
    
    @State private var multiSelection = Set<UUID>()
    
    
    var body: some View {
        
        NavigationStack {
            List(selection: $multiSelection) {
                    Section {
                        ForEach(todayTodos, id: \.id) { todo in
                            Text(todo.title)
                        }.onDelete(perform: { indexSet in
                            todayTodos.remove(atOffsets: indexSet)
                        }).onMove(perform: { indices, newOffset in
                            todayTodos.move(fromOffsets: indices, toOffset: newOffset)
                        })
                    } header: {
                        Text(Date().formatted(date: .abbreviated, time: .omitted)).fontWeight(.semibold).foregroundStyle(.blue)
                    } footer: {
                        Text("To do List")
                    }
                    
                    Section {
                        ForEach(tomorrowTodos, id: \.id) { todo in
                            Text(todo.title)
                        }.onDelete(perform: { indexSet in
                            tomorrowTodos.remove(atOffsets: indexSet)
                        }).onMove(perform: { indices, newOffset in
                            tomorrowTodos.move(fromOffsets: indices, toOffset: newOffset)
                        })
                    } header: {
                        Text("Tomorrow").fontWeight(.semibold).foregroundStyle(.blue)
                    } footer: {
                        Text("Consistence is the key")
                    }
            }
            .listStyle(.plain) // Remove or modifier to apply a different ListStyle
            .refreshable {
                var copyToday = todayTodos
                var copyTomorrow = tomorrowTodos
                
                copyToday.append(.init(title: "Complete all task at work"))
                copyTomorrow.append(.init(title: "Draw a flower"))
                todayTodos.removeAll()
                tomorrowTodos.removeAll()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    todayTodos = copyToday
                    tomorrowTodos = copyTomorrow
                }
            }
            .navigationTitle("Todo List")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            })
        }
        
    }
}

#Preview {
    ContentView()
}
