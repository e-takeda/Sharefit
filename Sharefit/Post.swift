//
//  Post.swift
//  Sharefit
//
//  Created by nttr on 2017/10/03.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class Post {
    var objectId: String
    var user: User
    var imageUrl: String
    var text: String
    var createDate: Date
    var isLiked: Bool?
    var comments: [Comment]?
    
    init(objectId: String, user: User, imageUrl: String, text: String, createDate: Date) {
        self.objectId = objectId
        self.user = user
        self.imageUrl = imageUrl
        self.text = text
        self.createDate = createDate
    }
}

