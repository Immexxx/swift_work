//
//  ViewController.swift
//  AVPlayer
//
//  Created by yeshaokai on 3/9/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as AVPlayerViewController
        let url = NSURL(string:"http://.ebookfrenzy.com/ios_book/movie/movie.mov")
        destination.player = AVPlayer(URL:url)
    }

}

