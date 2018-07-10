//
//  UserModel.swift
//  KiddiesAhead
//
//  Created by sts on 4/2/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserModel : Equatable {
    
    var _id = 0
    var _username = ""
    var _email = ""
    var _age = 0
    var _attend = false
    var _enEnd : Date?
    var _esEnd : Date?
    var _frEnd : Date?
    var _ybEnd : Date?
    
    var _spentMins = 0
    var _lastSpent = Date()
    
    init() {}
    
    init(id : Int, username : String, email : String) {
        _id = id
        _username = username
        _email = email
    }
    
    init(dict: JSON) {
        
        _id = dict[Constants.RES_USERID].intValue
        _username = dict[Constants.RES_USERNAME].stringValue
        _email = dict[Constants.RES_EMAIL].stringValue
        _age = dict[Constants.RES_AGE].intValue
        _attend = (dict[Constants.RES_ATTEND].intValue == 1)
        _spentMins = dict[Constants.RES_SPENT].intValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        
        if let enEnd = dict[Constants.RES_ENEND].string {
            _enEnd = dateFormatter.date(from:enEnd)!
        }
        
        if let esEnd = dict[Constants.RES_ESEND].string {
            _esEnd = dateFormatter.date(from:esEnd)!
        }
        
        if let frEnd = dict[Constants.RES_FREND].string {
            _frEnd = dateFormatter.date(from:frEnd)!
        }
        
        if let ybEnd = dict[Constants.RES_YBEND].string {
            _ybEnd = dateFormatter.date(from:ybEnd)!
        }
        
        if let lastSpent = dict[Constants.RES_LASTSPENT].string {
            _lastSpent = dateFormatter.date(from: lastSpent) ?? Date()
        }
        
    }
    
    static func ==(lhs:UserModel, rhs:UserModel) -> Bool {
        return lhs._id == rhs._id
    }
}
