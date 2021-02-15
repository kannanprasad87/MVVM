//
//  UIImage+Download.swift
//  MVVM
//
//  Created by Kannan, Prasad on 13/02/2021.
//

import UIKit

extension UIImage {
    convenience init?(url:URL?){
        guard let remoteUrl = url else { return nil }
        do {
            self.init(data: try Data(contentsOf: remoteUrl))
        } catch {
            print("Cannot load image from url: \(remoteUrl) with error: \(error)")
            return nil
        }
    }
}
