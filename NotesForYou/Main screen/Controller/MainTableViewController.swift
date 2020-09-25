//
//  MainTableViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 16.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    
    var books = [Book]()
    var films = [Film]()
    var musics = [Music]()
    
    let addNotes = UIApplication.shared.delegate as? AddNotes
    let addNote = AddNotes()
    
    
    //MARK:- IBOutlet:
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    //MARK:- IBActions:
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        
//        if let setupAlert = addNotes?.setupAlert() {
//            return setupAlert
//        } else {
//            return print("error")
//        }
        addNote.setupAlert()
        
    }
    
    @IBAction func scPressed(_ sender: UISegmentedControl) {
        
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = getContext()
        let fetchRequestOfBook: NSFetchRequest<Book> = Book.fetchRequest()
        let fetchRequestOfFilm: NSFetchRequest<Film> = Film.fetchRequest()
        let fetchRequestOfMusic: NSFetchRequest<Music> = Music.fetchRequest()
        
        do {
            books = try context.fetch(fetchRequestOfBook)
            films = try context.fetch(fetchRequestOfFilm)
            musics = try context.fetch(fetchRequestOfMusic)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        setupSC()

    }
    
    
//    private func setupAlert() {
//        
//        let alertController = UIAlertController(title: "New note", message: "Please add new note", preferredStyle: .alert)
//        
//        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
//            let textField = alertController.textFields?.first
//            if let newNote = textField?.text {
//                
//                switch self.segmentedControl.selectedSegmentIndex {
//                case 0:
////                    self.saveBook(withTitle: newNote)
//                    self.addNotes?.saveBook(withTitle: newNote)
//                    break
//                case 1:
////                    self.saveFilm(withTitle: newNote)
//                    self.addNotes?.saveFilm(withTitle: newNote)
//                    break
//                case 2:
////                    self.saveMusic(withTitle: newNote)
//                    self.addNotes?.saveMusic(withTitle: newNote)
//                    break
//                default:
//                    break
//                }
//                self.tableView.reloadData()
//            }
//        }
//        
//        alertController.addTextField { (textField) in
//            textField.autocapitalizationType = .sentences
//            textField.returnKeyType = .done
//            
//            switch self.segmentedControl.selectedSegmentIndex {
//            case 0:
//                textField.placeholder = "Book"
//                break
//            case 1:
//                textField.placeholder = "Film"
//                break
//            case 2:
//                textField.placeholder = "Music"
//                break
//            default:
//                break
//            }
//            self.tableView.reloadData()
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
//        
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//        
//        present(alertController, animated: true)
//    }
//    
    private func setupSC() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Book", at: 0, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.insertSegment(withTitle: "Film", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Music", at: 2, animated: true)
    }
//    
//    private func saveBook(withTitle title: String) {
//        let context = getContext()
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "Book", in: context) else { return }
//        
//        let noteObject = Book(entity: entity, insertInto: context)
//        noteObject.title = title
//        
//        do {
//            try context.save()
//            books.append(noteObject)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
//    private func saveFilm(withTitle title: String) {
//        let context = getContext()
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "Film", in: context) else { return }
//        
//        let noteObject = Film(entity: entity, insertInto: context)
//        noteObject.title = title
//        
//        do {
//            try context.save()
//            films.append(noteObject)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
//    private func saveMusic(withTitle title: String) {
//        let context = getContext()
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "Music", in: context) else { return }
//        
//        let noteObject = Music(entity: entity, insertInto: context)
//        noteObject.title = title
//        
//        do {
//            try context.save()
//            musics.append(noteObject)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return books.count
        case 1:
            return films.count
        case 2:
            return musics.count
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //        let noteForBook = books[indexPath.row]
        //        let noteForFilm = films[indexPath.row]
        //        let noteForMusic = musics[indexPath.row]
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.textLabel?.text = books[indexPath.row].title
        case 1:
            cell.textLabel?.text = films[indexPath.row].title
        case 2:
            cell.textLabel?.text = musics[indexPath.row].title
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = getContext()
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let book = books[indexPath.row]
                books.remove(at: indexPath.row)
                context.delete(book)
                try! context.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case 1:
                let book = films[indexPath.row]
                films.remove(at: indexPath.row)
                context.delete(book)
                try! context.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case 2:
                let book = musics[indexPath.row]
                musics.remove(at: indexPath.row)
                context.delete(book)
                try! context.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            default:
                break
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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


