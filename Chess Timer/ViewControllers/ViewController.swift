//
//  ViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 5/19/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import UIKit
import AudioToolbox
import GoogleMobileAds

struct SavedKeys {
    static let durationKey = "DK"
    static let maxNumOfTapsKey = "MNOTK"
}

class ViewController: BaseViewController {
    
    @IBOutlet weak var blackBg: CTView!
    @IBOutlet weak var blackTitle: UILabel!
    @IBOutlet weak var blackTimer: UILabel!
    @IBOutlet weak var blackIndicator: UILabel!
    @IBOutlet weak var blackCounter: UILabel!
    
    @IBOutlet weak var whiteBg: CTView!
    @IBOutlet weak var whiteTitle: UILabel!
    @IBOutlet weak var whiteTimer: UILabel!
    @IBOutlet weak var whiteIndicator: UILabel!
    @IBOutlet weak var whiteCounter: UILabel!
    
    @IBOutlet weak var mainControl: UIButton!
    @IBOutlet weak var centerWhite: UIButton!
    @IBOutlet weak var restart: StackButton!
    @IBOutlet weak var pause: StackButton!
    @IBOutlet weak var settings: StackButton!
    @IBOutlet weak var palette: StackButton!
    
    @IBOutlet var startingWhiteSize: NSLayoutConstraint!
    @IBOutlet var startingBlackSize: NSLayoutConstraint!
    @IBOutlet var sizeControlWhite: NSLayoutConstraint!
    @IBOutlet var sizeControlBlack: NSLayoutConstraint!
    @IBOutlet var hideControlWhite: NSLayoutConstraint!
    @IBOutlet var hideControlBlack: NSLayoutConstraint!
    
    
    @IBOutlet var blackLeading: NSLayoutConstraint!
    @IBOutlet var blackTrailing: NSLayoutConstraint!
    @IBOutlet var whiteLeading: NSLayoutConstraint!
    @IBOutlet var whiteTrailing: NSLayoutConstraint!
    
    var intersitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        intersitial = createAndLoadInterstitial()
        
        Game.shared.delegate = self
        
        blackTitle.transform = CGAffineTransform(rotationAngle: .pi)
        blackTimer.transform = CGAffineTransform(rotationAngle: .pi)
        blackIndicator.transform = CGAffineTransform(rotationAngle: .pi)
        blackCounter.transform = CGAffineTransform(rotationAngle: .pi)
        
        if #available(iOS 14.0, *) {
            return
        }
        
