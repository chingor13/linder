//
//  Lawyer.swift
//  Linder
//
//  Created by Kyle on 10/15/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import Foundation

class Lawyer {
    var firstname: String
    var lastname: String
    var headshot: UIImage
    
    init(firstname: String, lastname: String, headshot: UIImage) {
        self.firstname = firstname
        self.lastname = lastname
        self.headshot = headshot
    }
}