//
//  ViewController.swift
//  ByteCoin
//
//  Created by matthew savidge on 12/14/21.
//

import UIKit

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
    }
    var coinManager = CoinManager()
    
    @IBOutlet weak var exchangeOutput: UILabel!
    
    @IBOutlet weak var currencyExchangeField: UITextField!
    
    
    @IBAction func exchangePressed(_ sender: UIButton) {
        let currencytype = currencyExchangeField.text
        if currencytype != nil{
            coinManager.fetchPrice(for: currencytype!)
        }
    }
}

extension ViewController: CoinManagerDelegate{
    func didUpdateCoinExchange(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.exchangeOutput.text = coin.xChangeString
        }
    }
    func didFailWithErro(_ error: Error) {
        print(error)
    }
}

