//
//  ViewController.swift
//  eventKitCal
//
//  Created by geetharani on 25/11/19.
//  Copyright © 2019 geetha. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class ViewController: UIViewController {
  let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(_ animated: Bool) {
        checkPermission()
        
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

}

/*
 in .plist file u need to add the following IMPORTANT
 1.click the + button on top and add Privacy - Calendars Usage Description  and then in same key add must require calendar access.
 2. 1.click the + button on top and add Privacy - Reminders Usage Description and then in same key add must require reminders access.
*/







