//
//  AddNotes.swift
//  NotesForYou
//
//  Created by Артём Устинов on 25.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData

class AddNotes {
    
    //let mainVC = MainTableViewController()

    weak var mainVC: MainTableViewController?
    
    
     public func setupAlert() {
            
            let alertController = UIAlertController(title: "New note", message: "Please add new note", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { action in
                let textField = alertController.textFields?.first
                if let newNote = textField?.text {

                    switch self.mainVC?.segmentedControl.selectedSegmentIndex {
                    case 0:
    //                    self.saveBook(withTitle: newNote)
                        self.saveBook(withTitle: newNote)
                        break
                    case 1:
    //                    self.saveFilm(withTitle: newNote)
                        self.saveFilm(withTitle: newNote)
                        break
                    case 2:
    //                    self.saveMusic(withTitle: newNote)
                        self.saveMusic(withTitle: newNote)
                        break
                    default:
                        break
                    }
                    self.mainVC?.tableView.reloadData()
                }
            }
            
            alertController.addTextField { (textField) in
                textField.autocapitalizationType = .sentences
                textField.returnKeyType = .done
                
                switch self.mainVC?.segmentedControl.selectedSegmentIndex {
                case 0:
                    textField.placeholder = "Book"
                    break
                case 1:
                    textField.placeholder = "Film"
                    break
                case 2:
                    textField.placeholder = "Music"
                    break
                default:
                    break
                }
                self.mainVC?.tableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
        mainVC?.present(alertController, animated: true)
        }
    
    
     func saveBook(withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Book", in: context) else { return }
        
        let noteObject = Book(entity: entity, insertInto: context)
        noteObject.title = title
        
        do {
            try context.save()
//            books.append(noteObject)
            mainVC?.profile.books.append(noteObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
     func saveFilm(withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Film", in: context) else { return }
        
        let noteObject = Film(entity: entity, insertInto: context)
        noteObject.title = title
        
        do {
            try context.save()
//            films.append(noteObject)
            mainVC?.profile.films.append(noteObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
     func saveMusic(withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Music", in: context) else { return }
        
        let noteObject = Music(entity: entity, insertInto: context)
        noteObject.title = title
        
        do {
            try context.save()
//            musics.append(noteObject)
            mainVC?.profile.musics.append(noteObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
     private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
