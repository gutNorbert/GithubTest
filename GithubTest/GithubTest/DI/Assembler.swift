//
//  Assembler.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/30/23.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler : Assembler = {
        let container = Container()
        
        let assembler = Assembler([
        ServiceAssembly(),
        ViewAssembly(),
        ViewModelAssembly()
        ], container: container)
        return assembler
    }()
}
