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
    
    @IBOutlet weak var titleLabel: UILabel!
        
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    var totalTime:Float = 0
    var secondsPassed:Float = 0
 
    var timer = Timer()
    
    var player: AVAudioPlayer?

    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
                        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = Float(eggTimes[hardness]!)
        
        progress.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
    }
        
    @objc func countdownTimer() {
        
        if secondsPassed <= totalTime {
            
            let percentageProgress = secondsPassed/totalTime
            
            progress.progress = percentageProgress
           
            secondsPassed = secondsPassed + 1
           
        }
        else {

            titleLabel.text = "DONE!"
            
            playSound()
                
            }
        }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    }
    


