//
//  ViewController.swift
//  FetchApi
//
//  Created by Dwiki Dwiki on 17/08/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var products = [Product]()

    var url = "https://dummyjson.com/products"
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(URL: url) { result in
            self.products = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return products.count
      }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)


        cell.textLabel?.text = products[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.imageName = products[indexPath.row].images[0]

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



func fetchData(URL url: String, completion: @escaping ([Product]) -> Void)  {
    guard let url = URL(string: url) else {
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let productListResponse = try decoder.decode(ProductListResponse.self, from: data!)
            
            // Access the products array
            let products = productListResponse.products
            completion(products)
            // Access the total, skip, and limit values
//            let total = productListResponse.total
//            let skip = productListResponse.skip
//            let limit = productListResponse.limit
            
        } catch {
            print("Error decoding JSON: \(error)")
        }


    }
    
    task.resume()
}


