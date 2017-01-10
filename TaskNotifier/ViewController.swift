//
//  ViewController.swift
//  TaskNotifier
//
//  Created by shashank kannam on 1/9/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var reminderText:UITextField!

    @IBOutlet weak var reminderTimeInterval:UITextField!
    
    
    @IBAction func remindMe(_ sender: UIButton){
        
       scheduleNotification(timeinterval: Double(reminderTimeInterval.text!)!*60) { (success) in
        if success{
          print("successfully scheduled and is called second: \(success)")
        }
        else{
            
        }
        }
        print("successfully shecduled and is called third")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        requestPermission()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func requestPermission(){
       
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted{
                print("Notification access granted")
            }else{
                print((error?.localizedDescription)! as String)
            }
        }
        
    }
    
    func scheduleNotification(timeinterval:TimeInterval, completion:@escaping (_ success: Bool) -> ()){
      
        let imageURL = Bundle.main.url(forResource: "rick_grimes", withExtension: "gif")
        
        let notificationContent = UNMutableNotificationContent()
        
        //For custom only this one line
        notificationContent.categoryIdentifier = "myNotificationCategory"
        
        notificationContent.title = "TaskNotifier"
        notificationContent.subtitle = "Hello!! "
    notificationContent.body = "Just to remind you the task -> \(reminderText.text!)"
        
        var attachment:UNNotificationAttachment!
        do{
         attachment = try UNNotificationAttachment(identifier: "myAttachment", url: imageURL!, options: nil)
        }catch let error as NSError{
            print(error.debugDescription)
        }
        notificationContent.attachments = [attachment]
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeinterval, repeats: false)
        
        let notificationRequest = UNNotificationRequest(identifier: "nfRequestIdentifier", content: notificationContent, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if error != nil{
              print(error.debugDescription)
                 print("successfully scheduled and is called first: ")
                completion(false)
            }
            else{
                 print("successfully shecduled and is called first:  ")
                completion(true)
            }
        }
    }
    

}

