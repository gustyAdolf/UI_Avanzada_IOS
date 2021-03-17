//
//  String+DateFormat.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 15/3/21.
//

import Foundation

extension String {
    func formatedStringDate(fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = fromFormat
        guard let date = dateFormat.date(from: self) else {fatalError("No date input.")}
        dateFormat.dateFormat = toFormat
        return dateFormat.string(from: date)
    }
}
