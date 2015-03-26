//
//  ViewController.swift
//  LocalNotify
//
//  Created by yeshaokai on 3/8/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.sharedApplication()
        let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound, categories: nil)
        app.registerUserNotificationSettings(notificationSettings)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

