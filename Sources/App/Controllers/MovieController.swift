//
//  MovieController.swift
//
//
//  Created by Mauricio Figueroa on 26-11-23.
//

import Foundation
import Vapor

struct MovieController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let movie = routes.grouped("movies")
        
        movie.post(use: create)
        movie.get(use: index)
    }
    
    func create(req: Request) async throws -> Movie {
        let movie = try req.content.decode(Movie.self)
        try await movie.save(on: req.db)
        
        return movie
    }
    
    func index(req: Request) async throws -> [Movie] {
        try await Movie.query(on: req.db).all()
    }
}
