//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var countdown = 0.0;
    var timer = Timer()
    var player: AVAudioPlayer!
    
    let eggTime = ["Soft": 2, "Medium": 420.0, "Hard": 720.0]
    
    @IBAction func hardnessCheck(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        print(eggTime[hardness]!)
        countdown = eggTime[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        if countdown > 0{
            print("\(countdown) second(s) remaining")
            countdown -= 1
        } else {
            playSound(withCurrentNote: Constants.Sounds.alarm.rawValue)
            timer.invalidate()
        }
    }
    
    func playSound(withCurrentNote: String) {
        let url = Bundle.main.url(forResource: withCurrentNote, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}

enum Constants {
    enum Sounds: String {
        case alarm = "alarm_sound";
    }
}
