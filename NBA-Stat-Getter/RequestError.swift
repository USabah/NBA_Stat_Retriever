//
//  RequestError.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/23/23.
//

enum RequestError : Error{
    case EmptyText
    case PlayerNotFound
    case ImageNotFound
    case BadData
    case BadURL
}

