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
    
    
    @IBOutlet weak var timerCount: UIProgressView!
    
    @IBOutlet weak var countTitle: UILabel!
    
    let eggTimes:[String:Float] = ["Soft" : 5 ,"Medium" : 10 , "Hard" : 12 ]
    
    var timer = Timer()
     
    var totalTime:Float = 1
    var secondsPassed:Float = 0
    
    var player: AVAudioPlayer?
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
    
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        timerCount.progress = 0.0
        secondsPassed = 0
        countTitle.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
        
        }
    @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            
            let pastTime = secondsPassed / totalTime
            print(pastTime)
            timerCount.progress = Float(pastTime)
            
            
            
            
        }else {
            timer.invalidate()
            self.countTitle.text = "Egg's is ready"
            playSound()
        }
    }
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
   
}
