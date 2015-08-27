//
//  MovieDetailViewController.swift
//  Rotten Tomatoes
//
//  Created by P5mini 2 on 8/27/15.
//  Copyright (c) 2015 Hien VH. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie["title"] as? String
        println("\(title)")
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["synopsis"] as? String
        let url = NSURL(string: movie.valueForKeyPath("posters.original") as! String)!
        imageView.setImageWithURL(url)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
