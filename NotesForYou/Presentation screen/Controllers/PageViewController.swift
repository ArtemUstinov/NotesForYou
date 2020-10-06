//
//  PageViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 27.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let presentScreenContent = [
        "Записать книгу, фильм или музыкальную композицию?\n\nNotesForYou поможет вам в этом!",
        "Просто заметки и ничего лишнего.",
        "Быстро добавить одним касанием.",
        "Локанично и минималистично."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let presentVC = showPresentVC(0) {
            setViewControllers([presentVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    func showPresentVC(_ index: Int) -> PresentationViewController? {
        
        guard index >= 0 else { return nil }
        guard index < presentScreenContent.count else {
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "firstPresentation6")
            dismiss(animated: true, completion: nil)
            
            return nil
        }
        guard let presentVC = storyboard?.instantiateViewController(
            identifier: "PresentationViewController") as? PresentationViewController else { return nil }
        
        presentVC.presentText = presentScreenContent[index]
        presentVC.currentPage = index
        presentVC.numberOfpages = presentScreenContent.count
        
        return presentVC
    }
}


extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! PresentationViewController).currentPage
        pageNumber -= 1
        
        return showPresentVC(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! PresentationViewController).currentPage
        pageNumber += 1
        
        return showPresentVC(pageNumber)
    }
}
