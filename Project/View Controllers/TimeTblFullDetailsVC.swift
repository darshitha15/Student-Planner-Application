//
//  TimeTblFullDetailsVC.swift
//  Project
//
//  Created by geetharani on 09/12/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit
import CoreData

class TimeTblFullDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var details_tbl : UITableView?
    
   var courseArr = [String]()
    var values = [String]()
    var allValues = [Any]()
      var val1 = String()
      var val2 = String()
      var val3 = String()
      var val4 = String()
      var val5 = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action:#selector(back))
        self.navigationItem.leftBarButtonItem = newBackButton
        
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
                val1 = data.value(forKey:"course") as! String
                val2 = data.value(forKey: "classType") as! String
                val3 = data.value(forKey: "instructor") as! String
                val4 = data.value(forKey: "schedules") as! String
                val5 = data.value(forKey: "timings") as! String
                
                print(val1,val2,val3,val4,val5)

            }
            values = [val1,val2,val3,val4,val5]
//            for data in result as! [NSManagedObject]
//            {
//                print()
//                courseArr.append(data.value(forKey: "course") as! String)
//            }
            
        
        } catch {
            print("Failed")
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func back(sender: UIBarButtonItem)
    {
        [self.navigationController?.popViewController(animated: true)];
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       values.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
    cell.textLabel?.text = values[indexPath.row] as? String
       return cell
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
