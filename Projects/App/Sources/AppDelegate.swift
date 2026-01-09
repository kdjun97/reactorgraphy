//
//  AppDelegate.swift
//  ReactorGraphy
//
//  Created by 김동준 on 12/29/25
//

import UIKit
import DI
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print("🚀 AppDelegate launched")
        DIContainer.shared.register()
        setImageCache()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

private extension AppDelegate {
    func setImageCache() {
        let cache = ImageCache.default
        
        // 1. 메모리 캐시 용량 제한 (예: 100MB)
        // 기기의 메모리 압박을 줄이기 위해 설정합니다.
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024
        
        // 2. 디스크 캐시 용량 제한 (예: 500MB)
        // 사용자의 핸드폰 저장 공간을 과도하게 점유하지 않도록 합니다.
        cache.diskStorage.config.sizeLimit = 500 * 1024 * 1024
        
        // 3. 캐시 유효 기간 설정 (예: 7일)
        // 너무 오래된 데이터는 자동으로 삭제되도록 합니다.
        cache.diskStorage.config.expiration = .days(7)
        
        // 4. (선택) 앱이 백그라운드로 갈 때 메모리 캐시 비우기
        // 시스템에 의해 앱이 강제 종료되는 것을 방지합니다.
        cache.memoryStorage.config.cleanInterval = 120 // 2분마다 정리
    }
}
