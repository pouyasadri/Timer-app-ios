//
//  ExtenstionDouble.swift
//  TimerApp
//
//  Created by Pouya Sadri on 21/12/2023.
//

import Foundation

extension Double{
	func asString(style: DateComponentsFormatter.UnitsStyle) -> String{
		let formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.hour,.minute,.second,.nanosecond]
		formatter.unitsStyle = style
		return formatter.string(from: self) ?? "" 
	}
}
