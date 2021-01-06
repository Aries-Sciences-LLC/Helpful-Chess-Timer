//
//  PaletteViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 12/31/20.
//  Copyright © 2020 Ozan Mirza. All rights reserved.
//

import UIKit

class PaletteViewController: PrefrencesViewController {
    
    var selectedPalette: Palette!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func applyPalette(_ sender: Any!) {
        PaletteManager.shared.current = selectedPalette
        dismiss(animated: true, completion: nil)
    }
}

extension PaletteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PaletteManager.shared.palettes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaletteCell.reuseID, for: indexPath) as! PaletteCell
        cell.configure(with: PaletteManager.shared.palettes[indexPath.item])
        cell.delegate = self
        return cell
    }
}

extension PaletteViewController: PaletteCellDelegate {
    func handleSelection(for palette: Palette) {
        selectedPalette = palette
    }
}
