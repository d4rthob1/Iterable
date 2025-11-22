//
//  AppDelegate.swift
//  IterableSAMobileChallenge
//
//  Created by Rufino Cudia on 11/21/25.
//

import UIKit
import IterableSDK

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        let config = IterableConfig()
        config.enableEmbeddedMessaging = true

        IterableAPI.initialize(
            apiKey: "<redacted-for-public-repo>",
            launchOptions: launchOptions,
            config: config
        )
        
        // Identify the user (self)
        IterableAPI.email = "<redacted-for-public-repo>"

        return true
    }
}
