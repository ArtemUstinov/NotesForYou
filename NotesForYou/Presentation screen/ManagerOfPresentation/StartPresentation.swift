//
//  StartPresentation.swift
//  NotesForYou
//
//  Created by Артём Устинов on 27.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit


class StartPresentation {
    
    weak var mainVC: MainTableViewController?
    
    
    func startPresentation() {
        
        let userDefaults = UserDefaults.standard
        let presentationWasViewed = userDefaults.bool(forKey: "firstPresentation")
        
        if presentationWasViewed == false {
            if let pageVC = mainVC?.storyboard?.instantiateViewController(
                identifier: "PageViewController") as? PageViewController {
                
                mainVC?.present(pageVC, animated: true, completion: nil)
            }
        }
    }
}

