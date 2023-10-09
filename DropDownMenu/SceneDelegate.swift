//
//  SceneDelegate.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 24.08.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appLogInTime = Date().timeIntervalSince1970
    var timeWhenAppWasOpenAgain = Date().timeIntervalSince1970
    var timeWhenAppWasClosedAgain = Date().timeIntervalSince1970
    var totalTimeInApp = TimeInterval()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let viewController = DropDownViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        timeWhenAppWasOpenAgain = Date().timeIntervalSince1970
        print(">>>>>>>>>>>sceneWillEnterForeground", timeWhenAppWasOpenAgain)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        timeWhenAppWasClosedAgain = Date().timeIntervalSince1970
        let newTime = timeWhenAppWasClosedAgain - timeWhenAppWasOpenAgain
        let timeInCorrectForm = Date(timeIntervalSinceNow: newTime)
        print(">>>>>>>>>>>newTime", newTime)
        print(">>>>>>>>>>>timeInCorrectForm", timeInCorrectForm)
        totalTimeInApp = totalTimeInApp  + newTime
        
        print(">>>>>>>>>>>totalTimeInApp", totalTimeInApp)
        var totalTimeInAppInCorrectForm = stringFromTimeInterval(totalTimeInApp)
//        print(">>>>>>>>>>>totalTimeInAppInCorrectForm", totalTimeInAppInCorrectForm)
//        print("time in app", totalTimeInAppInCorrectForm)
        print(totalTimeInAppInCorrectForm)
        print(totalTimeInApp.asString(style: .positional))
        print(totalTimeInApp.asString(style: .short))
        print(totalTimeInApp.asString(style: .brief))

        totalTimeInApp = 0
    }
    
    func stringFromTimeInterval(_ interval: TimeInterval) -> String {
//        NSInteger(interval)
        let timeInterval = NSInteger(3720.094785213470459)
        
        let seconds = timeInterval % 60
        let timeIntervalMinutes = NSInteger(1000000)
//        let minutes = (timeInterval / 60) % 60
        let minutesInt = (timeInterval / 60)
//        let minutesInterval = (timeInterval*10 / 60)
        let hours = (timeInterval / 3600)
//        print(seconds)
//        print(minutes)
//        print(hours)
//        print(1111.asString(style: .positional))
//        print(2222.asString(style: .short))
//        print(3333.asString(style: .brief))
//        print("time in app", NSString(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds))
//        print(NSString(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds))
        print(NSString(format: "%0.2d:%0.2d:%0.2d", hours, minutesInt, seconds))
//        print(NSString(format: "%0.2d:%0.2d:%0.2d", hours, minutesInterval, seconds))
        return "\(hours) hours, \(minutesInt) minutes, \(seconds) seconds"
    }
}

extension Double {
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
       let formatter = DateComponentsFormatter()
       formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
       formatter.unitsStyle = style
       return formatter.string(from: self) ?? ""
     }
}
