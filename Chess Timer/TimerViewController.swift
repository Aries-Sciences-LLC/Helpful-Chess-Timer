//
//  TimerViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 5/20/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import Foundation
import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var playeroneview: UIView!
    @IBOutlet weak var playertwoview: UIView!
    
    var playertwotimer : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var playeronetimer : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var playeronelabel : UILabel = UILabel(frame: CGRect(x: 0, y: 15, width: 0, height: 75))
    var playertwolabel : UILabel = UILabel(frame: CGRect(x: 0, y: 15, width: 0, height: 75))
    
    var turn : String = "Player1"
    var switcher : Bool = false
    var winnerByDefault = "NOTHING!!"
    var playeronetime : Int = 0
    var playertwotime : Int = 0
    var playeroneinterval : Timer = Timer()
    var playertwointerval : Timer = Timer()
    var runplayeronetimer : Bool = true
    var runplayertwotimer : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if dataPassed == true {
            playeroneview.frame.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
            playertwoview.frame.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
            playeroneview.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            playertwoview.frame.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
            playeroneview.frame.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
            playeroneview.frame.origin.y = 0
            playertwoview.frame.origin.y = self.view.frame.size.height / 2
            playeroneview.frame.origin.x = self.view.frame.size.width
            playertwoview.frame.origin.x = 0 - playertwoview.frame.size.width
            playertwoview.layer.cornerRadius = 35
            playeroneview.layer.cornerRadius = 35
            playeroneview.backgroundColor = colors[0]
            playertwoview.backgroundColor = colors[1]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.playeroneview.frame.origin.x = -25
            self.playertwoview.frame.origin.x = 25
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.playeroneview.frame.origin.x = 0
                self.playertwoview.frame.origin.x = 0
            }, completion: { (finished: Bool) in
                self.playeronelabel = UILabel(frame: CGRect(x: 0, y: 15, width: self.view.frame.size.width, height: 75))
                self.playeronelabel.font = UIFont(name: "VarelaRound-Regular", size: 40)
                self.playeronelabel.backgroundColor = UIColor.clear
                self.playeronelabel.textAlignment = NSTextAlignment.center
                self.playeronelabel.textColor = UIColor.black
                self.playeronelabel.text = "White"
                self.playeronelabel.alpha = 0
                self.playeronelabel.frame.origin.y = 0 - self.playeronelabel.frame.size.height
                self.playertwolabel = UILabel(frame: CGRect(x: 0, y: 15, width: self.view.frame.size.width, height: 75))
                self.playertwolabel.font = UIFont(name: "VarelaRound-Regular", size: 40)
                self.playertwolabel.backgroundColor = UIColor.clear
                self.playertwolabel.textAlignment = NSTextAlignment.center
                self.playertwolabel.textColor = UIColor.black
                self.playertwolabel.text = "Black"
                self.playertwolabel.alpha = 0
                self.playertwolabel.frame.origin.y = 0 - self.playertwolabel.frame.size.height
                self.playeroneview.addSubview(self.playeronelabel)
                self.playertwoview.addSubview(self.playertwolabel)
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.playeronelabel.alpha = 1
                    self.playeronelabel.frame.origin.y = 15
                    self.playertwolabel.alpha = 1
                    self.playertwolabel.frame.origin.y = 15
                }, completion: { (finished: Bool) in
                    let starter : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
                    starter.center = self.view.center
                    starter.backgroundColor = UIColor.clear
                    starter.text = "3"
                    starter.textColor = UIColor.white
                    starter.textAlignment = NSTextAlignment.center
                    starter.font = UIFont(name: "VarelaRound-Regular", size: 80)
                    starter.frame.origin.y = 0 - starter.frame.size.height
                    self.view.addSubview(starter)
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.view.alpha = 0.5
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: 0.56, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            starter.center = self.view.center
                        }, completion: { (finished: Bool) in
                            UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                starter.center.y = self.view.center.y + 25
                            }, completion: { (finished: Bool) in
                                UIView.animate(withDuration: 0.56, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                    starter.frame.origin.y = self.view.frame.size.height
                                }, completion: { (finished: Bool) in
                                    starter.frame.origin.y = 0 - starter.frame.size.height
                                    starter.text = "2"
                                    UIView.animate(withDuration: 0.56, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                        starter.center = self.view.center
                                    }, completion: { (finished: Bool) in
                                        UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                            starter.center.y = self.view.center.y + 25
                                        }, completion: { (finished: Bool) in
                                            UIView.animate(withDuration: 0.56, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                                starter.frame.origin.y = self.view.frame.size.height
                                            }, completion: { (finished: Bool) in
                                                starter.frame.origin.y = 0 - starter.frame.size.height
                                                starter.text = "1"
                                                UIView.animate(withDuration: 0.56, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                                    starter.center = self.view.center
                                                }, completion: { (finished: Bool) in
                                                    UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                                        starter.center.y = self.view.center.y + 25
                                                    }, completion: { (finished: Bool) in
                                                        UIView.animate(withDuration: 0.56, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                                            starter.frame.origin.y = self.view.frame.size.height
                                                        }, completion: { (finished: Bool) in
                                                            self.playeronetimer = UILabel(frame: CGRect(x: 0, y: self.playeronelabel.frame.size.height, width: self.playeroneview.frame.size.width, height: self.playeroneview.frame.size.height - self.playeronelabel.frame.size.height))
                                                            self.playeronetimer.textAlignment = NSTextAlignment.center
                                                            self.playeronetimer.backgroundColor = UIColor.clear
                                                            self.playeronetimer.font = UIFont(name: "VarelaRound-Regular", size: 75)
                                                            self.playeronetimer.textColor = UIColor.white
                                                            self.playeronetimer.text = times[0]
                                                            self.playeronetimer.transform = CGAffineTransform(scaleX: 0, y: 0)
                                                            self.playeroneview.addSubview(self.playeronetimer)
                                                            self.playertwotimer = UILabel(frame: CGRect(x: 0, y: self.playeronelabel.frame.size.height, width: self.playertwoview.frame.size.width, height: self.playertwoview.frame.size.height - self.playertwolabel.frame.size.height))
                                                            self.playertwotimer.textAlignment = NSTextAlignment.center
                                                            self.playertwotimer.backgroundColor = UIColor.clear
                                                            self.playertwotimer.font = UIFont(name: "VarelaRound-Regular", size: 75)
                                                            self.playertwotimer.textColor = UIColor.white
                                                            self.playertwotimer.transform = CGAffineTransform(scaleX: 0, y: 0)
                                                            self.playertwotimer.text = times[1]
                                                            self.playertwoview.addSubview(self.playertwotimer)
                                                            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                                                self.view.alpha = 1
                                                                self.playeronetimer.transform = CGAffineTransform.identity
                                                                self.playertwotimer.transform = CGAffineTransform.identity
                                                            }, completion: { (finished: Bool) in
                                                                self.startTime()
                                                                self.switcher = true
                                                                self.bringButton()
                                                            })
                                                        })
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if switcher == true {
            if turn == "Player1" {
                turn = "Player2"
                self.startTime()
            } else if turn == "Player2" {
                turn = "Player1"
                self.startTime()
            }
        }
    }
    
    func startTime() {
        if turn == "Player1" {
            runplayeronetimer = true
            runplayertwotimer = false
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.playertwoview.backgroundColor = UIColor.gray
                self.playertwotimer.textColor = UIColor.lightGray
                self.playertwolabel.textColor = UIColor.darkGray
                self.playeroneview.backgroundColor = colors[0]
                self.playeronetimer.textColor = UIColor.white
                self.playeronelabel.textColor = UIColor.black
            }, completion: { (finished: Bool) in
                let the_times = Array(times[0])
                let hours = Int(String(the_times[0]) + String(the_times[1]))! * 3600
                let minutes = Int(String(the_times[3]) + String(the_times[4]))! * 60
                let time = hours + minutes + Int(String(the_times[6]) + String(the_times[7]))!
                self.playeronetime = time
                self.playeroneinterval = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.countPlayerOne), userInfo: nil, repeats: true)
            })
        } else if turn == "Player2" {
            runplayertwotimer = true
            runplayeronetimer = false
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.playeroneview.backgroundColor = UIColor.gray
                self.playeronetimer.textColor = UIColor.lightGray
                self.playeronelabel.textColor = UIColor.darkGray
                self.playertwoview.backgroundColor = colors[1]
                self.playertwotimer.textColor = UIColor.white
                self.playertwolabel.textColor = UIColor.black
            }, completion: { (finished: Bool) in
                let the_times = Array(times[1])
                let hours = Int(String(the_times[0]) + String(the_times[1]))! * 3600
                let minutes = Int(String(the_times[3]) + String(the_times[4]))! * 60
                let time = hours + minutes + Int(String(the_times[6]) + String(the_times[7]))!
                self.playertwotime = time
                self.playertwointerval = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.countPlayerTwo), userInfo: nil, repeats: true)
            })
        }
    }
    
    @objc func countPlayerOne() {
        if runplayeronetimer == true {
            playeronetime -= 1
            playeronetimer.text = timeString(time: TimeInterval(playeronetime))
            if playeronetime == 0 {
                playeronetimer.text = timeString(time: TimeInterval(playeronetime))
                self.playeroneinterval.invalidate()
                nameOfWinner = "BLACK"
                winnerColor = colors[1]
                let transition : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
                transition.center = self.view.center
                transition.layer.cornerRadius = transition.frame.size.width / 2
                transition.transform = CGAffineTransform(scaleX: 0, y: 0)
                transition.backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (188 / 255), alpha: 1)
                self.view.addSubview(transition)
                UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    transition.transform = CGAffineTransform.identity
                }, completion: { (finished: Bool) in
                    let transitiontwo : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
                    transitiontwo.center = self.view.center
                    transitiontwo.layer.cornerRadius = transitiontwo.frame.size.width / 2
                    transitiontwo.transform = CGAffineTransform(scaleX: 0, y: 0)
                    transitiontwo.backgroundColor = UIColor.white
                    self.view.addSubview(transitiontwo)
                    UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        transitiontwo.transform = CGAffineTransform.identity
                    }, completion: { (finished: Bool) in
                        let winnerController = self.storyboard?.instantiateViewController(withIdentifier: "winnerBoard") as! WinnerViewController
                        self.present(winnerController, animated: false, completion: nil)
                    })
                })
            }
        }
    }
    @objc func countPlayerTwo() {
        if runplayertwotimer == true {
            playertwotime -= 1
            playertwotimer.text = timeString(time: TimeInterval(playertwotime))
            if playertwotime == 0 {
                playertwotimer.text = timeString(time: TimeInterval(playertwotime))
                self.playertwointerval.invalidate()
                nameOfWinner = "White"
                winnerColor = colors[0]
                let transition : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
                transition.center = self.view.center
                transition.layer.cornerRadius = transition.frame.size.width / 2
                transition.transform = CGAffineTransform(scaleX: 0, y: 0)
                transition.backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (188 / 255), alpha: 1)
                self.view.addSubview(transition)
                UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    transition.transform = CGAffineTransform.identity
                }, completion: { (finished: Bool) in
                    let transitiontwo : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
                    transitiontwo.center = self.view.center
                    transitiontwo.layer.cornerRadius = transitiontwo.frame.size.width / 2
                    transitiontwo.transform = CGAffineTransform(scaleX: 0, y: 0)
                    transitiontwo.backgroundColor = UIColor.white
                    self.view.addSubview(transitiontwo)
                    UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        transitiontwo.transform = CGAffineTransform.identity
                    }, completion: { (finished: Bool) in
                        let winnerController = self.storyboard?.instantiateViewController(withIdentifier: "winnerBoard") as! WinnerViewController
                        self.present(winnerController, animated: false, completion: nil)
                    })
                })
            }
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func bringButton() {
        let exit : UIButton = UIButton(frame: CGRect(x: self.view.frame.size.width, y: 0, width: 50, height: 50))
        exit.center.y = self.view.center.y
        exit.setImage(UIImage(named: "exit"), for: UIControlState.normal)
        exit.layer.cornerRadius = exit.frame.size.width / 2
        exit.backgroundColor = UIColor(red: (255 / 255), green: (156 / 255), blue: (0 / 255), alpha: 1)
        exit.addTarget(self, action: #selector(TimerViewController.backToMainMenu(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(exit)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            exit.frame.origin.x = -5
            exit.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                exit.frame.origin.x = 0
                exit.transform = CGAffineTransform.identity
            }, completion: nil)
        })
    }
    
    @objc func backToMainMenu(_ sender: UIButton!) {
        resetData()
        runplayeronetimer = false
        runplayertwotimer = false
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
            transitiontwo.backgroundColor = UIColor.black
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
