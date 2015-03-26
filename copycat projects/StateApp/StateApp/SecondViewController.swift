//
//  SecondViewController.swift
//  StateApp
//
//  Created by yeshaokai on 3/8/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var thirdViewController: UIViewController?
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        coder.encodeObject(myTextView.text?,forKey:"UnsavedText")
            super.encodeRestorableStateWithCoder(coder)
        
        
    }
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        myTextView.text = coder.decodeObjectForKey("UnsavedText") as String
        super.decodeRestorableStateWithCoder(coder)
    }
    
    @IBOutlet weak var myTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        thirdViewController = ThirdViewController(nibName: "ThirdViewController",bundle:nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func displayVC3(sender: AnyObject) {
        self.navigationController?.pushViewController(thirdViewController!, animated: true)
    }
    

}

