//
//  Sale.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

struct Sale: Codable {
    
    let id: UUID = UUID()
    
    var products: [Product]
    var payment: Payment
    
}
