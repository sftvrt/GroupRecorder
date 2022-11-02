//
//  people.swift
//  Bachelorarbeit
//
//  Created by JT X on 09.09.22.
//

import Foundation
import UIKit

struct People: Identifiable {
    
    var id = UUID().uuidString
    var image: String
    var name:String
    var offset:CGSize = CGSize(width:0, height:0)
    
}

var peoples = [
    People(image:"Image1", name: "girl"),
    People(image: "Image2", name: "boy")
    
]
var firstTwoOffsets: [CGSize] = [
    
    CGSize(width: 100, height: 100),
    CGSize(width: -100, height: -100)
    
]
