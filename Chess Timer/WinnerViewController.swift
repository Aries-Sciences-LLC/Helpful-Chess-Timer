//
//  WinnerViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 5/29/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import UIKit
import GhostTypewriter
import AVFoundation
import SAConfettiView

class WinnerViewController: UIViewController {
    
    @IBOutlet weak var crown: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var winnerLBL: UILabel!
    @IBOutlet weak var winnerName: UILabel!
    var holder : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var confettiView : SAConfettiView = SAConfettiView()
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "WinnerSoundEffect", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        holder.frame.origin.x = 0
        holder.frame.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width)
        holder.layer.cornerRadius = holder.frame.size.width / 2
        holder.backgroundColor = winnerColor
        holder.center = self.view.center
        holder.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.insertSubview(holder, belowSubview: winnerLBL)
        
        crown.alpha = 0
        crown.center.x = self.view.center.x
        
        if nameOfWinner == "BLACK" {
            crown.image = UIImage(named: "black_crown")
            winnerLBL.textColor = UIColor.white
            winnerName.textColor = UIColor.black
        }
        
        winnerLBL.frame.origin = CGPoint(x: 0 - winnerLBL.frame.size.width, y: holder.frame.origin.y)
        winnerName.frame.origin = CGPoint(x: self.view.frame.size.width, y: winnerLBL.frame.origin.y + winnerLBL.frame.size.height)
        winnerName.text = nameOfWinner
        
        confettiView.frame = self.view.bounds
        confettiView.type = SAConfettiView.ConfettiType.Confetti
        confettiView.intensity = 1
        self.view.insertSubview(confettiView, belowSubview: backButton)
        
        backButton.backgroundColor = winnerColor
        backButton.alpha = 0
        backButton.addTarget(self, action: #selector(WinnerViewController.backToMainMenu(_:)), for: UIControlEvents.touchUpInside)
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
    }

    override func viewDidAppear(_ animated: Bool) {
        playSound()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.holder.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.holder.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.winnerLBL.frame.origin.x = 25
                    self.winnerName.frame.origin.x = -25
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.winnerLBL.frame.origin.x = 0
                        self.winnerName.frame.origin.x = 0
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            self.crown.alpha = 1
                        }, completion: { (finished: Bool) in
                            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                self.backButton.alpha = 1
                            }, completion: nil)
                        })
                    })
                })
            })
        })
        confettiView.startConfetti()
    }
    
    @objc func backToMainMenu(_ sender: UIButton!) {
        resetData()
        let transition : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
        transition.center = sender.center
        transition.layer.cornerRadius = transition.frame.size.width / 2
        transition.transform = CGAffineTransform(scaleX: 0, y: 0)
        transition.backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (188 / 255), alpha: 1)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            transition.transform = CGAffineTransform.identity
        }, completion: { (finished: Bool) in
            let transitiontwo : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
            transitiontwo.center = sender.center
            transitiontwo.layer.cornerRadius = transitiontwo.frame.size.width / 2
            transitiontwo.transform = CGAffineTransform(scaleX: 0, y: 0)
            transitiontwo.backgroundColor = UIColor.white
            self.view.addSubview(transitiontwo)
            UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                transitiontwo.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                let mainController = self.storyboard?.instantiateViewController(withIdentifier: "mainBoard") as! ViewController
                self.present(mainController, animated: false, completion: nil)
            })
        })
    }
}
