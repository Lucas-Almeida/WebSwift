//
//  ViewController.swift
//  WebHTTP
//
//  Created by Lucas Pinheiro Almeida on 07/12/2018.
//  Copyright © 2018 Lucas Pinheiro Almeida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbShow: UILabel!
    @IBOutlet weak var lbNumChar: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBAction func btnGoClick(_ sender: UIButton) {
        doDownloadWebPage()
        lbShow.text = "CharacteresLidos"
    }
    
    func doDownloadWebPage() {
        let httpURL = URL(string: "https://www.youtube.com")!
        
        let httpTask = URLSession.shared.dataTask(with: httpURL) {
            (data, response, error) in
            
            guard let validData = data, error == nil else {
                DispatchQueue.main.async {
                    print("Error getting the website \(httpURL)\n")
                }
                return
            }
            
            let results = String(data: validData, encoding: String.Encoding.utf8) ?? "Error decoding website \(httpURL)\n"
            
            DispatchQueue.main.async {
                self.lbNumChar.text = String(results.count)
                self.textView.text = results
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            httpTask.resume()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

