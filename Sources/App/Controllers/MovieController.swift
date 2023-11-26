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
    }
    
    func create(req: Request) async throws -> Movie {
        let movie = try req.content.decode(Movie.self)
        try await movie.save(on: req.db)
        
        return movie
    }
}