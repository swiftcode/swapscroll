//
//  Regex.swift
//  swapscroll
//
//  Created by mpc on 4/12/15.
//  Copyright (c) 2015 mpc. All rights reserved.
//

import Foundation

class Regex {
    let expression: NSRegularExpression?
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        var error : NSError?
        
        do {
            self.expression = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        } catch let error1 as NSError {
            error = error1
            self.expression = nil
        }
        
        if error != nil {
            if let _ = expression {
                print("Regex error")
            }
        }
    }
    
    func test(input: String) -> Bool {
        if let expression = self.expression {
            let matches = expression.matchesInString(input, options: [], range:NSMakeRange(0, input.characters.count)) 
            return matches.count > 0
        }
        
        return false
    }
}