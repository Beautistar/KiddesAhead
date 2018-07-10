//
//  MusicModel.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import Foundation


class MusicModel : Equatable {
    
    var _name = ""
    var _path = ""
    var _length = 240
    var _selected = false
    
    init(name:String, path:String) {
        
        _name = name
        _path = path
    }
    
    static func ==(lhs: MusicModel, rhs: MusicModel) -> Bool {
        return lhs._name == rhs._name
    }
}
