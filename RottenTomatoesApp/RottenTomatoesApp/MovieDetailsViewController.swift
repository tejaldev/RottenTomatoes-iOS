//
//  MovieDetailsViewController.swift
//  RottenTomatoesApp
//
//  Created by Tejal Par on 9/17/14.
//

import UIKit

protocol MovieSelectionDelegate {
    func setup(movieItem: MovieItem)
}

class MovieDetailsViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.movieItem = MovieItem()
        self.movieItem.description = ""
        self.movieItem.title = ""
        self.movieItem.origimgURLString = ""
    }

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var movieDetailsUIView: UIView!
    
    @IBOutlet var titleNavigation: UINavigationItem!
    
    
    var movieItem: MovieItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleNavigation.title = movieItem.title
        movieImageView.setImageWithURL(NSURL(string: movieItem.origimgURLString! ))
        descriptionLabel.text = movieItem.description
        descriptionLabel.sizeToFit()
        movieDetailsUIView.addSubview(descriptionLabel)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(movieItem: MovieItem) {
        self.movieItem = movieItem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
