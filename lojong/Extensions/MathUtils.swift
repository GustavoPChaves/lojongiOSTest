//
//  MathUtils.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import Foundation

extension Comparable
{
    func clamp<T: Comparable>(lower: T, _ upper: T) -> T {
        return min(max(self as! T, lower), upper)
    }
    func clamp<T: Comparable>(number: T, _ lower: T, _ upper: T) -> T {
        return min(max(number, lower), upper)
    }
}
