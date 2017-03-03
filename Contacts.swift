//
//  Contacts.swift
//  Contacts
//
//  Created by Hayden Hastings on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit

class Contacts {
    
    private let nameKey = "name"
    private let phoneNumberKey = "phoneNumber"
    private let emailKey = "email"
    
    let name: String
    let phoneNumber: String
    let email: String
    
    init(name: String, phoneNumber: String, email: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init?(cloudKitRecord: CKRecord) {
     
        guard let name = cloudKitRecord[nameKey] as? String,
        let phoneNumber = cloudKitRecord[phoneNumberKey] as? String,
            let email = cloudKitRecord[emailKey] as? String else { return nil }
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: "Contacts")
        record.setValue(name, forKey: nameKey)
        record.setValue(phoneNumber, forKey: phoneNumberKey)
        record.setValue(email, forKey: emailKey)
        return record
    }
}
