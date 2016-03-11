//
//  ViewController.swift
//  RottenTomatoesApp
//
//  Created by Tejal Par on 9/15/14.
//

import UIKit

protocol NewsSelectionDelegate {
    func setup(movieItem: MovieItem)
}

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

