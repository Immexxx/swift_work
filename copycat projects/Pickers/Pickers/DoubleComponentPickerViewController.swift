//
//  DoubleComponentPickerViewController.swift
//  Pickers
//
//  Created by yeshaokai on 2/13/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var doublePicker: UIPickerView!
    private let fillingComponent = 0
    private let breadComponent = 1
    private let fillingTypes = ["Ham","Turkey","Peanut Butter","Tuna Salad","Chicken Salad", "Roast Beef","Vegemite"]
    private let breadTypes=["white","whole wheat","Rye","sourdough","seven grain"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let fillingRow = doublePicker.selectedRowInComponent(fillingComponent)
        let breadRow = doublePicker.selectedRowInComponent(breadComponent)
        let filling = fillingTypes[fillingRow]
        let bread = breadTypes[breadRow]
        let message = "Your \(filling) on \(bread) will be right up."
    }
    
    
    // MARK:- 
    // MARK: Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if component == breadComponent {
            return breadTypes.count
        }
        else {
            return fillingTypes.count
        }
        
    }
    // MARK:-
    // MARK: Picker Delegate Methods 
    func pickerView(pickerView:UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == breadComponent {
            return breadTypes[row]
        }else {
            return fillingTypes[row]
        }
    }
    

}
