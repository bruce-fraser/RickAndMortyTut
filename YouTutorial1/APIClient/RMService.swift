//
//  RMService.swift
//  YouTutorial1
//
//  Created by Bruce Fraser on 3/8/23.
//

import Foundation

/// Primary API service object to get R&M data
final class RMService {
    static let shared = RMService()
    
    private init() {}
    
    /// Send R&M API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Calleback
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
