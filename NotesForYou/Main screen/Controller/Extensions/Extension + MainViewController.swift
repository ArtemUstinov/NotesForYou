//
//  Extansion + MainViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 12.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func showAlert(book: Book? = nil,
                           film: Film? = nil,
                           music: Music? = nil, completion: (() -> Void)? = nil) {
        
        let alert = AlertController(title: "New note",
                                    message: "Please add a new note",
                                    preferredStyle: .alert)
        
        alert.action(book: book, film: film, music: music) { newNote in
            if let completion = completion {
                StorageManager.shared.editTask(newTask: newNote, book: book,
                                               film: film, music: music)
                completion()
            } else {
                switch self.segmentedControl.selectedSegmentIndex {
                case 0:
                    StorageManager.shared.saveTask(
                        title: newNote,
                        completionBook: { book in
                            print(book)
                            self.books.append(book)
                            self.tableView.insertRows(
                                at: [IndexPath(row: self.books.count - 1, section: 0)],
                                with: .automatic)
                    })
                case 1:
                    StorageManager.shared.saveTask(
                        title: newNote,
                        completionFilm: { film in
                            self.films.append(film)
                            self.tableView.insertRows(
                                at: [IndexPath(row: self.films.count - 1, section: 0)],
                                with: .automatic)
                    })
                case 2:
                    StorageManager.shared.saveTask(
                        title: newNote,
                        completionMusic: { music in
                            self.musics.append(music)
                            self.tableView.insertRows(
                                at: [IndexPath(row: self.musics.count - 1, section: 0)],
                                with: .automatic)
                    })
                default:
                    print("You have a new case in AlertController")
                }
            }
        }
        present(alert, animated: true)
    }
    
    // MARK: Table view data source
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
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
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            
            let deleteAction = UIContextualAction(
                style: .destructive,
                title: "Delete") { (_, _, _) in
                    switch self.segmentedControl.selectedSegmentIndex {
                    case 0:
                        let book = self.books[indexPath.row]
                        StorageManager.shared.deleteBook(book)
                        self.books.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    case 1:
                        let film = self.films[indexPath.row]
                        StorageManager.shared.deleteBook(film)
                        self.films.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    case 2:
                        let music = self.musics[indexPath.row]
                        StorageManager.shared.deleteBook(music)
                        self.musics.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    default:
                        break
                    }
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            
            let editAction = UIContextualAction(
                style: .normal,
                title: "Edit") { (_, _, isDone) in
                    switch self.segmentedControl.selectedSegmentIndex {
                    case 0:
                        self.showAlert(book: self.books[indexPath.row]) {
                            self.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    case 1:
                        self.showAlert(film: self.films[indexPath.row]) {
                            self.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    case 2:
                        self.showAlert(music: self.musics[indexPath.row]) {
                            self.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                        print("")
                    default:
                        break
                    }
                    isDone(true)
            }
            editAction.backgroundColor = .orange
            
            return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
