//
//  UIImageView+getImage.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit

extension UIImageView {
    /// For real-app purouses we should implement some sort of images caching and deal with ther problems due to potential memory-managment issues.
    public func getImage(from url: URL?, completion: @escaping () -> Void = {}) {
        guard let url = url else {
            completion()
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion()
                    return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion()
            }
        }.resume()
    }
}
