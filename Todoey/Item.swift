//
//  Item.swift
//  Todoey
//
//  Created by Priscilla Ikhena on 04/06/2019.
//  Copyright © 2019 Priscilla Ikhena. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object  {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    @objc dynamic var dateCreated : Date?
}
