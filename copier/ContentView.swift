//
//  ContentView.swift
//  copier
//
//  Created by AKSHAY MAHAJAN on 2023-07-13.
//

import SwiftUI
import UIKit
import BackgroundTasks

struct ContentView: View {
	@ObservedObject private var clipboardData = ClipboardData.sharedInstance
	@Environment (\.scenePhase) var scenePhase
	@State var text: String = ""
	
    var body: some View {
        ScrollView {
			
			Text("Copied Texts")
				.font(.title)
				.padding(15)
			
			Text("This app listens to changes to the clipboard")
			
			TextField(text: $text) {
				Text("Type text here to copy")
			}
			.autocorrectionDisabled()
			.textInputAutocapitalization(.never)
			.padding(7.5)
			.frame(width: 200)
			.border(.black)
			
			Text("Copied texts show up below:")
				.padding()
			
			if !clipboardData.copiedText.isEmpty {
				ForEach(clipboardData.copiedText, id: \.self) { copiedString in
					Text(copiedString)
				}
			} else {
				Text("No copied text added to the clipboard")
					.foregroundColor(.red)
			}
        }
        .padding()
		
		.onAppear {
			NotificationCenter.default.addObserver(forName: UIPasteboard.changedNotification, object: nil, queue: nil) { _ in
				updateClipboard()
			}
		}
		.onDisappear {
			NotificationCenter.default.removeObserver(self, name: UIPasteboard.changedNotification, object: nil)
		}
		.onChange(of: scenePhase) { newPhase in
			if newPhase != .active {
				scheduleBackgroundTask()
			} else {
				
			}
		}		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
	private func updateClipboard() {
		if let copiedText = UIPasteboard.general.string {
			//Allow repetion but not subsequent copying
			if clipboardData.copiedText.last != copiedText {
				clipboardData.copiedText.append(copiedText)
			}
		}
	}
	
	private func scheduleBackgroundTask() {
		let request = BGAppRefreshTaskRequest(identifier: "checkClipboard")
//		request.earliestBeginDate = .now
		do {
			try BGTaskScheduler.shared.submit(request)
		} catch {
			clipboardData.copiedText.append("couldn't run process")
			print("Couldn't run process: \(error)")
		}
		
	}
}
