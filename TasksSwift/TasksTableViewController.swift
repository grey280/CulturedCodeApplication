//
//  TasksTableViewController.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//  As modified by Grey Patterson (github.com/grey280).
//

import Foundation
import UIKit

class TasksTableViewController : UITableViewController {
    var tasks: [TSTask]
    init(withTasks: [TSTask]) {
        self.tasks = withTasks
        super.init(style: UITableView.Style.plain)

        self.title = "Tasks"
        self.toolbarItems = [UIBarButtonItem.init(title: "complete all",
                                                  style: UIBarButtonItem.Style.plain,
                                                  target: self,
                                                  action: #selector(completeAll)),
                             UIBarButtonItem.init(title: "sort by name",
                                                  style: UIBarButtonItem.Style.plain,
                                                  target: self,
                                                  action: #selector(sort))]

        self.tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
    }

    required init?(coder aDecoder: NSCoder) {
        guard let ts = aDecoder.decodeObject(forKey: "tasks") as? [TSTask] else{
            return nil
        }
        tasks = ts
        super.init(coder: aDecoder)
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell

        cell.configureStyle()
        let task = self.tasks[indexPath.row]
        cell.task = task

        if (task.children.count  > 0) {
            cell.accessoryType = .detailDisclosureButton
        }else{
            cell.accessoryType = .none
        }

        if task.completed {
            cell.setComplete(true)
        }

        return cell
    }


    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell
        cell.setComplete(!cell.task.completed)

        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell
        let tvc = TasksTableViewController.init(withTasks: cell.task!.children)
        tvc.title = cell.task!.title
        self.navigationController?.pushViewController(tvc, animated: true)
    }

    @objc func completeAll() {
        for cell in self.tableView.visibleCells {
            if let taskCell = cell as? TaskCell {
                taskCell.setComplete(true)
            }
        }
    }

    @objc func sort() {
        tasks.sort(by: { (first, second) -> Bool in
            first.title ?? "" > second.title ?? ""
        })
        // This does a fade animation, which isn't the nice 'things moving around' animation that I'd like, but that'd require a lot more work.
        // To do that would involve a lot of `moveRow(at:to:)` and I'm too lazy to make that work with the `.sort` above
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }
}
