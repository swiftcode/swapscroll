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

        //TODO: look into creating status items.
        swapScrollDirection()
        exit(0)   //TODO: This will not happen.  Run continuously.
    }

    func mouseDetected() -> Bool {
        let task     = Process()
        let pipe     = Pipe()
        var detected = false
        
        task.launchPath = "/usr/sbin/ioreg"
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        
        detected = Regex("mouse").test(output)
        
        return detected
    }
    
    func swapScrollDirection() {
        let task    = Process()
        var command = [String]()
        
        if mouseDetected() {
            command = ["-c", "defaults write com.apple.swipescrolldirection -bool false"]
        } else {
            command = ["-c", "defaults write com.apple.swipescrolldirection -bool true"]
        }
        
        task.launchPath = "/bin/bash"
        task.arguments  = command
        task.launch()
    }
}
