//
//  PaletteManager.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import Foundation

class PaletteManager {
    static let shared = PaletteManager()
    
    public var palettes: [Palette]!
    
    private var index: Int!
    public var current: Palette {
        get {
            return palettes[index]
        }
        set {
            palettes.append(newValue)
            index = palettes.count - 1
            update()
        }
    }
    
    init() {
        index = 0
        load()
    }
    
    private func load() {
        guard let path = Bundle.main.path(forResource: "Palettes", ofType: "json") else {
            fatalError("Cannot locate Palettes data...")
        }
        
        do {
            let location = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: location, options: .mappedIfSafe)
            
            if let _palettes = try? JSONDecoder().decode([Palette].self, from: data) {
                palettes = _palettes
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func update() {
        if let data = try? JSONEncoder().encode(palettes) {
            guard let path = Bundle.main.path(forResource: "Palettes", ofType: "json", inDirectory: "Assets") else {
                fatalError("Cannot locate Palettes data...")
            }
            
            do {
                try data.write(to: URL(fileURLWithPath: path))
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
