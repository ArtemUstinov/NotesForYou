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
    
    weak var mainVC: MainTableViewController?
    
    public func setupAlert() {
        
        let alertController = UIAlertController(title: "New note",
                                                message: "Please add a new note",
                                                preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newNote = textField?.text {
                
                switch self.mainVC?.segmentedControl.selectedSegmentIndex {
                case 0:
                    self.saveBook(withTitle: newNote)
                    break
                case 1:
                    self.saveFilm(withTitle: newNote)
                    break
                case 2:
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
                textField.placeholder = "Enter the title of the book"
                break
            case 1:
                textField.placeholder = "Enter the title of the movie"
                break
            case 2:
                textField.placeholder = "Enter the name of the music"
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
    
    
    private func saveBook(withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Book",
                                                      in: context) else { return }
        
        let noteObject = Book(entity: entity, insertInto: context)
        noteObject.title = title
        
        do {
            try context.save()
            mainVC?.profile.books.append(noteObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func saveFilm(withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Film",
                                                      in: context) else { return }
        
        let noteObject = Film(entity: entity, insertInto: context)
        noteObject.title = title
        
        do {
            try context.save()
            mainVC?.profile.films.append(noteObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func saveMusic(withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Music",
                                                      in: context) else { return }
        
        let noteObject = Music(entity: entity, insertInto: context)
        noteObject.title = title
        
        do {
            try context.save()
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
