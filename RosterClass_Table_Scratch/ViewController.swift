//
//  ViewController.swift
//  RosterClass_Table_Scratch
//
//  Created by Mick Soumphonphakdy on 6/30/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//  Built from scratch

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var students = [Person]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let mick = Person(first: "Mick", last: "Soum")
        //let thatDude = Person(first: "Who", last: "Is He?")
        //let studentOne = Person(first: "John", last: "Doe")
        
        //self.students.append(mick)
        //self.students.append(thatDude)
        //self.students.append(studentOne)
        
        if let peepsFromArchive = self.loadArchive() {
            self.students = peepsFromArchive
        } else {
            self.loadPeepsFromPlist()
            self.saveToArchive()
        }
        //self.loadPeepsFromPlist()
    
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.saveToArchive()
        self.tableView.reloadData()
    }
    
// Gettig data from Peeps.plist
    
    private func loadPeepsFromPlist(){
        
        //get the path via NSBundle
        //get the array object
        //parse through each object and append to your students object
        
        if let peepsPath = NSBundle.mainBundle().pathForResource("Peeps", ofType: "plist"),
            peepsObjects = NSArray(contentsOfFile: peepsPath) as?[[String:String]]{
                
                for objects in peepsObjects{
                    if let firstName = objects["firstName"], lastName = objects["lastName"]{
                        let peep = Person(first:firstName, last:lastName)
                        self.students.append(peep)
                    }
                }
        }
    }

//::::tableViewDelegate Methods:::
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        //customize image size and radius
        cell.backgroundColor = UIColor.whiteColor()
        cell.customImageView.layer.cornerRadius = 20
        cell.customImageView.layer.masksToBounds = true;
        cell.customImageView.layer.borderWidth = 1
        cell.customImageView.layer.borderColor = UIColor.blackColor().CGColor
        
        let studentsToDisplay = self.students[indexPath.row]
        
        // cell.first.text = studentsToDisplay.firstName + " " + studentsToDisplay.lastName
        
        cell.customImageView.image = UIImage(named: "seattle_night.jpg")
        
        
        if let image = studentsToDisplay.image{
            cell.customImageView.image = image
        }
        
        cell.firstNamelabel.text = studentsToDisplay.firstName
        cell.lastNameLabel.text = studentsToDisplay.lastName
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let lastSelectedName = userDefaults.objectForKey("LastSelected") as? String where lastSelectedName == studentsToDisplay.firstName  {
            
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
        
        return cell

    }
    
    
    // Send the selectedStudent object of type Person class to Detailed View Controller
    // The selectedStudent object is pass by reference
    // UITextField.text in DetailViewController can assign value to selectedStudents Property
    // The value can be passed back to the tableViewController
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //check segue identifier
        if segue.identifier == "showDetail"{
            
            let detailViewController = segue.destinationViewController as! DetailViewController
            
            //get indexPath of selectedRow
            let indexPath = self.tableView.indexPathForSelectedRow();
            let selectedStudent = self.students[indexPath!.row]
            
            detailViewController.selectedPerson = selectedStudent
            
        }
        
    }
    
    
    // Archiving and UnArchiving to disk
    
    func saveToArchive(){
        
        //get the path to archive
        if let archivePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as? String{
            //save to disk
            NSKeyedArchiver.archiveRootObject(self.students, toFile:archivePath + "/archived")
        }
    }
    
    
    // Unarchving
    func loadArchive() -> [Person]?{
        if let archivePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as? String {
            
            if let peepload = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath + "/archived") as? [Person] {
                return peepload
            }
            
        }
        
      return nil
    }
    
  
    
    
    

    


}

