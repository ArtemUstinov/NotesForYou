//
//  AlertController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 12.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {
    
    func action(completion: @escaping (String) -> Void) {
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = self.textFields?.first?.text, !task.isEmpty else { return }
            completion(task)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addTextField { textField in
            textField.autocapitalizationType = .sentences
            textField.returnKeyType = .done
            textField.placeholder = "What do you want to write?"
        }
        
        addAction(saveAction)
        addAction(cancelAction)
    }
}
