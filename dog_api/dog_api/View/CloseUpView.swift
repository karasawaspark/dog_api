//
//  CloseUpViewController.swift
//  dog_api
//
//  Created by spark-03 on 2024/02/29.
//

import UIKit

class CloseUpViewController: UIViewController {
    
    @IBOutlet weak var expandedImage: UIImageView!
    
    var breedsImage: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //expandedImage.image = UIImage(named: breedsImage)
        
        if let firstURL = breedsImage.first {
            //firstURLはbreeedsImageの最初の画面
            DispatchQueue.global().async {

                if let imageData = try? Data(contentsOf: firstURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.expandedImage.image = image
                    }
                } else {
                    print("Failed to load image from URL: \(firstURL)")
                }
            }
        } else {
            print("No URL found in breedsImage")
        }
    }
}





//        let url = URL(string: "https://example.com/image.jpg")
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//
//            guard let data = data else {
//                print("Data is nil")
//                return
//            }
//
//            DispatchQueue.main.async {
//                imageView.image = UIImage(data: data)
//            }
//        }
//        task.resume()


//expandedImage.image = breedsImage

//        if let firstURL = breedsImage.first {
//            if let imageData = try? Data(contentsOf: firstURL),
//               let image = UIImage(data: imageData) {
//                expandedImage.image = image
//            } else {
//                print("Failed to load image from URL: \(firstURL)")
//            }
//        } else {
//            print("No URL found in breedsImage")
//        }


//expandedImage.image = UIImage(named: breedsImage)

// Do any additional setup after loading the view

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
