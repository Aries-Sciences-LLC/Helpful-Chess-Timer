//
//  Game.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/4/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import Foundation

protocol GameDelegate {
    func clockDidTick(clock: Clock, didExpire: Game.Results?)
}

class Game {
    static let shared = Game()
    
    struct Results {
        var winner: Player
        var loser: Player
    }
    
    enum Player {
        case black, white
    }
    
    var shouldBegin: Bool
    var white: Clock
    var black: Clock
    
    var maxNumOfTaps: Double
    var blackNumOfTaps: Double
    var whiteNumOfTaps: Double
    
    var delegate: GameDelegate?
    
    var duration: Clock.Duration {
        set {
            white = Clock(duration: newValue)
            black = Clock(duration: newValue)
            white.delegate = self
            black.delegate = self
        } get {
            return white.duration
        }
    }
    
    var didExpire: Results? {
        if black.didPassDuration || blackNumOfTaps > maxNumOfTaps {
            black.cancel()
            return Results(winner: .white, loser: .black)
        }
        if white.didPassDuration || whiteNumOfTaps > maxNumOfTaps {
            white.cancel()
            return Results(winner: .black, loser: .white)
        }
        return nil
    }
    
    var paused: Bool {
        get {
            return white.isScheduled || black.isScheduled
        } set {
            shouldBegin = !newValue
            switch newValue {
            case true:
                if white.isScheduled {
                    white.pause()
                }
                if black.isScheduled {
                    black.pause()
                }
            case false:
                if white.paused {
                    white.start()
                }
                if black.paused {
                    black.start()
                }
            }
        }
    }
    
    init() {
        shouldBegin = true
        white = Clock()
        black = Clock()
        
        maxNumOfTaps = .infinity
        blackNumOfTaps = 0
        whiteNumOfTaps = 0
        
        white.delegate = self
        black.delegate = self
    }
    
    func switchPlayers() -> Bool? {
        if shouldBegin {
            let index = white.isScheduled ? 0.0 : 1.0
            
            blackNumOfTaps += 1 - index
            whiteNumOfTaps += index
            
            black.cancel()
            white.cancel()
            
            [black, white][Int(index)].start()
            
            return index == 1.0
        }
        
        return nil
    }
    
    func restart() {
        let prevDuration = duration
        
        shouldBegin = true
        white = Clock(duration: prevDuration)
        black = Clock(duration: prevDuration)
        
        blackNumOfTaps = 0
        whiteNumOfTaps = 0
        
        white.delegate = self
        black.delegate = self
        
        delegate?.clockDidTick(clock: white, didExpire: nil)
    }
}

extension Game: ClockDelegate {
    func crossedInterval(for clock: Clock) {
        guard let delegate = delegate else {
            return
        }
        
        delegate.clockDidTick(clock: clock, didExpire: didExpire)
    }
}
