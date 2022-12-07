//
//  SceneDelegate.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Properties
    var window: UIWindow?


    
    //MARK: - Scene Delegate Functions
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        launchApplication(scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    
    //MARK: - Helpers
    private func launchApplication(_ scene: UIScene) {
        window                          = UIWindow(windowScene: scene as! UIWindowScene)
        let viewController              = LaunchVC()
        let navController               = UINavigationController(rootViewController: viewController)
        window?.rootViewController      = navController
        window?.makeKeyAndVisible()
    }


}

