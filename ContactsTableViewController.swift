//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Hayden Hastings on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contacts: [Contacts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ContactController.fetchContactsFromCloudKit { (contacts) in
            self.contacts = contacts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = "Number is: \(contact.phoneNumber), email is: \(contact.email)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toContactsInfoVC" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                let contactDetailVC = segue.destination as? ContactsInfoViewController else { return }
            let contacts = ContactController.shared.contact[indexPath.row]
            
            contactDetailVC.contacts = contacts
        }
        
    }
}
