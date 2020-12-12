//
//  StorageManager.swift
//  NotesForYou
//
//  Created by Артём Устинов on 07.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    //MARK: - Private properties:
    private var viewContext: NSManagedObjectContext
    private var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NotesForYou")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchDataBook(_ completion: ([Book]?, [Film]?, [Music]?) -> Void) {
        let fetchRequestBook: NSFetchRequest<Book> = Book.fetchRequest()
        let fetchRequestFilm: NSFetchRequest<Film> = Film.fetchRequest()
        let fetchRequestMusic: NSFetchRequest<Music> = Music.fetchRequest()
        
        do {
            let books = try viewContext.fetch(fetchRequestBook)
            let films = try viewContext.fetch(fetchRequestFilm)
            let musics = try viewContext.fetch(fetchRequestMusic)
            completion(books, films, musics)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
//    func saveTask(title: String, completion: (Book, Film, Music) -> Void) {
//
//        let book = Book(context: viewContext)
//        book.title = title
//
//        let film = Film(context: viewContext)
//        film.title = title
//
//        let music = Music(context: viewContext)
//        music.title = title
//        completion(book, film, music)
//        saveContext()
//    }
    
    func saveTask(title: String, completionBook: ((Book) -> Void)? = nil, completionFilm: ((Film) -> Void)? = nil, completionMusic: ((Music) -> Void)? = nil) {
        
        if completionBook != nil {
            let book = Book(context: viewContext)
            book.title = title
            completionBook?(book)
        } else if completionFilm != nil {
            let film = Film(context: viewContext)
            film.title = title
            completionFilm?(film)
        } else {
            let music = Music(context: viewContext)
            music.title = title
            completionMusic?(music)
        }
        saveContext()
    }
    
    func deleteBook(_ task: NSManagedObject) {
        if task is Book {
            viewContext.delete(task)
        } else if task is Film {
            viewContext.delete(task)
        } else {
            viewContext.delete(task)
        }
        saveContext()
    }
    
    func editTask(newTask: String, book: Book? = nil, film: Film? = nil, music: Music? = nil) {
        if book != nil {
            book?.title = newTask
        } else if film != nil {
            film?.title = newTask
        } else {
            music?.title = newTask
        }
        saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private init(){
        viewContext = persistentContainer.viewContext
    }
}
