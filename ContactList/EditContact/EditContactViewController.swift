//
//  EditContactViewController.swift
//  ContactList
//
//  Created by gohpeijin on 08/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit
import CoreData

class EditContactViewController: UIViewController {
    var contactedit: Contact!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contact = contactedit {
            nameTextField.text =  contact.name
            phoneNumberTextField.text = contact.phoneNumber
        }
        fetch()
    }
    
    func fetch(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Status: Error in app")
            return
        }
        appDelegate = delegate
        managedContext = appDelegate.persistentContainer.viewContext
    }

    func edit(){
        do{
            contactedit.name = nameTextField.text
            contactedit.phoneNumber = phoneNumberTextField.text
            try managedContext.save()
        }catch let error as NSError{
            print("Status: Error when updating the data")
            print(error)
        }
    }
    
    @IBAction func saveEditPressed(_ sender: UIButton) {
        edit()
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
