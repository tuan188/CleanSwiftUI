//
//  APISessionManager.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 27/10/2022.
//

import Foundation
import RequestBuilder

struct APISessionManager {
    static let gitSessionManager: BaseSessionManager = {
        let base = URL(string: Config.URLs.Git.base)
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        
        return BaseSessionManager(base: base, session: session)
            .set(decoder: JSONDecoder())
            .set(encoder: JSONEncoder())
    }()
}
