//
//  ChatTableViewCell.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 2/16/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    var message: Message!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var bubbleChatView: UIView!
    
    @IBOutlet weak var textMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleChatView.layer.cornerRadius = 15
        bubbleChatView.clipsToBounds = true
        bubbleChatView.layer.borderWidth = 0.4
        textMessageLabel.numberOfLines = 0
        textMessageLabel.isHidden = true
        
        
        
        
    }
    override func prepareForReuse() {
          super.prepareForReuse()
       
          textMessageLabel.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(uid: String, message: Message) {
        self.message = message
        let text = message.text
        if !text.isEmpty {
           textMessageLabel.isHidden = false
            textMessageLabel.text = message.text
            
        }
       
        }
    }

