//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by Pierre on 9/14/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fistbumpLabel: UILabel!
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Helper Functions
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {return}
        
        if attachment.url.startAccessingSecurityScopedResource() {
            let imageData = try? Data(contentsOf: attachment.url)
            
            if let image = imageData {
                imageView.image = UIImage(data: image)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "cancelAction" {
        	completion(.dismissAndForwardAction)
        } else if response.actionIdentifier == "openAction" {
            completion(.dismissAndForwardAction)
        }
    }

}
