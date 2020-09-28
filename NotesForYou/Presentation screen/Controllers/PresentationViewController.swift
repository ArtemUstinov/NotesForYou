//
//  PresentationViewController.swift
//  NotesForYou
//
//  Created by Артём Устинов on 27.09.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController {
    
    var presentText = ""
    var currentPage = 0
    var numberOfpages = 0
    
    
    //MARK:- IBOutlets:
    
    @IBOutlet weak var presentTextLabel: UILabel! {
        didSet {
            presentTextLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTextLabel.text = presentText
        pageControl.numberOfPages = numberOfpages
        pageControl.currentPage = currentPage
    }
}
