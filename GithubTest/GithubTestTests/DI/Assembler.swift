//
//  Assembler.swift
//  GithubTestTests
//
//  Created by Gutpinter Norbert on 2/2/23.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler : Assembler = {
        let container = Container()
        
        let assembler = Assembler([
        ServiceAssembly()
        ], container: container)
        return assembler
    }()
    
    enum SearchServiceMockTypes: String {
        case searchServiceSuccess
        case searchServiceFailure
    }
}
