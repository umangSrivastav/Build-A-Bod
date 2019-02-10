//
//  MyUser.swift
//  Chat1
//
//  Created by Micah Yong on 1/14/19.
//  Copyright © 2019 Micah Yong. All rights reserved.
//

import UIKit

class MyUser: NSObject {
    
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    var points: Int = 0
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }

}
