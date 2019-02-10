//
//  Message.swift
//  Chat1
//
//  Created by Micah Yong on 1/16/19.
//  Copyright © 2019 Micah Yong. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {

    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.toId = dictionary["toId"] as? String
    }
    
    func chatPartnerId() -> String? {
        // one line conditional
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
}
