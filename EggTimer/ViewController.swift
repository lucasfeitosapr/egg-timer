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
    
    @IBOutlet weak var progressBar: UIProgressView!
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    let eggTime = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    @IBAction func hardnessCheck(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        print(eggTime[hardness]!)
        totalTime = eggTime[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime{
            
            secondsPassed += 1
            progressBar.setProgress(Float(secondsPassed)/Float(totalTime), animated: true)

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
