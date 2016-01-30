//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Zlatko Jankovic on 1/12/16.
//  Copyright © 2016 Zlatko Jankovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

