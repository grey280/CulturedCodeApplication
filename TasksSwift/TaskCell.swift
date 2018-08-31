//
//  TaskCell.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//  As modified by Grey Patterson (github.com/grey280).
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
    var task: TSTask? {
        didSet {
            self.textLabel?.text = task?.title
        }
    }

    required init?(coder aDecoder: NSCoder) {
        task = aDecoder.decodeObject(forKey: "task") as? TSTask
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageView?.image = UIImage(named: "Checkbox-Empty.png")
    }

    func configureStyle() {
        self.textLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
        self.textLabel?.textColor = UIColor.black
    }

    func setInactive() {
        self.textLabel?.textColor = UIColor.lightGray
        imageView?.image = UIImage(named: "Checkbox-Checked.png")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Configure image
        var r = self.imageView?.bounds
        r?.origin.x = 0
        imageView?.frame = r!

        // Configure Title
        r = self.textLabel?.bounds;
        r?.origin.x = 40
        self.textLabel?.frame = r!

        // Switch Image
        if task!.completed {
            imageView?.image = UIImage(named: "Checkbox-Checked.png")
        }else{
            imageView?.image = UIImage(named: "Checkbox-Empty.png")
        }
    }
}
