//
//  StatsError.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/24/23.
//

import Foundation

enum StatsError : Error{
    case DocumentNotFound
    case EmptyDocument
    case MiscError(err: Error)
}
