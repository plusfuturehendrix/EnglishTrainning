//
//  SceneDelegate.swift
//  EnglishTrainning
//
//  Created by Danil Bochkarev on 27.03.2023.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let viewController = ViewController()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

}
