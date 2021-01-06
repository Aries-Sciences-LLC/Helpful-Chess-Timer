//
//  SettingsViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 12/31/20.
//  Copyright © 2020 Ozan Mirza. All rights reserved.
//

import UIKit
import ScalingCarousel

protocol SettingsViewControllerDelegate {
    func set(new duration: Clock.Duration)
    func set(new numOfTaps: Double)
    func shouldUpdateUI()
}

class SettingsViewController: PrefrencesViewController {
    
    @IBOutlet weak var durationCarouselView: ScalingCarouselView!
    @IBOutlet weak var numOfTapsCarouselView: ScalingCarouselView!
    
    var numOfTapsText: [String]!
    var numOfTapsValue: [Double]!
    var durations: [Clock.Duration]!
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        numOfTapsText = Array(50...100).filter({($0 % 5) == 0}).map({ (num) -> String in
            return "\(num == 50 ? "unlimited" : "\(num)") taps"
        })
        
        let placeholder = Array(50...100).filter({($0 % 5) == 0})
        numOfTapsValue = placeholder.map({ (num) -> Double in
            let buffer = Double(num)
            return num == 50 ? .infinity : buffer
        })
        
        durations = [
            .five,
            .ten,
            .thirty,
            .sixty,
            .hundredtwenty,
            .threehundred,
        ]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let delegate = delegate else {
            return
        }
        
        delegate.shouldUpdateUI()
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 125, height: collectionView.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(durationCarouselView) {
            durationCarouselView.didScroll()
        } else {
            numOfTapsCarouselView.didScroll()
        }
    }
}

extension SettingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return durations.count
        case 1:
            return numOfTapsText.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.reuseID, for: indexPath) as! SettingsCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            cell.configure(with: durations[indexPath.item].key, of: durations[indexPath.item])
        case 1:
            cell.configure(with: numOfTapsText[indexPath.item], of: numOfTapsValue[indexPath.item])
        default:
            break
        }
        
        cell.delegate = self
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
}

extension SettingsViewController: SettingsCollectionViewCellDelegate {
    func cellWasSelected(cell: SettingsCollectionViewCell) {
        guard let delegate = delegate else {
            return
        }
        
        if let duration = cell.item as? Clock.Duration {
            delegate.set(new: duration)
        }
        
        if let maxNumOfTaps = cell.item as? Double {
            print("Called from delegate")
            delegate.set(new: maxNumOfTaps)
        }
    }
}
