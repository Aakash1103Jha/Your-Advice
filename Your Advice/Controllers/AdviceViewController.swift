//
//  ViewController.swift
//  Your Advice
//
//  Created by Aakash Jha on 11/09/21.
//

import UIKit

class AdviceViewController: UIViewController {

    @IBOutlet var adviceLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    
    var activityIndicator = UIActivityIndicatorView(style: .large )
        
    override func viewDidLoad() {
        super.viewDidLoad()
        getAdvice()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        self.adviceLabel.text = ""
        self.idLabel.text = "Slip ID: "
        getAdvice()
    }
    
    func indicator() {
        activityIndicator.frame = self.view.bounds
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }

    func getAdvice() {
        indicator()
        if let url = URL(string: "https://api.adviceslip.com/advice") {
            let session = URLSession.shared
            session.dataTask(with: url,completionHandler: { data, response, error in
                if let e = error {
                    return print(e.localizedDescription)
                }
                if let safeData = data {
                    if let finalData = self.decodeData(data: safeData) {
                        DispatchQueue.main.async {
                            self.adviceLabel.text = finalData.slip.advice
                            self.idLabel.text = "Slip ID: \(String(finalData.slip.id))"
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }).resume()
        }
    }
    
    func decodeData(data: Data) -> Slip? {
        let decoder = JSONDecoder()
        do {
            let jsonData = try decoder.decode(Slip.self, from: data)
            return jsonData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
