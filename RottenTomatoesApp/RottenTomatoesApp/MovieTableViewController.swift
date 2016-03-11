//
//  MovieTableViewController.swift
//  RottenTomatoesApp
//
//  Created by Tejal Par on 9/15/14.
//

import UIKit

class MovieTableViewController: UITableViewController { // , UITableViewDataSource, UITableViewDelegate {
    
    var movieDelegate: MovieSelectionDelegate?
    var movieItems: Array<MovieItem>?
    var movies: [NSDictionary] = []
    
    @IBOutlet var errorLabel: UILabel!
    //@IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let pullToRefreshControl = UIRefreshControl()
        pullToRefreshControl.addTarget(self, action: "loadMovies:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = pullToRefreshControl
        
        self.loadMovies()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return movies.count
        //return movieItems == nil ? 0 : movieItems!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        // Access using Arraylist
        //let movieItem = self.movieItems![indexPath.row] as MovieItem?
        //cell.setup(movieItem!)
        
        var movie = movies[indexPath.row]
        cell.movieTitle.text = movie["title"] as? String
        cell.movieDescription.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as! NSDictionary
        var imgurl = posters["thumbnail"] as! String
        self.getImage(imgurl, cell: cell)
        
        return cell
        
    }
    
    
    func getImage (imgurl: String, cell: MovieCell) -> Void{
        cell.movieImageView.setImageWithURL(NSURL(string: imgurl))
        UIView.transitionWithView(cell.movieImageView, duration: 0.9, options:UIViewAnimationOptions.CurveEaseOut , animations:{cell.movieImageView.alpha = 1}, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let indexPath = tableView.indexPathForSelectedRow
        var movie = movies[indexPath!.row]
        var posters = movie["posters"] as! NSDictionary
        var desc = movie["synopsis"] as? String
        var imgurl = posters["original"] as! String
        var movieName = movie["title"] as? String
        if(segue.identifier == "movieDetailsSegue"){
            
            let vc = segue.destinationViewController as! MovieDetailsViewController
            vc.movieItem.origimgURLString  = imgurl
            vc.movieItem.description = desc!
            vc.movieItem.title = movieName!
            
        }
        
//        let selectedRow = self.tableView.indexPathForSelectedRow()
//        
//        let movieView = segue.destinationViewController as MovieDetailsViewController
//        let movieItem = self.movieItems![selectedRow!.row] as MovieItem?
//        movieView.setup(movieItem!)
    }

    func loadMovies(){
        var url1 = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
        
        var url2 = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=j8zr4sdft6ns2eang8abd7ee&limit=20&country=us"
        
        let url = NSURL(string: url2)
        let request = NSURLRequest(URL: url!)
        
        
        
        //NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
       
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
            print("error: \(error)")
            if(error != nil){
                self.errorLabel.text = "Network Error"
                self.errorLabel.hidden = false
            }
            else{
                self.errorLabel.text = ""
                self.errorLabel.hidden = true
                
                let object = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
                self.movies = object["movies"] as! [NSDictionary]
                self.tableView.reloadData()
            }
        }
        
        self.refreshControl?.endRefreshing()
        
// RND: This method works too. Just defaulting to above approach
        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
//            println(error)
//            
//            var movieItems = Array<MovieItem>()
//            
//            let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
//            
//            let rootObject = jsonObject["movies"];
//            
//            if let statusesArray = rootObject as? NSArray{
//                
//                for item: AnyObject in statusesArray {
//                    var dict: Dictionary<String, String> = [:]
//                    
//                    //let title = item["title"]
//                    var titleString: String? = item["title"] as AnyObject? as? String
//                    dict["title"] = titleString
//                    
//                    //let description = item["synopsis"]
//                    var descString: String? = item["synopsis"] as AnyObject? as? String
//                    dict["description"] = descString
//                    
//                    var postersObject: NSObject? = item["posters"] as AnyObject? as? NSObject
//                    
//                    if let postersDict = item["posters"] as? NSDictionary{
//                        var thumbnailString: String? = postersDict.objectForKey("thumbnail") as AnyObject? as? String
//                        dict["thumbnail"] = thumbnailString
//                        //println("thumbnail: \(thumbnailString)")
//                    }
//                    
//                    movieItems.append(MovieItem(json: dict))
//                }
//                
//                self.movieItems = movieItems
//                self.tableView.reloadData()
//            }
//        }

    }
    
    
    //    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    //        if UIDevice.currentDevice().userInterfaceIdiom == .Pad && movieDelegate != nil {
    //            let selectedRow = self.tableView.indexPathForSelectedRow()
    //
    //            let movieItem = self.movieItems![selectedRow!.row] as MovieItem?
    //            movieDelegate!.setup(movieItem!)
    //        }
    //    }

}
