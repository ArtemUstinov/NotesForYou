//
//  MainTableViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 16.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController {
    
    //MARK:- IBOutlets:
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - Private Properties:
    private var books: [Book] = []
    private var films: [Film] = []
    private var musics: [Music] = []
    
    private let notifications = Notifications()
    private let startPresentation = StartPresentation()    
    
    //MARK:- Override methods:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notifications.scheduleNotification()
        startPresentation.startPresentation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        
        StorageManager.shared.fetchDataBook { (books, films, musics)  in
            self.books = books ?? []
            self.films = films ?? []
            self.musics = musics ?? []
            tableView.reloadData()
        }
        
        notifications.scheduleNotification()
        startPresentation.mainVC = self
        
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- IBActions:
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    @IBAction func scPressed(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Book", at: 0, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.insertSegment(withTitle: "Film", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Music", at: 2, animated: true)
    }
    
    private func showAlert() {
        
        let alert = AlertController(title: "New note", message: "Please add a new note", preferredStyle: .alert)
        
        alert.action { newNote in
            switch self.segmentedControl.selectedSegmentIndex {
            case 0:
                StorageManager.shared.saveTask(title: newNote, completionBook: { book in
                    print(book)
                    self.books.append(book)
                    self.tableView.insertRows(at: [IndexPath(row: self.books.count - 1, section: 0)], with: .automatic)
                })
            case 1:
                StorageManager.shared.saveTask(title: newNote, completionFilm: { film in
                    self.films.append(film)
                    self.tableView.insertRows(at: [IndexPath(row: self.films.count - 1, section: 0)], with: .automatic)
                })
            case 2:
                StorageManager.shared.saveTask(title: newNote, completionMusic: { music in
                    self.musics.append(music)
                    self.tableView.insertRows(at: [IndexPath(row: self.musics.count - 1, section: 0)], with: .automatic)
                })
            default:
                print("")
            }
        }
        present(alert, animated: true)
    }
}

extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return books.count
        case 1:
            return films.count
        case 2:
            return musics.count
        default:
            print("You have a new segment index")
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.textLabel?.text = books[indexPath.row].title
        case 1:
            cell.textLabel?.text = films[indexPath.row].title
        case 2:
            cell.textLabel?.text = musics[indexPath.row].title
        default:
            print("You have a new segment index")
        }
        return cell
    }
    
    //MARK: - Table view Delegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let book = books[indexPath.row]
                StorageManager.shared.deleteBook(book)
                books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case 1:
                let film = films[indexPath.row]
                StorageManager.shared.deleteBook(film)
                films.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case 2:
                let music = musics[indexPath.row]
                StorageManager.shared.deleteBook(music)
                musics.remove(at: indexPath.row)
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




