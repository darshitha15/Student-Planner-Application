//
//  CoursesVC.swift
//  Project
//
//  Created by Peethambaram, Lavanya on 10/24/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit

class CoursesVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    
    @IBOutlet weak var listTbl: UITableView!
   var courses = ["Data structures","Networking","Parallel Programming", "Operating Systems", "Network Security", "Software Engineering","DBMS","App Development"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTbl.delegate = self
        listTbl.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
//        courses = UserDefaults.standard.array(forKey: "courseDetails") as! [String]
//        print(courses)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblID", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row]
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
