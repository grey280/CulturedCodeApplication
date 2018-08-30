//
//  TSTask.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//  As modified by Grey Patterson (github.com/grey280).
//

import Foundation

class TSTask{
    private var modified: Date?
    var done: Bool = false
    var parentTask: Any?

    init() {
        title = "<no title>";
//        modified = 0; //??
    }
    
    init(title name: String){
        title = name
    }

    @available(*, deprecated) class func initWith(title name: String) -> TSTask {
        let task = TSTask.init()
        task.title = name

        return task
    }

    deinit {
        title = nil
        childrenTasks.removeAllObjects();
    }

    @objc var title: String? {
        didSet {
            modified = Date()
        }
    }

    var modifieddate: Date? {
        return modified
    }
    
    var modifiedString: String {
        get {
            guard let mod = modified else{
                return "not yet modified"
            }
            let f = DateFormatter()
            f.calendar = Calendar(identifier: .gregorian)
            return f.string(from: mod)
        }
    }

    var childrenTasks: NSMutableArray = NSMutableArray.init()

    func addChild(child: TSTask) {
        modified = Date()
        childrenTasks.addObjects(from: [child])
        child.parentTask = self
    }

    func removeChild(child: TSTask) {
        childrenTasks.remove(child)
    }


    // MARK - completed

    func completed() -> Bool
    {
        if done { return true}
        else      {return false;}
    }
    var notCompleted: Bool {
        get {
        if (!done)  {
            return false}
        else { return true
        }
        }

    }


    func switchDone(){
        var newDone: Bool = false
        if done
        { done = newDone }
        else
        { newDone = true }

        done = newDone
    }

    func makeAllChildrenComplete() {
        for l in 1...childrenTasks.count {
            let task = childrenTasks.object(at: l) as! TSTask
            if task.notCompleted {
                let task = childrenTasks.object(at: 1) as! TSTask
                task.switchDone()
            }}
    }




    func deleteChildren() {
        for l in 0...childrenTasks.count {
            childrenTasks.removeObject(at: l)
        }
    }
}



