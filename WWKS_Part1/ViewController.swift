//
//  ViewController.swift
//  WWKS_Part1
//
//  Created by Stephanie Chiu on 1/3/2021.
//  Copyright © 2021 Stephanie Chiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Model
    
    struct Contents: Codable {
        var quote: String
    }
    
    //MARK: - Properties
    
    var quote: Contents?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var randomizeBtn: UIButton!
    
    //MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newQuote()
    }
    
    //MARK: - Functions
    
    // Generates new Kanye quote
    func newQuote() {
        guard let url = URL(string: "https://api.kanye.rest") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            guard let data = data else { return }
            do {
                self.quote = try JSONDecoder().decode(Contents.self, from: data)
                DispatchQueue.main.async {
                    if let kanyeQuote = self.quote {
                        self.quoteLabel.text = kanyeQuote.quote
                        print(kanyeQuote.quote)
                    }
                }
            }
            catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    
    @IBAction func randomizeBtnAction(_ sender: UIButton) {
        newQuote()
    }

}

