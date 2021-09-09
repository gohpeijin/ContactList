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
    
    @IBOutlet weak var singleScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var additionalNotesTextField: UITextField!
    
    let DEFAULTSTATE = 0, EMPTYSTRING = 1
    
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contact = contactedit {
            nameTextField.text =  contact.name
            phoneNumberTextField.text = contact.phoneNumber
            emailTextField.text =  contact.email
            occupationTextField.text =  contact.occupation
            addressTextField.text =  contact.address
            additionalNotesTextField.text =  contact.notes
            
        }
        fetch()
//        someUIchores()
//        assigntag()
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
            contactedit.email = emailTextField.text
            contactedit.occupation = occupationTextField.text
            contactedit.address = addressTextField.text
            contactedit.notes = additionalNotesTextField.text
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
