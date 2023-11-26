//
//  CreateMovie.swift
//
//
//  Created by Mauricio Figueroa on 26-11-23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovie: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("movies")
            .id()
            .field("title", .string)
            .field("imageURL", .string)
            .create()
    }
 
    func revert(on database: Database) async throws {
        try await database.schema("movies") // drop the table
            .delete()
    }
}
