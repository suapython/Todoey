//
//  Category.swift
//  Todoey
//
//  Created by jose francisco morales on 14/01/2020.
//  Copyright © 2020 jose francisco morales. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
