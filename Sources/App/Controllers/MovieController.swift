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
        movie.put(use: update)
        
        movie.group(":movieId") { movie in
            movie.get(use: show)
            movie.delete(use: delete)
        }
    }
    
    func create(req: Request) async throws -> Movie {
        let movie = try req.content.decode(Movie.self)
        try await movie.save(on: req.db)
        
        return movie
    }
    
    func index(req: Request) async throws -> [Movie] {
        try await Movie.query(on: req.db).all()
    }
    
    func show(req: Request) async throws -> Movie {
        guard let movie = try await Movie.find(req.parameters.get("movieId"), on: req.db) else {
            throw Abort.init(.notFound)
        }
        
        return movie
    }
    
    func update(req: Request) async throws -> HTTPStatus {
        let updatedMovie = try req.content.decode(Movie.self)
        
        guard let movie = try await Movie.find(updatedMovie.id, on: req.db) else {
            throw Abort.init(.notFound)
        }
        
        movie.title = updatedMovie.title
        
        try await movie.update(on: req.db)
        
        return .ok
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let movie = try await Movie.find(req.parameters.get("movieId"), on: req.db) else {
            throw Abort.init(.notFound)
        }
        
        try await movie.delete(on: req.db)
        
        return .ok
    }
}
