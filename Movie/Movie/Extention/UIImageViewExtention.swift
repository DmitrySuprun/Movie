//
//  UIImageViewExtention.swift
//  Movie
//
//  Created by Дмитрий Супрун on 27.10.22.
//

import UIKit.UIImageView

// MARK: - Extension UIImageView
extension UIImageView {
    func loadImage(urlName: String) {
        guard let url = URL(string: urlName) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let self = self,
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
