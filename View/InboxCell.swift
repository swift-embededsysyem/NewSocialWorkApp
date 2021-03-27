//
//  InboxCell.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 12/10/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import UIKit
import Firebase

class InboxCell: UITableViewCell {
   
    
    @IBOutlet weak var inboxImage: UIImageView!
    @IBOutlet weak var inboxTextField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var user:User!
    var inbox: Inbox!
     var controller:InboxController!
    
    func configureCell(uid: String, inbox: Inbox) {
        self.user = inbox.user
        self.inbox = inbox
        self.inboxTextField.text = inbox.text
        guard let imageUrl = inbox.user.profileImageURL else { return }
        inboxImage.loadImagee(imageUrl)
        print(imageUrl)
        print(inbox)
       // inboxImage.(inbox.user.profileImageURL)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
