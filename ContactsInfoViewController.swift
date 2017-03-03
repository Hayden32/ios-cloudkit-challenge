//
//  ContactsInfoViewController.swift
//  Contacts
//
//  Created by Hayden Hastings on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactsInfoViewController: UIViewController {
    var contacts: Contacts?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text,
        let phoneNumber = phoneNumberTextField.text,
            let email = emailTextfield.text else { return }

        ContactController.sendContactsToCloudKit(name: name, phoneNumber: phoneNumber, email: email)
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
    }

}
