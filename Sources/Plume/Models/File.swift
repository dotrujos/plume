//
//  File.swift
//  Plume
//
//  Created by Gabriel Araújo on 23/04/26.
//

import Foundation

struct File: Hashable, Identifiable {
    var id: URL { url }
    let url: URL
    let isDirectory: Bool
    let name: String
    var contents: [File]?
}
