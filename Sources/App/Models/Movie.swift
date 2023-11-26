//
//  File.swift
//  
//
//  Created by Mauricio Figueroa on 26-11-23.
//

import Foundation
import Fluent
import Vapor

final class Movie: Model, Content {
    static let schema: String = "movies"  // table name
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String

    @Field(key: "imageURL")
    var imageURL: String
    
    init() {}
    
    init(id: UUID? = nil, title: String, imageURL: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}
