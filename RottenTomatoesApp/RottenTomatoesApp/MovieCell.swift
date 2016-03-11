//
//  MovieCell.swift
//  RottenTomatoesApp
//
//  Created by Tejal Par on 9/15/14.
//

import UIKit

//import "UIImageView+AFNetworking.h"


class MovieCell: UITableViewCell {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieDescription: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup(movieItem: MovieItem) {
        movieTitle.text = movieItem.title
        movieDescription.text = movieItem.description
        //movieImageView.setImageWithURL(movieItem.imageURL)
    }

}
