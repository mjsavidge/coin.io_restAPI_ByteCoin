//
//  CoinModel.swift
//  ByteCoin
//
//  Created by matthew savidge on 12/14/21.
//

import Foundation

struct CoinModel{
    let assetID : String
    let xChange : Double
    var xChangeString : String{
        return String(format: "%.2f", xChange)
    }
}
