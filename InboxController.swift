//
//  TableViewController.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 12/10/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import UIKit
import Firebase

class InboxController: UITableViewController {
    var inboxMessages = [Inbox]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeInboxMessages()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func observeInboxMessages() {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        // going to create a reference note
        Api.Inbox.lastMessages(uid: currentUid) { (inbox) in
         //   let d = inbox as? Dictionary<String , AnyObject>
         //   let userInstance = User(uid: currentUid, dictionary:d! )
          if !self.inboxMessages.contains(where:{ $0.user.uid == inbox.user.uid }) {
                self.inboxMessages.append(inbox)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
          //      print(inbox.text)
         //       print(inbox.user)
       //         print(inbox)
      //          print(currentUid)
                
   }
        }
    }


    // MARK: - Table view data source
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return inboxMessages.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxCell", for: indexPath) as! InboxCell

        // Configure the cell...
        let inbox = self.inboxMessages[indexPath.row]
        print(inbox)
        
        
      //  cell.controller = self
        cell.controller = self
        cell.configureCell(uid:Api.User.currentUserId, inbox: inbox)
        print(inbox)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
