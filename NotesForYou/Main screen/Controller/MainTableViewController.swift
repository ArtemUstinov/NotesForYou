//
//  MainTableViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 16.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var tasks = [String]()
    
    //MARK:- IBOutlet:
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    //MARK:- IBActions:
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New note", message: "Please add new note", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields![0]
            let textField2 = alertController.textFields![1]
            if let newNote = textField.text, let newNote2 = textField2.text {
                self.tasks.append(newNote)
                self.tasks.append(newNote2)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Book, movie, music"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func scPressed(_ sender: UISegmentedControl) {
        
    }
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSC()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func setupSC() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Book", at: 0, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.insertSegment(withTitle: "Book", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Music", at: 2, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row]

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
