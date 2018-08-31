//
//  TSUtilities.swift
//  TasksSwift
//
//  Created by Grey Patterson on 8/30/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import UIKit

/// Utilities to use in the app, because why make AppDelegate bigger than it needs to be?
struct TSUtilities{
    static let titleKey = "title"
    static let completedKey = "completed"
    static let childrenKey = "children"
    
    static let completeImage = UIImage(named: "Checkbox-Checked.png")
    static let incompleteImage = UIImage(named: "Checkbox-Empty.png")
    
    /// Generate the default tasks
    ///
    /// - Returns: a nice array with the default set of tasks
    static func generateTasks() -> [TSTask]{
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
        return TSUtilities.taskFromDescriptions(taskDescriptions)
    }
    
    static func taskFromDescriptions(_ descriptions: Array<[String:Any]>) -> [TSTask]{
        var tasks = [TSTask]()
        for taskDesc in descriptions{
            guard let title = taskDesc[titleKey] as? String, let completed = taskDesc[completedKey] as? Bool else{
                continue
            }
            let task = TSTask(title: title)
            task.completed = completed
            if let wrappedChildren = taskDesc[childrenKey] as? Array<[String:Any]>, wrappedChildren.count > 0{
                let children = taskFromDescriptions(wrappedChildren)
                for child in children{
                    task.addChild(child)
                }
            }
            tasks.append(task)
        }
        return tasks
    }
}
