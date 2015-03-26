//
//  ThirdViewController.swift
//  StateApp
//
//  Created by yeshaokai on 3/8/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UIViewControllerRestoration {

    class func viewControllerWithRestorationIdentifierPath(identifierComponents: [AnyObject], coder: NSCoder) -> UIViewController? {
        let myViewController = ThirdViewController(nibName: "ThirdViewController", bundle: nil)
        return myViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restorationIdentifier = "thirdViewController"
        self.restorationClass = ThirdViewController.self
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
