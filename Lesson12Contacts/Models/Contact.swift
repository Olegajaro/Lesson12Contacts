//
//  Contact.swift
//  Lesson12Contacts
//
//  Created by Олег Федоров on 02.10.2021.
//

import Foundation

struct Contact {
    let name: String
    let surname: String
    
    var fullName: String {
        "\(name) \(surname)"
    }
}
