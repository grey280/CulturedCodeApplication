//
//  AppDelegate.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//  As modified by Grey Patterson (github.com/grey280).
//
import UIKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tasksTableViewController: TasksTableViewController!
    var navigationController: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.tasksTableViewController = TasksTableViewController.init(withTasks: TSUtilities.generateTasks())
        self.navigationController = UINavigationController.init(rootViewController: self.tasksTableViewController)
        self.navigationController.isToolbarHidden = false
        self.window?.rootViewController = self.navigationController
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()

        return true
    }
}
