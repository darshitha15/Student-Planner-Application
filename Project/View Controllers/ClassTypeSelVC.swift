//
//  ClassTypeSelVC.swift
//  Project
//
//  Created by geetharani on 08/12/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit

class TypeSelCell: UITableViewCell
{
    @IBOutlet weak var imgSel : UIImageView!
     @IBOutlet weak var type_lbl : UILabel!
}


class ClassTypeSelVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tbl_class : UITableView!
   
     var classType_Arr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_class.dataSource = self
        tbl_class.delegate = self

         classType_Arr = ["Class","Lab","Lecture","Practical","Seminar","Group Study"]
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        classType_Arr.count
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
           let cell = tableView.dequeueReusableCell(withIdentifier: "classTypeID", for: indexPath) as! TypeSelCell
        cell.type_lbl.text = classType_Arr[indexPath.row]
        cell.imgSel.isHidden = true
              
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
      {
         let cell = TypeSelCell()
        cell.imgSel?.isHidden = false
        var timeTableDetailsVC = TimeTableDetailsVC()
       UserDefaults.standard.set(classType_Arr[indexPath.row], forKey: "classType")
       UserDefaults.standard.set(indexPath.row, forKey: "classIndex")

        timeTableDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TimeTableDetailsVC") as! TimeTableDetailsVC
        timeTableDetailsVC.classStr = UserDefaults.standard.string(forKey: "classType")!
        timeTableDetailsVC.courseStr = UserDefaults.standard.string(forKey:"selectCourse")!
    self.navigationController?.pushViewController(timeTableDetailsVC, animated: true)
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
