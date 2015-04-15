//
//  ViewController.swift
//  swapscroll
//
//  Created by mpc on 4/12/15.
//  Copyright (c) 2015 mpc. All rights reserved.
//

import Foundation
import Cocoa
import IOKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        swapScrollDirection()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func mouseDetected() -> Bool {
        var task     = NSTask()
        var pipe     = NSPipe()
        var detected = false
        
        task.launchPath = "/usr/sbin/ioreg"
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: NSUTF8StringEncoding)!
        
        detected = Regex("mouse").test(output)
        
        return detected
    }
    
    func swapScrollDirection() {
        var task = NSTask()
        
        if mouseDetected() {
            let command = ["-c", "defaults write com.apple.swipescrolldirection -bool false"]
            task.launchPath = "/bin/bash"
            task.arguments  = command
        } else {
            let command = ["-c", "defaults write com.apple.swipescrolldirection -bool true"]
            task.launchPath = "/bin/bash"
            task.arguments  = command
        }
        
        task.launch()
    }
}