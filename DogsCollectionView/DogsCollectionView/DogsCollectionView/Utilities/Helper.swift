//
//  Helper.swift
//  DogsCollectionView
//
//  Created by Sensehack on 3/26/21.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                print("Error retrieving data")
                return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
            
        }.resume()
        
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


extension String {

    func formatDateString(dateString: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//        print("Date " + self)
        var convertedDate = dateFormatterPrint.string(from: Date())
        
        if let date = dateFormatterGet.date(from: self) {
            print(dateFormatterPrint.string(from: date))
            convertedDate = dateFormatterPrint.string(from: date)
        } else {
            // Could remove T & Z to format accordingly, I wasn't aware of specific encoding date format.
            /*
             "2021-03-26T16:52:41Z"
             "2021-03-26 16:52:41"
            */
//            print("There was an error decoding the string")
        }

        return convertedDate
    }

}
