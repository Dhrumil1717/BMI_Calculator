//
//  ViewController2.swift
//  FinalExam
//
//  Created by Dhrumil Malaviya on 2020-12-10.
//  Copyright © 2020 Dhrumil Malaviya. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var tasks : [Task] = []
     let database = Database.database().reference().child("BMI")
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.rowHeight = 69.0
        
        database.observe(DataEventType.value, with: { (snapshot) in
        self.tasks.removeAll()
                for tasks in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let taskobject = tasks.value as? [String : AnyObject]
                    let taskName = taskobject?["BMI"]
                    let currentDate = taskobject?["Date"]
                    let id = taskobject?["id"]
                    
                    let taskss = Task(bmi: taskName as! Double, date: currentDate as!String, id: id as! String)
                    
                  self.tasks.append(taskss)
                   
                }
                self.tableView.reloadData()
          
        })
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  //returns the number of rows that are to be displayed
    {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TableViewCell
        
        cell.lblBMIValue.text = String(tasks[indexPath.row].bmi)
        cell.lblDate.text = tasks[indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete"){(action,view,nil) in
        self.deleteTask(id: self.tasks[indexPath.row].id)
        print("delete")}
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           self.tableView.allowsSelection = false
        
       }
    
    func deleteTask(id:String)
    {
        database.child(id).setValue(nil)
    }
}




class TableViewCell: UITableViewCell
{
    
    @IBOutlet weak var lblBMIValue: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
}

class Task {
    var bmi = 0.0
    var id = ""
    var date = ""
    
    convenience init(bmi:Double,date:String,id:String)
    {
        self.init()
        self.bmi = bmi
        self.date = date
        self.id = id
    }
}
