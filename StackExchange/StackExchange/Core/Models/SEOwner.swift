//
//  SEOwner.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation

class SEOwner {
    let displayName: String?
    let profileImage: String?
    
    init(jsonDictionary: Dictionary<String, AnyObject>) {
        displayName = (jsonDictionary["display_name"] as? String)
        profileImage = (jsonDictionary["profile_image"] as? String)
    }
}
