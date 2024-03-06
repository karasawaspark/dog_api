//
//  BreedsCell.swift
//  dog_api
//
//  Created by spark-03 on 2024/02/20.
//

import UIKit
import Alamofire
import AlamofireImage

class BreedsCell: UICollectionViewCell {
    
    @IBOutlet weak var breedsImageView: UIImageView!
    
    //画像に関する処理を書く
    
    func configure(with url: URL) {
        AF.request(url).responseImage{[weak self] response in
            switch response.result {
            case .success(let image):
                self?.breedsImageView.image = image
            case .failure(let error):
                print("Error loading image : \(error)")
            }
        }
    }
    
    func test (url : URL) {
        breedsImageView.af.setImage(withURL: url)
    }
    
}

//breedsImageView
