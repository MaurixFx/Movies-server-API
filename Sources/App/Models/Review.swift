//
//  File.swift
//  
//
//  Created by Mauricio Figueroa on 26-11-23.
//

import Foundation
import Fluent
import Vapor

final class Review: Model, Content {
    static let schema: String = "reviews"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Parent(key: "movie_id") // FK
    var movie: Movie
    
    init() {}
    
    init(id: UUID? = nil, title: String, body: String, movieId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$movie.id = movieId
    }
}
