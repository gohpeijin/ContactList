//
//  ContactListTableViewCell.swift
//  ContactList
//
//  Created by gohpeijin on 08/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {

    static let identifier = "ContactListTableViewCell" // for register the cell
    
    @IBOutlet weak var labelcontactName: UILabel!
    @IBOutlet weak var labelphoneNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func displayCell(_ name : String, _ phoneNumber : String){
        labelcontactName.text = name
        labelphoneNumber.text = phoneNumber
    }
    
    // for register the cell
    static func nib() -> UINib {
        return UINib(nibName: "ContactListTableViewCell", bundle: nil)
    }
}
