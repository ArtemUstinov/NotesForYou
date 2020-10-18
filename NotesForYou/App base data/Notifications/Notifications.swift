//
//  Notifications.swift
//  NotesForYou
//
//  Created by Артём Устинов on 12.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificaionCenter = UNUserNotificationCenter.current()
    
    func requestAutorization() {
        notificaionCenter.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificaionCenter.getNotificationSettings { (settings) in
            print("Notfication settings: \(settings)")
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        
        let userAction = "User action"
        
        content.title = "Notification"
        content.body = "This is example how to create"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction
        
        guard let path = Bundle.main.path(forResource: "pad", ofType: "png") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let attachment = try UNNotificationAttachment(
                identifier: "pad",
                url: url,
                options: nil)
            
            content.attachments = [attachment]
        } catch {
            print("The attachment could't be load")
        }
        
        let date = Date(timeIntervalSinceNow: 3600)
        var triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        triggerDaily.hour = 20
        triggerDaily.minute = 14
        triggerDaily.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily,
                                                    repeats: true)
        let identifier = "Local notification"
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        notificaionCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let deleteAction = UNNotificationAction(identifier: "Delete",
                                                title: "Delete",
                                                options: [.destructive])
        
        let category =  UNNotificationCategory(identifier: userAction,
                                               actions: [deleteAction],
                                               intentIdentifiers: [],
                                               options: [])
        
        notificaionCenter.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local notification" {
            print("Handling notification with the 'Local notification' identifier")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Delete":
            print("Delete")
        default:
            print("unknown action")
        }
        
        completionHandler()
    }
}
