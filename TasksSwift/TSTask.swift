//
//  TSTask.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//  As modified by Grey Patterson (github.com/grey280).
//

import Foundation

class TSTask: Equatable{
    static func == (lhs: TSTask, rhs: TSTask) -> Bool {
        return lhs.title == rhs.title && lhs.completed == rhs.completed && lhs.modified == rhs.modified && lhs.children == rhs.children
    }
    
    // MARK: Variables
    public private(set) var modified: Date?
    var completed: Bool = false
    var parentTask: TSTask?
    @objc var title: String? {
        didSet {
            modified = Date()
        }
    }
    var modifiedString: String {
        guard let mod = modified else{
            return "not yet modified"
        }
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        return f.string(from: mod)
    }
    var children = [TSTask]()
    
    // MARK: - Setup
    init(title name: String){
        title = name
    }

    deinit {
        title = nil
        children.removeAll()
    }
    
    // MARK: - Children
    func addChild(_ child: TSTask){
        modified = Date()
        children.append(child)
        child.parentTask = self
    }
    
    func removeChild(_ child: TSTask){
        children = children.filter { $0 != child }
    }
    
    func removeChildren(){
        children.removeAll()
    }


    // MARK - completed
    
    func toggle(){
        completed = !completed
    }
    
    func completeAllChildren(){
        for child in ch{
            child.completed = true
        }
    }
}



