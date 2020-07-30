//
//  TasksVC.swift
//  Project
//
//  Created by Peethambaram, Lavanya on 10/24/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit

class TasksVC: UIViewController {

    @IBOutlet weak var segCtrlTasks: UISegmentedControl!
    @IBOutlet weak var lblTasks: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segCtrlSelect(_ sender: Any) {
        
        switch segCtrlTasks.selectedSegmentIndex {
        case 0:
            lblTasks.text = "No overdues, tap '+' to add."
        case 1:
            lblTasks.text = "No important tasks assigned, tap '+' to add."
        case 2:
            lblTasks.text = "No projects added, tap '+' to add"
        case 3:
            lblTasks.text = "No files to be uploaded.. "
        default:
            break
        }
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
