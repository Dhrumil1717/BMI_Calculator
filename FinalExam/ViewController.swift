//
//  ViewController.swift
//  FinalExam
//
//  Created by Dhrumil Malaviya on 2020-12-09.
//  Copyright © 2020 Dhrumil Malaviya. All rights reserved.
//

import UIKit
import DropDown
import FirebaseDatabase
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
class ViewController: UIViewController
{
    let database = Database.database().reference().child("BMI")
   
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
   
    @IBOutlet weak var lblCalculateBMI: UILabel!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
   
    @IBOutlet weak var segmentHeight: UISegmentedControl!
    @IBOutlet weak var segmentWeight: UISegmentedControl!
    @IBOutlet weak var segmentGender: UISegmentedControl!
    
   
   
    @IBAction func segmentHeightChanged(_ sender: Any)
    {
        let heightInSegment = segmentHeight.titleForSegment(at: segmentHeight.selectedSegmentIndex)
                if heightInSegment == "Inches"
               {
                   segmentWeight.selectedSegmentIndex = 0
               }
               else if heightInSegment == "Meter"
                {
                   segmentWeight.selectedSegmentIndex = 1
               }
    }
    
    @IBAction func segmentWeightChanged(_ sender: Any)
       {
           let weightInSegment = segmentWeight.titleForSegment(at: segmentWeight.selectedSegmentIndex)
                   if weightInSegment == "Pound"
                  {
                      segmentHeight.selectedSegmentIndex = 0
                  }
                  else if weightInSegment == "Kilogram"
                   {
                      segmentHeight.selectedSegmentIndex = 1
                  }
           
       }
    
   
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background image")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)

      //  self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background image")!)
    }
    
    
    @IBAction func onCalculateBMIclicked(_ sender: Any)
    {
        let name = txtName.text
        _ = txtAge.text
        let weight = Double(txtWeight.text!)
        let height = Double(txtHeight.text!)
        
       let heightInSegment = segmentHeight.titleForSegment(at: segmentHeight.selectedSegmentIndex)
        let weightInSegment = segmentWeight.titleForSegment(at: segmentWeight.selectedSegmentIndex)
        
       if heightInSegment == "Meter" && weightInSegment == "Kilogram"
       {
        let BMI = (weight!/(height!*height!) )
       
       
        if BMI <= 16
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Severe Thinness"
        }
        else if BMI > 16 && BMI < 17
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Moderate Thinness"
        }
        else if BMI >= 17 && BMI < 18
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Mild Thinness"
        }
        else if BMI > 18 && BMI < 25
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Normal"
        }
        else if BMI > 25 && BMI < 30
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Overweight "
        }
        else if BMI > 30 && BMI < 35
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Obese Class 1"
        }
        else if BMI > 35 && BMI < 40
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Obese Class 2"
        }
        else if BMI > 40
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \((String(format: "%.2f", BMI))) and falls in the category Obese Class 3"
        }
        
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        view.endEditing(true)
        let currentDate = dateFormatter.string(from: Date())
        
        let key = database.childByAutoId().key
        let object :[String: Any] =  ["BMI":BMI,"id":key!,"Date":currentDate]
        database.child(key!).setValue(object)
        
    
        
        }
        
        else
       {
        let BMI = ((weight! * 703)/(height! * height!))
        
        if BMI <= 16
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Severe Thinness"
        }
        else if BMI > 16 && BMI < 17
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Moderate Thinness"
        }
        else if BMI >= 17 && BMI < 18
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Mild Thinness"
        }
        else if BMI > 18 && BMI < 25
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Normal"
        }
        else if BMI > 25 && BMI < 30
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Overweight "
        }
        else if BMI > 30 && BMI < 35
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Obese Class 1"
        }
        else if BMI > 35 && BMI < 40
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Obese Class 2"
        }
        else if BMI > 40
        {
            lblCalculateBMI.text = " \(name ?? "Alex")'s BMI is \(String(format: "%.2f", BMI)) and falls in the category Obese Class 3"
        }
        
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        view.endEditing(true)
        let currentDate = dateFormatter.string(from: Date())

        let key = database.childByAutoId().key
        let object :[String: Any] =  ["BMI":BMI,"id":key!,"Date":currentDate]
        database.child(key!).setValue(object)
        
       
        }
    }
    
}


