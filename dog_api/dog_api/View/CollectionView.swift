//
//  DogBreedsCollection.swift
//  dog_api
//
//  Created by spark-03 on 2024/02/20.
//

import UIKit
import Alamofire
import AlamofireImage

class DogBreedsCollection: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var dogCollectionView: UICollectionView!
    
    
    var selectedBreed: String?
    var imageUrls: [URL] = []
    //var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dogCollectionView.delegate = self
        dogCollectionView.dataSource = self
        
        if let selectedBreed = selectedBreed {
            navigationItem.title = selectedBreed
        }
        
        getBreeds()
    }
    
    
    func getBreeds()  {
        guard let selectedBreed = selectedBreed else {
            return
        }
        
        let dogUrlBreed = "https://dog.ceo/api/breed/\(selectedBreed)/images"
        AF.request(dogUrlBreed).responseDecodable(of: DogImageResponse.self) { response in
            switch response.result {
            case .success(let dogImageResponse):
                self.imageUrls = dogImageResponse.message.compactMap { URL(string: $0) }
                self.dogCollectionView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogPhoto", for: indexPath) as? BreedsCell else {
            return UICollectionViewCell()
        }
     //   cell.configure(with: imageUrls[indexPath.row])
        cell.test(url: imageUrls[indexPath.row])
        return cell
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 1) / 2 // 2枚の画像を表示するために、横幅を半分にする
        print(cellWidth)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // セル間の水平方向の余白を1に設定する
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // セル間の垂直方向の余白を1に設定する
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "toCloseUp" {
            if let nextScene = segue.destination as? CloseUpViewController {
                nextScene.breedsImage = imageUrls
            }
        }
    }
}