//        palette.setImage(UIImage(systemName: "paintbrush.fill"), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        applyPalette()
        
        whiteIndicator.flash()
        blackIndicator.flash()
        
        blackBg.layer.insertSublayer(GradientsManager.shared.gradient(for: view.bounds, upon: traitCollection.userInterfaceStyle == .dark), at: 0)
        whiteBg.layer.insertSublayer(GradientsManager.shared.gradient(for: view.bounds, upon: traitCollection.userInterfaceStyle == .dark), at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SettingsViewController {
            destination.delegate = self
        }
    }
    
    @IBAction func switchPlayers(_ sender: Any) {
        whiteIndicator.removeAnimations()
        blackIndicator.removeAnimations()
        if let whiteIsPlaying = Game.shared.switchPlayers() {
            startingBlackSize.prioritize(false)
            startingWhiteSize.prioritize(false)
            sizeControlWhite.prioritize(whiteIsPlaying)
            sizeControlBlack.prioritize(!whiteIsPlaying)
            hideControlWhite.prioritize(!whiteIsPlaying)
            hideControlBlack.prioritize(whiteIsPlaying)
            animateConstraints()
            
            blackBg.alpha = [0.6, 1][whiteIsPlaying ? 0 : 1]
            whiteBg.alpha = [1, 0.6][whiteIsPlaying ? 0 : 1]
            
            let white = Int(Game.shared.whiteNumOfTaps)
            let black = Int(Game.shared.blackNumOfTaps)
            let max = Game.shared.maxNumOfTaps != .infinity ? "out of \(Game.shared.maxNumOfTaps)" : ""
            whiteCounter.text = "Moved \(white) time\(white > 1 ? "s" : "") \(max)"
            blackCounter.text = "Moved \(black) time\(black > 1 ? "s" : "") \(max)"
        }
    }
    
    @IBAction func restart(_ sender: Any) {
        if Game.shared.whiteNumOfTaps > 0 {
            Game.shared.paused = true
            
            let wasInWhitesRound = sizeControlWhite.isActive
            hideClocks()
            
            let ac = UIAlertController(
                title: "Restart",
                message: "Are you two sure?",
                preferredStyle: .alert
            )
            ac.addAction(
                UIAlertAction(
                    title: "Yep!",
                    style: .destructive,
                    handler: { [self] _ in
                        commenceRestart()
                    }
                )
            )
            ac.addAction(
                UIAlertAction(
                    title: "Nah, we're good!",
                    style: .cancel,
                    handler: { [self] _ in
                        cancelRestart(wasInWhitesRound)
                    }
                )
            )
            present(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        if Game.shared.whiteNumOfTaps > 0 {
            switch Game.shared.shouldBegin {
            case true:
                hideClocks()
                UIView.animate(withDuration: 0.3) {
                    self.centerWhite.alpha = 1
                }
                let image = UIImage(systemName: "play.fill")
                centerWhite.setImage(image, for: .normal)
                pause.setImage(image, for: .normal)
                Game.shared.paused = true
                mainControl.isEnabled = false
                presentInterstitial()
            case false:
                play(sender)
            }
        }
    }
    
    @IBAction func play(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.centerWhite.alpha = 0
        }
        let image = UIImage(systemName: "pause.fill")
        centerWhite.setImage(image, for: .normal)
        pause.setImage(image, for: .normal)
        Game.shared.paused = false
        undoHide()
        mainControl.isEnabled = true
    }
}

extension ViewController {
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-7352520433824678/4957132841")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func presentInterstitial() {
        if intersitial.isReady {
            intersitial.present(fromRootViewController: self)
        }
    }
    
    func applyPalette() {
        let palette = PaletteManager.shared.current
        
        blackBg.backgroundColor = palette.main.background?.color
        blackTimer.textColor = palette.main.title?.color
        blackIndicator.textColor = palette.main.subtitle?.color
        blackCounter.textColor = palette.main.subtitle?.color
        
        blackBg.backgroundColor = palette.secondary.background?.color
        blackTimer.textColor = palette.secondary.title?.color
        blackIndicator.textColor = palette.secondary.subtitle?.color
        blackCounter.textColor = palette.secondary.subtitle?.color
        
        restart.apply(palette: palette.buttons)
        pause.apply(palette: palette.buttons)
        settings.apply(palette: palette.buttons)
        self.palette.apply(palette: palette.buttons)
    }
    
    func hideClocks() {
        sizeControlWhite.prioritize(false)
        sizeControlBlack.prioritize(false)
        hideControlWhite.prioritize(true)
        hideControlBlack.prioritize(true)
        UIView.animate(withDuration: 0.3) {
            self.blackBg.alpha = 0.6
            self.whiteBg.alpha = 0.6
        }
        animateConstraints()
    }
    
    func undoHide() {
        let whiteInMove = Game.shared.white.isScheduled
        hideControlWhite.prioritize(!whiteInMove)
        hideControlBlack.prioritize(whiteInMove)
        sizeControlWhite.prioritize(whiteInMove)
        sizeControlBlack.prioritize(!whiteInMove)
        UIView.animate(withDuration: 0.3) {
            self.blackBg.alpha = !whiteInMove ? 1 : 0.6
            self.whiteBg.alpha = whiteInMove ? 1 : 0.6
        }
        animateConstraints()
    }
    
    func animateConstraints() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func commenceRestart() {
        hideControlWhite.prioritize(false)
        hideControlBlack.prioritize(false)
        startingBlackSize.prioritize(true)
        startingWhiteSize.prioritize(true)
        
        UIView.animate(withDuration: 0.3) {
            self.blackBg.alpha = 1
            self.whiteBg.alpha = 1
        }
        animateConstraints()
        
        whiteIndicator.flash()
        blackIndicator.flash()
        
        whiteCounter.text = "# of Moves"
        blackCounter.text = "# of Moves"
        
        Game.shared.restart()
        
        presentInterstitial()
    }
    
    func cancelRestart(_ wasInWhitesRound: Bool) {
        hideControlWhite.prioritize(!wasInWhitesRound)
        hideControlBlack.prioritize(wasInWhitesRound)
        sizeControlWhite.prioritize(wasInWhitesRound)
        sizeControlBlack.prioritize(!wasInWhitesRound)
        
        UIView.animate(withDuration: 0.3) {
            self.blackBg.alpha = 1
            self.whiteBg.alpha = 1
        }
        animateConstraints()
        
        Game.shared.paused = false
    }
}

