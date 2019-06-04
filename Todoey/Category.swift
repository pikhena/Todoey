//
//  Category.swift
//  Todoey
//
//  Created by Priscilla Ikhena on 04/06/2019.
//  Copyright © 2019 Priscilla Ikhena. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>() //sort of like creating an array.
   
}
