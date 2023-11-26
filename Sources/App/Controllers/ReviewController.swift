//
//  File.swift
//  
//
//  Created by Mauricio Figueroa on 26-11-23.
//

import Foundation
import Vapor

struct ReviewController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let review = routes.grouped("reviews")
        review.get(use: index)
        review.post(use: create)
    }
    
    func index(req: Request) async throws -> [Review] {
        try await Review.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Review {
        let review = try req.content.decode(Review.self)
        try await review.save(on: req.db)
        
        return review
    }
}
