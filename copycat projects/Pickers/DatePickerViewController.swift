//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by yeshaokai on 2/13/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        datePicker.setDate(date, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let date = datePicker.date
        let message = " the date and time you selected is \(date)"
        let alert = UIAlertController ( title: "Date and Time selected" ,
            message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title : " That is so true!", style: .Default , handler: nil)
        alert.addAction(action)
        presentViewController(alert,animated: true , completion : nil)
    }


}
