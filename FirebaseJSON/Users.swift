//
//  Users.swift
//  NetworkManagerJSONSample
//
//  Created by Kevinho Morales on 23/11/20.
//

import Foundation

struct Users {
    var documents: [Documents]
}

struct Documents {
    var name: String
    var fields: Fields
    var createTime: String
    var updateTime: String
}

struct Fields {
    var from: From
    var to: To
}

struct From {
    var stringValue: String
}

struct To {
    var stringValue: String
}
