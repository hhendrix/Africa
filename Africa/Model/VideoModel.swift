//
//  VideoModel.swift
//  Africa
//
//  Created by Harry Lopez on 12/04/22.
//

import SwiftUI

struct Video: Codable, Identifiable {
    let id:String
    let name: String
    let headline: String
    
    //Computed Property
    
    var thumbnail : String {
        "video-\(id)"
    }
}
