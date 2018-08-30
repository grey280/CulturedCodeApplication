//
//  TSUtilities.swift
//  TasksSwift
//
//  Created by Grey Patterson on 8/30/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

/// Utilities to use in the app, because why make AppDelegate bigger than it needs to be?
struct TSUtilities{
    static let titleKey = "title"
    static let completedKey = "completed"
    static let childrenKey = "children"
    
    /// Generate the default tasks
    ///
    /// - Returns: a nice array with the default set of tasks
    static func generateTasks() -> NSArray{
        let taskDescriptions = [
            [ titleKey: "Buy milk", completedKey: false],
            [ titleKey: "Pay rent", completedKey: false],
            [ titleKey: "Change tires", completedKey: false],
            [ titleKey: "Sleep", completedKey: false, childrenKey: [
                [ titleKey: "Find a bed", completedKey: false],
                [ titleKey: "Lie down", completedKey: false],
                [ titleKey: "Close eyes", completedKey: false],
                [ titleKey: "Wait", completedKey: false]
            ]],
            [ titleKey: "Dance", completedKey: false]
        ]
        return taskFromDescriptions(taskDescriptions)
    }
}

func _taskFromDescriptions(_ descriptions: Array<[String:Any]>) -> NSArray {
    let tasks = NSMutableArray.init()
    
    for taskDescription in descriptions {
        let title = taskDescription[kTitle] as! String
        let completed = taskDescription[kCompleted] as! Bool
        let childrenDescriptions = taskDescription[kChildren] as! Array<[String:Any]>?
        
        let task = TSTask.initWith(title: title)
        task.childrenTasks = NSMutableArray.init(array: [])
        if completed != task.completed() { task.switchDone() }
        
        if childrenDescriptions != nil && childrenDescriptions!.count > 0 {
            let children = self._taskFromDescriptions(childrenDescriptions!)
            for child in children {
                task.addChild(child: child as! TSTask)
                NSLog("adding")
            }
        }
        
        tasks.addObjects(from: [task])
    }
    
    return tasks
}
