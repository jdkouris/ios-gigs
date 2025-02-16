//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by John Kouris on 9/9/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let gigController = GigController()
    let dateFormatter = DateFormatter()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        // transistion to login view if conditions require
//        if gigController.bearer == nil {
//            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
//        } else {
//            gigController.fetchAllGigs { (result) in
//                //            self.gigs = result
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if gigController.bearer == nil {
            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
        }
        
        gigController.fetchAllGigs { (result) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gigController.gigs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GigCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = gigController.gigs[indexPath.row].title
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: gigController.gigs[indexPath.row].dueDate)

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginViewModalSegue" {
            if let destinationVC = segue.destination as? LoginViewController {
                destinationVC.gigController = gigController
            }
        } else if segue.identifier == "ViewGigSegue" {
            if let destinationVC = segue.destination as? GigDetailViewController {
                destinationVC.gigController = gigController
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationVC.gig = gigController.gigs[indexPath.row]
                }
            }
        } else if segue.identifier == "AddGigSegue" {
            if let destinationVC = segue.destination as? GigDetailViewController {
                destinationVC.gigController = gigController
            }
        }
    }

}
