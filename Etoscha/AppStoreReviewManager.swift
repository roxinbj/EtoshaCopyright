//
//  AppStoreReviewManager.swift
//  Etoscha
//
//  Created by Björn Roxin on 28.09.21.
//

import StoreKit

enum AppStoreReviewManager {
    static let minimumReviewWorthyActionCount = 2
    static let miniumStartupCounts = 5

  static func requestReviewIfAppropiate() {
    let defaults = UserDefaults.standard
    let bundle = Bundle.main
    
    var actionCount = defaults.integer(forKey: .reviewWorthyActionCount)
    let startupCounts = defaults.integer(forKey: .appStartupsActionCount)
    
    guard startupCounts >= miniumStartupCounts else {
        return
    }
    
    actionCount += 1
    
    defaults.set(actionCount,forKey: .reviewWorthyActionCount)
    
    guard actionCount >= minimumReviewWorthyActionCount else {
      return
    }
    
    let bundleVersionKey = kCFBundleVersionKey as String
    let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
    let lastVersion = defaults.string(forKey: .lastReviewRequestAppVersion)
    
    guard lastVersion == nil || lastVersion != currentVersion else {
      return
    }
    
    SKStoreReviewController.requestReview()
    
    defaults.set(0,forKey: .reviewWorthyActionCount)
    defaults.set(currentVersion,forKey: .lastReviewRequestAppVersion)
  }
}

