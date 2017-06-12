//
//  CommonFunctions.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/9.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import UIKit

class CommonFunction {

    
    static func checkEmailFormat(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                return false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    
    static func checkPasswordFormat(_ password: String) -> Bool {
        
        let passwordRegEx = "(?=.*[a-zA-Z])(?=.*[0-9]).{8,}"
        
        do {
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = password as NSString
            let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                return false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    
}
