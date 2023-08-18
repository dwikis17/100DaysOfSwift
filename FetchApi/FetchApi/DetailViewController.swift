//
//  DetailViewController.swift
//  FetchApi
//
//  Created by Dwiki Dwiki on 17/08/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageName: String?

    @IBOutlet var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = URL(string: imageName!) {
            let session = URLSession.shared
        
            let task = session.dataTask(with: imageUrl) { (data, response, error) in
                
                if let error = error {
                    print("Error \(error) ")
                }
                
                if let imageData = data {
                    print(imageData)
                    if let imageD = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.image.image = imageD
                        }
                    }
                }
                
            }
            task.resume()
        }
        
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
