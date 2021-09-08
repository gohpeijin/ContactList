//
//  AddContactViewController.swift
//  ContactList
//
//  Created by gohpeijin on 07/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        performSegue(withIdentifier: "unwindAfterAdding", sender: self)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }


}
