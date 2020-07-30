//
//  AssignmentVC.swift
//  Project
//
//  Created by Peethambaram, Lavanya on 10/24/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit
import CoreData

class AssignCell: UITableViewCell
{
    @IBOutlet weak var textInpt: UITextField!
    @IBOutlet weak var img_imp: UIImageView!
}


class AssignmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var lblAssignments: UILabel!
    @IBOutlet weak var segAssignments: UISegmentedControl!
    @IBOutlet weak var list_tbl: UITableView!
    @IBOutlet weak var addBtn : UIBarButtonItem!
    var dataArray  = [Any]()
    var dueDaysArr = [String]()
    var priorityArr = [NSNumber]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Duedate")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            dataArray = result
            print(dataArray.count)
            
            for data in result as! [NSManagedObject]
            {
               print("****%@",data.value(forKey: "dueDays") as! String)
               dueDaysArr.append(data.value(forKey: "dueDays") as! String)
                priorityArr.append(data.value(forKey: "isSelect") as! NSNumber)
                
                print(dueDaysArr.count)
                print(priorityArr)
            }
            
        } catch {
            print("Failed")
        }
        
        if dataArray.count == 0
        {
            list_tbl.isHidden = true
        }
        else
        {
            list_tbl.isHidden = false
            list_tbl.reloadData()

        }
    }
     
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        switch segAssignments.selectedSegmentIndex {
        case 0:
            if dueDaysArr.count == 0
            {
                lblAssignments.text = "No assignments due, tap '+' to add."
            }
            else
            {
                  list_tbl.reloadData()
            }
        
        case 2:
            if dueDaysArr.count == 0
            {
              lblAssignments.text = "No priorities set, tap '+' to add."
                
            }
            else
            {
                  list_tbl.reloadData()
            }
            
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if segAssignments.selectedSegmentIndex == 0
        {
            return dueDaysArr.count
        }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = AssignCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "assignID", for: indexPath) as! AssignCell
        cell.textLabel?.isEnabled = false
        if segAssignments.selectedSegmentIndex == 0
        {
            cell.textInpt.text = dueDaysArr[indexPath.row]
        }
        else
        {
            cell.textInpt.text = dueDaysArr[indexPath.row]
        }
        
         return cell
    }
        
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        UserDefaults.standard.set(indexPath.row, forKey: "selectedIndex")
        var viewController = Assign_AddBtnVC()
        viewController = self.storyboard?.instantiateViewController(withIdentifier: "Assign_AddBtnVC") as! Assign_AddBtnVC
         self.navigationController?.pushViewController(viewController, animated: true)
    }
}
