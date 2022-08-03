//
//  ItemModel.swift
//  Todoey
//
//  Created by Семен Гайдамакин on 01.08.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

class Item : Codable {  // item type is able to encode himself into plist of json
    var title : String = ""
    var done : Bool = false
}
