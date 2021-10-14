//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by mesut  on 1.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var sarLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=28c1b48f3f91eccaa9f1dd961b094175")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else {
                if  data != nil {
                    do{
                        let jsonResponse =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        //ASync
                        DispatchQueue.main.async {
                            if let rates = jsonResponse ["rates"] as? [String : Any]{
                                if let eur = rates["EUR"] as? Double{
                                    self.eurLabel.text = String("EUR:   \(eur)")
                                    
                                }
                                if let turkey = rates["TRY"] as? Double{
                                    self.tryLabel.text = String("TRY:   \(turkey)")
                                    
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = String("USD:   \(usd)")
                                    
                                }
                                if let sar = rates["SAR"] as? Double{
                                    self.sarLabel.text = String("SAR:   \(sar)")
                                    
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = String("JPY:   \(jpy)")
                                    
                                }
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = String("CAD:   \(cad)")
                                    
                                }
                                
                            }
                        }
                    }catch{
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
    }
    
}

