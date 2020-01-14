//
//  WeakArray.swift
//  FieldBit
//
//  Created by Volodymyr Vrublevskyi on 2.03.2019.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

final class WeakWrapper<A: AnyObject> {
    weak var object: A?
    
    init(_ value: A) {
        object = value
    }
}

struct WeakArray<Element: AnyObject> {
    private var items: [WeakWrapper<Element>] = []

    mutating func append(_ element: Element) {        
        items = items.filter{$0.object != nil}
        items.append(WeakWrapper(element))
    }
    
    mutating func remove(_ element: Element) {
        if let index = items.firstIndex(where: { $0 === element }) {
            items.remove(at: index)
        }
    }
    
    mutating func remove(_ elements: [Element]) {
        items.removeAll(where: { item in
            return elements.contains(where: { $0 === item })
        })
    }
    
    mutating func removeAll() {
        items.removeAll()
    }
}

extension WeakArray: Collection {
    var startIndex: Int { return items.startIndex }
    var endIndex: Int { return items.endIndex }
    
    subscript(_ index: Int) -> Element? {
        return items[index].object
    }
    
    func index(after idx: Int) -> Int {
        return items.index(after: idx)
    }
}
