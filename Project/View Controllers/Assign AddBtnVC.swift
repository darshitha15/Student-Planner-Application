//
//  Assign AddBtnVC.swift
//  Project
//
//  Created by Peethambaram, Lavanya on 12/1/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit
import CoreData


class Assign_AddBtnVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
   
    @IBOutlet weak var title_txt: UITextField!
    @IBOutlet weak var contents_Picker: UIPickerView!
    @IBOutlet weak var impSwitch : UISwitch!
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var timePicker : UIDatePicker!
    @IBOutlet weak var courseBtn : UIButton!


    var pickval :String = ""
    var assignVC : AssignmentVC!
    var isSelected : NSNumber!
    var time_str :Date!
    var date_str :String!
    var picker_str :String!
    var course_str :String!
    var selPicker_str :String!
    var pickerArray = [String]()
    var isKeyboardAppear = false

    override func viewDidLoad()
       {
           super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

           pickerArray =  ["Due in 1 day","Due in 3 days","Due in 7 days"]
        title_txt.delegate = self
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
             

           // Do any additional setup after loading the view.
       }
    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        isKeyboardAppear = true
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        isKeyboardAppear = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        isKeyboardAppear = false
        return true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    @IBAction func selectCourse(_ sender: UIButton)
        
    {
        var viewController = CourseSelectionViewController()
        viewController = self.storyboard?.instantiateViewController(withIdentifier: "courseSelVC") as! CourseSelectionViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func date_valuePicked(_ sender: UIDatePicker)
    {
        let components = Calendar.current.dateComponents([.day,.month,.year], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year
        {
            print("\(day)/\(month)/\(year)")
            date_str = "\(day)/\(month)/\(year)"
        }
        
    }
    
    @IBAction func time_valuePicked(_ sender: UIDatePicker)
    {
        let components = Calendar.current.dateComponents([.hour,.minute,.second], from: sender.date)
        if let hour = components.hour, let mins = components.minute, let secs = components.second
        {
            print("\(hour):\(mins):\(secs)")
            let timeVal = "\(hour):\(mins):\(secs)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"
            let ouptputTime = dateFormatter.date(from: timeVal)
            time_str = timeVal as? Date
            print(time_str)
        }
    }
    
   
    @IBAction func saveData(_ sender: UIButton)
    {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Assignment is added and \(pickval)"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 6
        dateComponents.minute = 16
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        if date_str == nil
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let ouptputTime = dateFormatter.string(from: datePicker.date)
            date_str = "\(ouptputTime)"
        }
        
        if time_str == nil
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"
            let ouptputTime = dateFormatter.string(from: timePicker.date)
            time_str = dateFormatter.date(from:ouptputTime)
       
        }
        
        if(isSelected == nil)
        {
            isSelected = 0
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Duedate", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(title_txt.text, forKey: "title")
        newUser.setValue(timePicker.date, forKey: "time")
        newUser.setValue(date_str, forKey: "date")
        newUser.setValue(isSelected, forKey:"isSelect")
        newUser.setValue(picker_str, forKey:"dueDays")
     
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
        var viewController = AssignmentVC()
        viewController = self.storyboard?.instantiateViewController(withIdentifier: "AssignmentVC") as! AssignmentVC
         self.navigationController?.pushViewController(viewController, animated: true)

    }
    
    @IBAction func switchSelected(_ sender: UISwitch)
    {
        if impSwitch .isOn
        {
            isSelected = 1
        }
        else
        {
           isSelected = 0
        }
    }
    
    // MARK : - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
           return 1
    }
       
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
       {
           return 3
       }
    
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
   {
    pickval = pickerArray[row] as String
       picker_str = pickerArray[row] as String
      return  pickval
   }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
          picker_str = pickerArray[row] as String
    }
       
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
