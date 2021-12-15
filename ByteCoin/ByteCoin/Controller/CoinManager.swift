//
//  CoinManager.swift
//  ByteCoin
//
//  Created by matthew savidge on 12/14/21.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoinExchange(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithErro(_ error: Error)
}

struct CoinManager{
    var delegate: CoinManagerDelegate?
    
    let baseURL = URLComponents(string: "https://rest.coinapi.io/v1/exchangerate/BTC/")!
    let apiKey = "8A5DE075-6CFA-48E4-8C5C-386D45C6D852"
    
    func fetchPrice(for assetID: String){
        let url = "\(baseURL)\(assetID)?apikey=\(apiKey)"
        peformRequest(with: url)
    }
    
    func peformRequest(with baseURL : String){
        if let url = URL(string: baseURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, respose, error in
                if error != nil{
                    self.delegate?.didFailWithErro(error!)
                }
                if let safeData = data{
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoinExchange(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let coinRate = decodedData.rate
            let id = decodedData.asset_id_quote
            
            let coin = CoinModel(assetID: id, xChange: coinRate)
            return coin
        }catch{
            delegate?.didFailWithErro(error)
            return nil
        }
    }
}
