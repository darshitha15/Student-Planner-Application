//
//  TimeTableVC.swift
//  Project
//
//  Created by Peethambaram, Lavanya on 10/24/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI
import CoreData

class TimeTableVC: UIViewController,UITableViewDataSource,UITableViewDelegate
{
   @IBOutlet weak var timeTable: UITableView!
   @IBOutlet weak var empty_lLbl: UILabel!
    var allValues = [Any]()
    var courseArr = [String]()
    
  let eventStore = EKEventStore()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeTable")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            allValues = result
            print(allValues)
            for data in result as! [NSManagedObject]
            {
                courseArr.append(data.value(forKey: "course") as! String)
            }
        } catch {
            print("Failed")
        }
         if courseArr.count == 0
               {
                timeTable.isHidden = true
                empty_lLbl.text = "Timetable is not available"
               }
               else
               {
                  timeTable.isHidden = false
                   timeTable.reloadData()
               }
        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(_ animated: Bool)
    {
        //checkPermission()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    func open(scheme: String) {
      if let url = URL(string: scheme) {
        if #available(iOS 10, *) {
          UIApplication.shared.open(url, options: [:],
            completionHandler: {
              (success) in
               print("Open \(scheme): \(success)")
           })
        } else {
          let success = UIApplication.shared.openURL(url)
          print("Open \(scheme): \(success)")
        }
      }
    }
    func checkPermission()
    {
        switch EKEventStore.authorizationStatus(for: .event)
        {
        case .authorized:
            print("access to calendar")
           // loadData()
        case .notDetermined:
            print("get the access for calendar")
            eventStore.requestAccess(to: .event) { (isAllow, error) in
                if let error = error
                {
                    print(error.localizedDescription)
                }else if isAllow
                {
                    //self.loadData()
                }
            }
        case .restricted, .denied:
            print("0000")
        }
    }
    
  //below is for reminder
    @IBAction func btnAddEvent(_ sender: Any)
    {
        let evtStr : EKEventStore = EKEventStore()
        evtStr.requestAccess(to: .reminder) { (granted, error) in
            if(granted) && (error == nil)
            {
                let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
                reminder.title = "Must do this!"//here u can add textfield variable.
                reminder.priority = 2
                //  How to show completed
                //reminder.completionDate = Date()
                reminder.notes = "...this is a note"
                let alarmTime = Date().addingTimeInterval(1)
                let alarm = EKAlarm(absoluteDate: alarmTime)
                reminder.addAlarm(alarm)
                reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                do {
                  try self.eventStore.save(reminder, commit: true)
                } catch {
                  print("Cannot save")
                  return
            }
             print("reminder saved")
                self.loadData()
        }
      }
    }
    
    func loadData()
    {
        print("load calendar")
        open(scheme: "calshow://")
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return courseArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableID", for: indexPath)
        cell.textLabel?.text = courseArr[indexPath.row]
           return cell
    }
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var viewController = TimeTblFullDetailsVC()
        viewController = self.storyboard?.instantiateViewController(withIdentifier: "TimeTblFullDetails") as! TimeTblFullDetailsVC
         self.navigationController?.pushViewController(viewController, animated: true)
    }
}

/*
 in .plist file u need to add the following IMPORTANT
 1.click the + button on top and add Privacy - Calendars Usage Description  and then in same key add must require calendar access.
 2. 1.click the + button on top and add Privacy - Reminders Usage Description and then in same key add must require reminders access.
*/
