//
//  MainViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 16.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK:- IBOutlets:
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - Private Properties:
    var books: [Book] = []
    var films: [Film] = []
    var musics: [Music] = []
    
    private let notifications = Notifications()
    private let startPresentation = StartPresentation()    
    
    //MARK:- Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        
        StorageManager.shared.fetchDataBook { (books, films, musics) in
            self.books = books ?? []
            self.films = films ?? []
            self.musics = musics ?? []
            tableView.reloadData()
        }
        
        notifications.scheduleNotification()
        startPresentation.mainVC = self
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notifications.scheduleNotification()
        startPresentation.startPresentation()
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
}

