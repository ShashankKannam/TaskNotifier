//
//  NotificationViewController.swift
//  CustomNotifications
//
//  Created by shashank kannam on 1/10/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        guard let attachment = notification.request.content.attachments.first else{
                return
            }
        
        if attachment.url.startAccessingSecurityScopedResource(){
            let imagedata = try? Data(contentsOf: attachment.url)
            if let image = imagedata{
                imageView.image = UIImage(data: image)
            }
        }
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "remindMeIn5MIn"{
            completion(.dismissAndForwardAction)
        }
        if response.actionIdentifier == "dissmiss"{
            completion(.dismissAndForwardAction)
        }
   }
}
