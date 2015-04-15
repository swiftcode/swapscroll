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
        
        self.expression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)
        
        if error != nil {
            if let expression = expression {
                
            }
        }
    }
    
    func test(input: String) -> Bool {
        if let expression = self.expression {
            let matches = expression.matchesInString(input, options: nil, range:NSMakeRange(0, countElements(input))) 
            return matches.count > 0
        }
        
        return false
    }
}