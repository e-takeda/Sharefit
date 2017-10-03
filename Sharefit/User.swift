//
//  User.swift
//  Sharefit
//
//  Created by nttr on 2017/10/03.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class User {
    var objectId: String
    var userName: String
    var displayName: String?
    
    init(objectId: String, userName: String) {
        self.objectId = objectId
        self.userName = userName
    }
}
