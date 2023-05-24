//
//  AuthError.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/22/23.
//

enum AuthError : Error{
    case EmptyText
    case AccountDoesNotExist
    case MiscError(err: Error)
}
