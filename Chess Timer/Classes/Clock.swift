//
//  Clock.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import Foundation

protocol ClockDelegate {
    func crossedInterval(for clock: Clock)
}

class Clock {
    
    enum Duration: Double {
        typealias RawValue = Double
        
        case five = 5.0
        case ten = 10.0
        case thirty = 30.0
        case sixty = 60.0
        case hundredtwenty = 120.0
        case threehundred = 300.0
        
        var key: String {
            get {
                switch self {
                case .five:
                    return "5 mins"
                case .ten:
                    return "10 mins"
                case .thirty:
                    return "30 mins"
                case .sixty:
                    return "1 hr"
                case .hundredtwenty:
                    return "2 hrs"
                case .threehundred:
                    return "5 hrs"
                }
            }
        }
    }
    
    private var timer: Timer!
    private var secondsPassed: Int
    
    public var paused: Bool
    public var duration: Duration
    public var delegate: ClockDelegate?
    
    public var interval: TimeInterval {
        return (duration.rawValue * 60) - Double(secondsPassed / 2 )
    }
    
    public var didPassDuration: Bool {
        return Double(secondsPassed / 2) >= (duration.rawValue * 60)
    }
    
    public var isScheduled: Bool {
        return timer != nil && timer.isValid
    }
    
    init() {
        paused = false
        secondsPassed = 1
        duration = .thirty
    }
    
    convenience init(duration: Duration) {
        self.init()
        self.duration = duration
    }
    
    func start() {
        paused = false
        delegate?.crossedInterval(for: self)
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [self] time in
            secondsPassed += 1
            delegate?.crossedInterval(for: self)
        })
    }
    
    func cancel() {
        if timer != nil {
            if timer.isValid {
                timer.invalidate()
            }
        }
    }
    
    func restart() {
        cancel()
        secondsPassed = 0
    }
    
    func pause() {
        cancel()
        paused = true
    }
}
