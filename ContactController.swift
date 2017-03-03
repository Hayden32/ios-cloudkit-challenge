//
//  ContactController.swift
//  Contacts
//
//  Created by Hayden Hastings on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    var contact: [Contacts] = []
    static let shared = ContactController()
    
    static let publicDataBase = CKContainer.default().publicCloudDatabase
    
    static func sendContactsToCloudKit(name: String, phoneNumber: String, email: String) {
        
        let contacts = Contacts(name: name, phoneNumber: phoneNumber, email: email)
        let contactRecord = contacts.cloudKitRecord
        publicDataBase.save(contactRecord) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func fetchContactsFromCloudKit(completion: @escaping ([Contacts]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Contacts" , predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else { return }
            
            let contacts = records.flatMap({ Contacts(cloudKitRecord: $0)} )
            completion(contacts)
        }
    }
}
