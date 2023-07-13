//
//  ClipboardData.swift
//  copier
//
//  Created by AKSHAY MAHAJAN on 2023-07-13.
//

import Foundation

class ClipboardData: ObservableObject {
	static let sharedInstance = ClipboardData()
	@Published var copiedText = [String]()
}
