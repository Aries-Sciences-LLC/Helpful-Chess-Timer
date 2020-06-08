//
//  ViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 5/19/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import UIKit
import ChromaColorPicker

class ViewController: UIViewController, ChromaColorPickerDelegate {
    
    var timeFieldX : CGFloat = 0.0
    var colorOne : Bool = false
    var menu : [UIView] = []
    var playeronetimeisset : Bool = false
    var playertwotimeisset : Bool = false
    var blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    var playeronetimeframe : CGRect = CGRect()
    var playertwotimeframe : CGRect = CGRect()
    var error_popup_bg = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    var error_alert = UIView(frame: CGRect(x: 16, y: 0, width: 100, height: 200))
    var checker : UITapGestureRecognizer = UITapGestureRecognizer()
    
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var playeronelbl: UILabel!
    @IBOutlet weak var playeronecolor: UIView!
    @IBOutlet weak var playeronetime: UITextField!
    @IBOutlet weak var playertwolbl: UILabel!
    @IBOutlet weak var playertwocolor: UIView!
    @IBOutlet weak var playertwotime: UITextField!
    @IBOutlet weak var start: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.playeronetimeframe = self.playeronetime.frame
        self.playertwotimeframe = self.playertwotime.frame
        
        start.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 100)
        start.layer.cornerRadius = 20
        
        title_label.frame = CGRect(x: 16, y: 16 + 50, width: self.view.frame.size.width - 32, height: 100)
        title_label.alpha = 0
        
        playeronelbl.frame = CGRect(x: 16, y: 149 + 50, width: self.view.frame.size.width - 32, height: 50)
        playeronelbl.alpha = 0
        
        playertwolbl.frame = CGRect(x: 16, y: 379 + 50, width: self.view.frame.size.width - 32, height: 50)
        playertwolbl.alpha = 0
        
        playeronecolor.layer.cornerRadius = playeronecolor.frame.size.width / 2
        playertwocolor.layer.cornerRadius = playertwocolor.frame.size.width / 2
        
        playeronetime.layer.cornerRadius = 15
        playertwotime.layer.cornerRadius = 15
        timeFieldX = playeronetime.frame.origin.x
        playeronetime.frame.origin.x = self.view.frame.size.width
        playertwotime.frame.origin.x = self.view.frame.size.width
        
        playeronecolor.transform = CGAffineTransform(scaleX: 0, y: 0)
        playertwocolor.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        checker = UITapGestureRecognizer(target: self, action: #selector(self.removePopUp(_:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.4, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.title_label.alpha = 1
            self.title_label.frame.origin.y = 16
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.playeronelbl.alpha = 1
                self.playertwolbl.alpha = 1
                self.playeronelbl.frame.origin.y = 149
                self.playertwolbl.frame.origin.y = 379
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.playeronecolor.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self.playertwocolor.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.playeronecolor.transform = CGAffineTransform.identity
                        self.playertwocolor.transform = CGAffineTransform.identity
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: 0.45, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            self.playeronetime.frame.origin.x = self.timeFieldX - 15
                            self.playertwotime.frame.origin.x = self.timeFieldX - 15
                        }, completion: { (finished: Bool) in
                            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                self.playeronetime.frame.origin.x = self.timeFieldX
                                self.playertwotime.frame.origin.x = self.timeFieldX
                            }, completion: nil)
                        })
                    })
                })
            })
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first!.location(in: self.view)
        if playeronecolor.frame.contains(touchLocation) == true {
            self.colorOne = true
            menu.append(UIView(frame: CGRect(x: self.view.frame.size.width, y: self.view.frame.size.height, width: 300, height: 300)))
            menu[self.menu.count - 1].layer.cornerRadius = 20
            menu[self.menu.count - 1].backgroundColor = UIColor(red: (67 / 255), green: (73 / 255), blue: (81 / 255), alpha: 1)
            self.view.addSubview(menu[self.menu.count - 1])
            let colorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            colorPicker.delegate = self
            colorPicker.hexLabel.textColor = UIColor.white
            menu[self.menu.count - 1].addSubview(colorPicker)
            UIView.animate(withDuration: 0.6, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.menu[self.menu.count - 1].center = CGPoint(x: self.view.center.x - 75, y: self.view.center.y - 75)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.menu[self.menu.count - 1].center = self.view.center
                }, completion: nil)
            })
        } else if playertwocolor.frame.contains(touchLocation) == true {
            self.colorOne = false
            menu.append(UIView(frame: CGRect(x: self.view.frame.size.width, y: self.view.frame.size.height, width: 300, height: 300)))
            menu[self.menu.count - 1].layer.cornerRadius = 20
            menu[self.menu.count - 1].backgroundColor = UIColor(red: (67 / 255), green: (73 / 255), blue: (81 / 255), alpha: 1)
            self.view.addSubview(menu[self.menu.count - 1])
            let colorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            colorPicker.delegate = self
            colorPicker.hexLabel.textColor = UIColor.white
            menu[self.menu.count - 1].addSubview(colorPicker)
            UIView.animate(withDuration: 0.6, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.menu[self.menu.count - 1].center = CGPoint(x: self.view.center.x - 75, y: self.view.center.y - 75)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.menu[self.menu.count - 1].center = self.view.center
                }, completion: nil)
            })
        } else {
            self.playertwotime.endEditing(true)
            self.playeronetime.endEditing(true)
        }
    }
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        if self.colorOne == true {
            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.playeronecolor.backgroundColor = color
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.45, delay: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.menu[self.menu.count - 1].center = CGPoint(x: 450, y: 450)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.55, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.menu[self.menu.count - 1].frame.origin = CGPoint(x: 0 - self.menu[self.menu.count - 1].frame.size.width, y: 0 - self.menu[self.menu.count - 1].frame.size.height)
                    }, completion: { (finished: Bool) in
                        if self.playertwotimeisset == true && self.playeronetimeisset == true && self.playeronecolor.backgroundColor != UIColor.white && self.playertwocolor.backgroundColor != UIColor.white {
                            self.activateStartButton()
                        }
                    })
                })
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.playertwocolor.backgroundColor = color
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.45, delay: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.menu[self.menu.count - 1].center = CGPoint(x: 450, y: 450)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.55, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.menu[self.menu.count - 1].frame.origin = CGPoint(x: 0 - self.menu[self.menu.count - 1].frame.size.width, y: 0 - self.menu[self.menu.count - 1].frame.size.height)
                    }, completion: { (finished: Bool) in
                        if self.playertwotimeisset == true && self.playeronetimeisset == true && self.playeronecolor.backgroundColor != UIColor.white && self.playertwocolor.backgroundColor != UIColor.white {
                            self.activateStartButton()
                        }
                    })
                })
            })
        }
    }
    
    func activateStartButton() {
        print("activated start button")
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.start.frame.origin.y = self.view.frame.size.height - 100
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.start.frame.origin.y = self.view.frame.size.height - 75
            }, completion: nil)
        })
    }
    @IBAction func playeronetimeset(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in }, completion: { (finished: Bool) in
            let characrters : Array = Array(self.playeronetime.text!)
            if characrters.indices.contains(7) && characrters.indices.count == 8 {
                if characrters[2] == ":" && characrters[5] == ":" && characrters.indices.contains(7) {
                    for i in 0..<characrters.count {
                        if characrters[i] != characrters[2] || characrters[i] != characrters[5] {
                            if characrters[i] == "0" || characrters[i] == "1" || characrters[i] == "3" || characrters[i] == "4" || characrters[i] == "6" || characrters[i] == "7" || characrters[i] == "8" || characrters[i] == "9" || characrters[i] == "2" || characrters[i] == "5" {
                                self.playeronetimeisset = true
                                if self.playertwotimeisset == true && self.playeronetimeisset == true && self.playeronecolor.backgroundColor != UIColor.white && self.playertwocolor.backgroundColor != UIColor.white {
                                    self.activateStartButton()
                                }
                            } else {
                                self.playeronetimeisset = false
                                self.addErrorPopUp(message: "Whoops, that's not a valid time. Please try again")
                                self.playeronetime.text = ""
                                break
                            }
                        } else {
                            continue
                        }
                    }
                }
            } else {
                self.playeronetimeisset = false
                self.addErrorPopUp(message: "Whoops, that's not a valid time. Please try again")
                self.playeronetime.text = ""
            }
        })
    }
    @IBAction func playertwotimeset(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {}, completion: { (finished: Bool) in
            let characrters : Array = Array(self.playertwotime.text!)
            if characrters.indices.contains(7) && characrters.indices.count == 8 {
                if characrters[2] == ":" && characrters[5] == ":" && characrters.indices.contains(7) {
                    for i in 0..<characrters.count {
                        if characrters[i] != characrters[2] || characrters[i] != characrters[5] {
                            if characrters[i] == "0" || characrters[i] == "1" || characrters[i] == "3" || characrters[i] == "4" || characrters[i] == "6" || characrters[i] == "7" || characrters[i] == "8" || characrters[i] == "9" || characrters[i] == "2" || characrters[i] == "5" {
                                self.playeronetimeisset = true
                                if self.playertwotimeisset == true && self.playeronetimeisset == true && self.playeronecolor.backgroundColor != UIColor.white && self.playertwocolor.backgroundColor != UIColor.white {
                                    self.activateStartButton()
                                }
                            } else {
                                self.playeronetimeisset = false
                                self.addErrorPopUp(message: "Whoops, that's not a valid time. Please try again")
                                self.playertwotime.text = ""
                                break
                            }
                        } else {
                            continue
                        }
                    }
                }
            } else {
                self.playertwotimeisset = false
                self.addErrorPopUp(message: "Whoops, that's not a valid time. Please try again")
                self.playertwotime.text = ""
            }
        })
    }
    
    @IBAction func start(_ sender: Any) {
        colors = [playeronecolor.backgroundColor, playertwocolor.backgroundColor] as! [UIColor]
        times = [playeronetime.text, playertwotime.text] as! [String]
        dataPassed = true
        let transition : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
        transition.center = self.start.center
        transition.layer.cornerRadius = transition.frame.size.width / 2
        transition.transform = CGAffineTransform(scaleX: 0, y: 0)
        transition.backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (188 / 255), alpha: 1)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            transition.transform = CGAffineTransform.identity
        }, completion: { (finished: Bool) in
            let transitiontwo : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 19000, height: 19000))
            transitiontwo.center = self.start.center
            transitiontwo.layer.cornerRadius = transitiontwo.frame.size.width / 2
            transitiontwo.transform = CGAffineTransform(scaleX: 0, y: 0)
            transitiontwo.backgroundColor = UIColor.white
            self.view.addSubview(transitiontwo)
            UIView.animate(withDuration: 1.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                transitiontwo.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                let timerController = self.storyboard?.instantiateViewController(withIdentifier: "timerBoard") as! TimerViewController
                self.present(timerController, animated: false, completion: nil)
            })
        })
    }
    @IBAction func beginsetplayeronetime(_ sender: UITextField) {
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, belowSubview: sender)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.blurEffectView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            sender.frame = CGRect(x: 32, y: 100, width: self.view.frame.size.width - 64, height: 100)
        }, completion: nil)
    }
    @IBAction func beginplayertwotime(_ sender: UITextField) {
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, belowSubview: sender)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.blurEffectView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            sender.frame = CGRect(x: 32, y: 100, width: self.view.frame.size.width - 64, height: 100)
        }, completion: nil)
    }
    @IBAction func endplayeronetime(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.blurEffectView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            sender.frame = self.playeronetimeframe
        }, completion: nil)
    }
    @IBAction func endplayertwotime(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.blurEffectView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            sender.frame = self.playertwotimeframe
        }, completion: nil)
    }
    
    func addErrorPopUp(message: String) {
        error_popup_bg = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
        error_popup_bg.frame = self.view.bounds
        error_popup_bg.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        error_popup_bg.alpha = 0
        self.view.addSubview(error_popup_bg)
        error_alert = UIView(frame: CGRect(x: 16, y: 0, width: self.view.frame.size.width - 32, height: 200))
        error_alert.transform = CGAffineTransform(scaleX: 0, y: 0)
        error_alert.center = self.view.center
        error_alert.backgroundColor = UIColor(red: (244 / 255), green: (66 / 255), blue: (66 / 255), alpha: 1)
        self.view.addSubview(error_alert)
        error_alert.layer.cornerRadius = 25
        let error_message = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 48, height: 200))
        error_message.textColor = UIColor.white
        error_message.textAlignment = NSTextAlignment.center
        error_message.text = message
        error_message.font = UIFont(name: "VarelaRound-Regular", size: 25)
        error_message.numberOfLines = 3
        error_alert.addSubview(error_message)
        UIView.animate(withDuration: 0.6, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.error_popup_bg.alpha = 1
            self.error_alert.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (finished: Bool) in
            UIView.animate(withDuration: 0.6, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.error_alert.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                self.view.addGestureRecognizer(self.checker)
            })
        }
    }
    
    @objc func removePopUp(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.error_alert.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (finished: Bool) in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.error_alert.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.error_popup_bg.alpha = 0
            }, completion: { (finished: Bool) in
                self.view.removeGestureRecognizer(self.checker)
            })
        }
    }
}