extension ViewController: SettingsViewControllerDelegate {
    func set(new duration: Clock.Duration) {
        Game.shared.duration = duration
    }
    
    func set(new numOfTaps: Double) {
        Game.shared.maxNumOfTaps = numOfTaps
    }
    
    func shouldUpdateUI() {
        let max = Game.shared.maxNumOfTaps != .infinity ? "out of \(Game.shared.maxNumOfTaps)" : ""
        sizeControlBlack.prioritize(false)
        sizeControlWhite.prioritize(false)
        animateConstraints()
        whiteCounter.text = "Moved # of times \(max)"
        blackCounter.text = "Moved # of times \(max)"
        clockDidTick(clock: Game.shared.black, didExpire: nil)
        commenceRestart()
        whiteIndicator.alpha = 1
        blackIndicator.alpha = 1
        whiteIndicator.flash()
        blackIndicator.flash()
        presentInterstitial()
    }
}

extension ViewController: GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        intersitial = createAndLoadInterstitial()
    }
}

extension ViewController: GameDelegate {
    func clockDidTick(clock: Clock, didExpire: Game.Results?) {
        blackTimer.text = Game.shared.black.interval.string
        whiteTimer.text = Game.shared.white.interval.string
        
        guard let expired = didExpire else {
            return
        }
        
        AudioServicesPlaySystemSound(1520)
        hideClocks()
        
        let didRunOutOfTime = Game.shared.black.interval <= 0 || Game.shared.white.interval <= 0
        
        if expired.loser == .white {
            whiteBg.applyWarning()
        } else {
            blackBg.applyWarning()
        }
        
        sizeControlBlack.prioritize(false)
        sizeControlWhite.prioritize(false)
        hideControlWhite.prioritize(true)
        hideControlBlack.prioritize(true)
        animateConstraints()
        
        let ac = UIAlertController(
            title: "\(expired.winner) won by default!",
            message: "Looks like \(expired.loser) ran out of \(didRunOutOfTime ? "time" : "moves").",
            preferredStyle: .alert
        )
        ac.addAction(
            UIAlertAction(
                title: "Got it!",
                style: .default,
                handler: { [self] _ in
                    whiteBg.removeWarning()
                    blackBg.removeWarning()
                    
                    hideControlWhite.prioritize(false)
                    hideControlBlack.prioritize(false)
                    sizeControlWhite.prioritize(false)
                    sizeControlBlack.prioritize(false)
                    startingWhiteSize.prioritize(true)
                    startingBlackSize.prioritize(true)
                    animateConstraints()
                    
                    UIView.animate(withDuration: 0.3) {
                        self.blackBg.alpha = 1
                        self.whiteBg.alpha = 1
                    }
                    
                    whiteIndicator.flash()
                    blackIndicator.flash()
                    
                    whiteCounter.text = "# of Moves"
                    blackCounter.text = "# of Moves"
                    
                    pause(pause)
                    Game.shared.restart()
                }
            )
        )
        present(ac, animated: true, completion: nil)
    }
}
