//
//  CoursesAddVC.swift
//  Project
//
//  Created by Peethambaram, Lavanya on 12/3/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit
import CoreData
class CoursesAddVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

//@IBOutlet weak var courseLbl: UILabel!
    @IBOutlet weak var txtCourse: UITextField!
    @IBOutlet weak var courseSch_picker: UIPickerView!
@IBOutlet weak var roomnum_txt: UITextField!

@IBOutlet weak var classType_Btn: UIButton!
@IBOutlet weak var course_Btn: UIButton!
@IBOutlet weak var InstructorName: UITextField!

var schdule_str = String()
var teacher = String()
var instructors_arr = [String]()
var classTypSel = ClassTypeSelVC()
var courseSel = CourseSelectionViewController()
var teachers = NSMutableArray();
var pickerArr = [String]()
var isKeyboardAppear = false
var classStr = String()
var courseStr = String()

override func viewDidLoad()
{
    super.viewDidLoad()
           
    txtCourse.delegate = self
    
     
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
  pickerArr = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    // Do any additional setup after loading the view.
}

override func viewWillAppear(_ animated: Bool)
{
    if (courseStr == "")
    {
        courseStr = "Select Course"
        
    }else
    {
        courseStr = UserDefaults.standard.string(forKey: "selectCourse")!
    }
    course_Btn.setTitle(courseStr, for: .normal)
    
   if (classStr == "")
    {
        classStr = "Class"
        
    }else
    {
        classStr = UserDefaults.standard.string(forKey: "classType")!
    }
    classType_Btn.setTitle(classStr, for:.normal)
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

@IBAction func selectCourse(_ sender: UIButton)
{
    courseSel = self.storyboard?.instantiateViewController(withIdentifier: "courseSelVC") as! CourseSelectionViewController
    self.navigationController?.pushViewController(courseSel, animated: true)
}

@IBAction func selectClassType(_ sender: UIButton)
{
    classTypSel = self.storyboard?.instantiateViewController(withIdentifier: "ClassTypeSelVC") as! ClassTypeSelVC
    self.navigationController?.pushViewController(classTypSel, animated: true)
}

@IBAction func saveClassData(_ sender: UIButton)
    {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Course is successfully added"
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
        teacher = InstructorName.text!
        if (courseStr == "Select Course")
        {
            let alertController = UIAlertController(title: "Select Course", message: "Select any course for your timetable", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                print("You've pressed cancel");
            }
            alertController.addAction(action1)
            alertController.addAction(action2)
    
            self.present(alertController, animated: true, completion: nil)

        }
        else
        {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext
           let entity = NSEntityDescription.entity(forEntityName: "TimeTable", in: context)
           let newUser = NSManagedObject(entity: entity!, insertInto: context)
          newUser.setValue(txtCourse.text, forKey: "Course")


           do {
              try context.save()
            print(context)
           let timeTbl = self.storyboard?.instantiateViewController(withIdentifier: "TimeTableVC") as! TimeTableVC
            self.navigationController?.pushViewController(timeTbl, animated: true)
             } catch {
              print("Failed saving")
           }
      }
    }
    
    //MARK - Picker Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerArr.count
    }
    
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        schdule_str = pickerArr[row]
        return  pickerArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
             schdule_str = pickerArr[row]
             print("****",schdule_str)
       }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 40
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
