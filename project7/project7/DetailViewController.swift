//
//  DetailViewController.swift
//  project7
//
//  Created by Dwiki Dwiki on 29/08/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    @objc func seeCredits(){
        let ac = UIAlertController(title: "Credits", message: "this data comes from We THe People API of the WhiteHosue", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "submit", style: .default))
        
        present(ac,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(seeCredits))
        
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width", initial-scale=1">
        <style> body { font-size: 150%; background-color: coral;} </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
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
