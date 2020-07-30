//
//  CourseSelectionViewController.swift
//  Project
//
//  Created by geetharani on 08/12/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit

class CourseSelectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var courseTable : UITableView!
    @IBOutlet weak var noCourselbl : UILabel!
    
    var courseArr = ["Data structures","Networking","Parallel Programming", "Operating Systems", "Network Security", "Software Engineering","DBMS","App Development"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //courseArr = UserDefaults.standard.array(forKey: "courseDetails") as! [String]
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
//        if (UserDefaults.standard.array(forKey: "courseDetails") as? [String] == nil)
//        {
//            noCourselbl.isHidden = false
//            courseTable.isHidden = true
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return courseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseSelID", for: indexPath)
        cell.textLabel?.text = courseArr[indexPath.row]
        
         return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var viewController = TimeTableDetailsVC()
        var viewController1 = Assign_AddBtnVC()
        
     UserDefaults.standard.set(courseArr[indexPath.row], forKey: "selectCourse")
        viewController = self.storyboard?.instantiateViewController(withIdentifier: "TimeTableDetailsVC") as! TimeTableDetailsVC
        viewController.courseStr = UserDefaults.standard.string(forKey:"selectCourse")!
        viewController1 = self.storyboard?.instantiateViewController(withIdentifier: "Assign_AddBtnVC") as! Assign_AddBtnVC
        viewController1.course_str = UserDefaults.standard.string(forKey:"selectCourse")!
         self.navigationController?.pushViewController(viewController, animated: true)
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
