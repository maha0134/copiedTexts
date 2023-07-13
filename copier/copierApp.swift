//
//  copierApp.swift
//  copier
//
//  Created by AKSHAY MAHAJAN on 2023-07-13.
//

import SwiftUI

@main
struct copierApp: App {
//	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
    var body: some Scene {
//		@ObservedObject var clipboardData = ClipboardData.sharedInstance
        WindowGroup {
            ContentView()
        }
		.backgroundTask(.appRefresh("checkClipboard")) { _ in
			DispatchQueue.global().async {
				let pasteboard = UIPasteboard.general
				let lastChangeCount = pasteboard.changeCount
				while true {
					Thread.sleep(forTimeInterval: 1)
					if pasteboard.changeCount != lastChangeCount {
						if let content = pasteboard.string {
							ClipboardData.sharedInstance.copiedText.append(content)
						}
					}
				}
			}
		}
    }
}
