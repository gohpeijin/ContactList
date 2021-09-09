//
//  EditContactViewController.swift
//  ContactList
//
//  Created by gohpeijin on 08/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {
    
    var contact: Contact!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contact = contact {
            nameTextField.text =  contact.name
            phoneNumberTextField.text = contact.phoneNumber
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        //        performSegue(withIdentifier: "unwindAfterAdding", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
