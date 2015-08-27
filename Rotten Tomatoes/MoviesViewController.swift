//
//  MoviesViewController.swift
//  Rotten Tomatoes
//
//  Created by P5mini 2 on 8/27/15.
//  Copyright (c) 2015 Hien VH. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var refreshControl: UIRefreshControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us")!
        
            let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (reponse: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json{
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
                println(json)
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let  movies = movies {3
            return movies.count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell

        let movie = movies![indexPath.row]
        
        cell.titleLabel?.text = movie["title"] as? String
        cell.synopsisLabel?.text = movie["synopsis"] as? String
        
        let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
        cell.posterView.setImageWithURL(url)
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        let movie = movies![indexPath.row]
        let movieDetailViewController = segue.destinationViewController as! MovieDetailViewController
        
        movieDetailViewController.movie = movie
    }
    func delay(delay:Double, closure:()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)) ),dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {self.refreshControl.endRefreshing()})
        println("on refresh")
    }
}



















