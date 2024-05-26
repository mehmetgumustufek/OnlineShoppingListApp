//
//  OnlineShoppingListAppApp.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import FirebaseCore
import SwiftUI
import FirebaseMessaging

@main
struct OnlineShoppingListAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init(){
        FirebaseApp.configure()
        
    }
    var body: some Scene {
        WindowGroup {
            MainView()
            
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Messaging.messaging().delegate = self

        // Bildirim izinlerini iste
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
            // Bildirim izinleri istendiğinde yapılacak işlemler
        }
        application.registerForRemoteNotifications()

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // Bildirim alındığında yapılacak işlemler
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
    }
}
