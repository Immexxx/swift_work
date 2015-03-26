//
//  SingleComponentPickerViewController.swift
//  Pickers
//
//  Created by yeshaokai on 2/13/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class SingleComponentPickerViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var singlePicker: UIPickerView!
    private let characterNames = ["Alex" ,"Yuhao","Jiaqi","Yunfei","Peter"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonPressed(sender: AnyObject) {
        let row = singlePicker.selectedRowInComponent(0)
        let selected = characterNames[row]
        let title = "You selected \(selected)!"
        let alert = UIAlertController(title: title,
            message: "Thank you for choosing" , preferredStyle: .Alert)
        let action = UIAlertAction( title: "You are welcome" , style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert,animated:true , completion : nil)
        
    }
    // MARK:-
    // MARK: Picker Data Source Methods 
    func numberOfComponentsInPickerView( pickerView: UIPickerView) -> Int {
    return 1
    }
    func  pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characterNames.count
    }
    // Mark: Picker Delegate Methods 
    func pickerView(pickerView: UIPickerView, titleForRow row : Int , forComponent component: Int) -> String! {
        return characterNames[row]
    }
}
