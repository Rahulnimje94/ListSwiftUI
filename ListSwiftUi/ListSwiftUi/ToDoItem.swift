//
//  ToDoItem.swift
//  ListSwiftUi
//
//  Created by Rahul on 02/04/24.
//

import Foundation

// Identifiable protocol which then help us to idenfify each item to use the ForEach container:

struct ToDoItem: Identifiable {
    let id: UUID = .init()
    var title: String
}
