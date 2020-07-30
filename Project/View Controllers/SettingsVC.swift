//
//  SettingsVC.swift
//  Project
//
//  Created by Peethambaram, Lavanya on 10/24/19.
//  Copyright © 2019 Peethambaram, Lavanya. All rights reserved.
//

import UIKit
import NotificationCenter
import UserNotificationsUI
import Foundation

class SettingsVC: UIViewController {
    var DarkisOn = Bool()
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
       
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .dark
            } else {
                overrideUserInterfaceStyle = .light

            }
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)

        // Do any additional setup after loading the view.
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    @objc private func darkModeEnabled(_ notification: Notification) {
        // Write your dark mode code here
    }

    @objc private func darkModeDisabled(_ notification: Notification) {
        // Write your non-dark mode code here
    }
    
    @IBAction func darkModeSwitched(_ sender: Any)
    {
        if darkModeSwitch.isOn == true {
                userDefaults.set(true, forKey: "darkModeEnabled")

                // Post the notification to let all current view controllers that the app has changed to dark mode, and they should theme themselves to reflect this change.
                NotificationCenter.default.post(name: .darkModeEnabled, object: nil)

            } else {

                userDefaults.set(false, forKey: "darkModeEnabled")

                // Post the notification to let all current view controllers that the app has changed to non-dark mode, and they should theme themselves to reflect this change.
                NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
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

extension Notification.Name {
    static let darkModeEnabled = Notification.Name("com.yourApp.notifications.darkModeEnabled")
    static let darkModeDisabled = Notification.Name("com.yourApp.notifications.darkModeDisabled")
}
