//
//  AppDelegate.swift
//  copier
//
//  Created by AKSHAY MAHAJAN on 2023-07-13.
//

import UIKit
import Foundation
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
//	@StateObject var clipboardData = ClipboardData()
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Add observer for clipboard changes
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleClipboardChange),
			name: UIPasteboard.changedNotification,
			object: nil
		)
		
		return true
	}
	
	@objc func handleClipboardChange() {
		if let copiedText = UIPasteboard.general.string {
			// Clipboard content has changed, handle it here
			print("Clipboard content: \(copiedText)")
//			let clipboardData = ClipboardData()
			if ClipboardData.sharedInstance.copiedText.last != copiedText {
				ClipboardData.sharedInstance.copiedText.append(copiedText)
			}
		}
	}
}

