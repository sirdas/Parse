//
//  ChatViewController.swift
//  Phat
//
//  Created by Reis Sirdas on 3/22/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var messages: [PFObject]?
    
    // construct PFQuery
    var query : PFQuery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 120
        
        query = PFQuery(className: "Message")
        query!.orderByDescending("createdAt")
        query!.includeKey("sender")
        query!.limit = 20
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer() {
        // fetch data asynchronously
        query!.findObjectsInBackgroundWithBlock { (messages: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.messages = messages! as [PFObject]
                self.tableView.reloadData()
                
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }
        // Add code to be run periodically
    }
    
    @IBAction func onSend(sender: AnyObject) {
        if textField.text != nil {
            Message.sendMessage(textField.text, withCompletion: nil)
            textField.text = nil
            //sleep(2)
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil {
            return messages!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! TextCell
        cell.message = messages![indexPath.row] as PFObject
        
        return cell
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
