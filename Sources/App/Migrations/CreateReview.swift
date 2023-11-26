//
//  File.swift
//  
//
//  Created by Mauricio Figueroa on 26-11-23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateReview: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("reviews")
            .id()
            .field("title", .string)
            .field("body", .string)
            .field("movie_id", .uuid, .references("movies", "id"))
            .create()
    }
 
    func revert(on database: Database) async throws {
        try await database.schema("reviews") // drop the table
            .delete()
    }
}
