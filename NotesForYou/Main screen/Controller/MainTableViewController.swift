//
//  MainTableViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 16.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties:
    var profile = Profile(books: [Book](), films: [Film](), musics: [Music]())
    
    let notifications = Notifications()
    let addNotes = AddNotes()
    let startPresentation = StartPresentation()
    
    //MARK:- IBOutlets:
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.removeAllSegments()
            segmentedControl.insertSegment(withTitle: "Book", at: 0, animated: true)
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.insertSegment(withTitle: "Film", at: 1, animated: true)
            segmentedControl.insertSegment(withTitle: "Music", at: 2, animated: true)
        }
    }
    
    //MARK:- IBActions:
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        addNotes.setupAlert()
        tableView.reloadData()
    }
    
    @IBAction func scPressed(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    //MARK:- Override methods:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notifications.scheduleNotification()
        startPresentation.startPresentation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = getContext()
        let fetchRequestOfBook: NSFetchRequest<Book> = Book.fetchRequest()
        let fetchRequestOfFilm: NSFetchRequest<Film> = Film.fetchRequest()
        let fetchRequestOfMusic: NSFetchRequest<Music> = Music.fetchRequest()
        
        do {
            profile.books = try context.fetch(fetchRequestOfBook)
            profile.films = try context.fetch(fetchRequestOfFilm)
            profile.musics = try context.fetch(fetchRequestOfMusic)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifications.scheduleNotification()
        
        addNotes.mainVC = self
        startPresentation.mainVC = self
        
        tableView.tableFooterView = UIView()
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return profile.books.count
        case 1:
            return profile.films.count
        case 2:
            return profile.musics.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.textLabel?.text = profile.books[indexPath.row].title
        case 1:
            cell.textLabel?.text = profile.films[indexPath.row].title
        case 2:
            cell.textLabel?.text = profile.musics[indexPath.row].title
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = getContext()
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let book = profile.books[indexPath.row]
                profile.books.remove(at: indexPath.row)
                context.delete(book)
                try! context.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case 1:
                let book = profile.films[indexPath.row]
                profile.films.remove(at: indexPath.row)
                context.delete(book)
                try! context.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case 2:
                let book = profile.musics[indexPath.row]
                profile.musics.remove(at: indexPath.row)
                context.delete(book)
                try! context.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }    
}



