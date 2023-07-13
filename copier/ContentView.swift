//
//  ContentView.swift
//  copier
//
//  Created by AKSHAY MAHAJAN on 2023-07-13.
//

import SwiftUI
import UIKit

struct ContentView: View {
	
	@State var copiedStrings = [String]()
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
			.padding(7.5)
			.frame(width: 200)
			.border(.black)
			Text("Copied texts show up here")
				.padding()
			if !copiedStrings.isEmpty {
				List(copiedStrings, id: \.self) { copiedString in
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
	func updateClipboard() {
		if let copiedText = UIPasteboard.general.string {
			if !copiedStrings.contains(copiedText) {
				copiedStrings.append(copiedText)
			}
			
		}
	}
}
