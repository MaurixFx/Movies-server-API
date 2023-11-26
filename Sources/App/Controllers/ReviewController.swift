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
        review.post(use: create)
    }

    func create(req: Request) async throws -> Review {
        let review = try req.content.decode(Review.self)
        try await review.save(on: req.db)
        
        return review
    }
}
