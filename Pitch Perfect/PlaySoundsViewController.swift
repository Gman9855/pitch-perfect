//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gershy Lev on 4/7/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController     {
    
    var player:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        player.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func snailButtonTapped(sender: UIButton) {
        stopAndResetAudioEngine()
        playAudioWithRate(0.5)
    }
    
    
    @IBAction func rabbitButtonTapped(sender: UIButton) {
        stopAndResetAudioEngine()
        playAudioWithRate(2.0)
    }
    
    @IBAction func chipmunkButtonTapped(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderButtonTapped(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        if player.playing {
            player.stop()
        }
        if audioEngine.running {
            audioEngine.stop()
        }
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        player.stop()
        stopAndResetAudioEngine()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func playAudioWithRate(rate: Float) {
        player.stop()
        player.rate = rate
        player.currentTime = 0.0
        player.play()
    }
    
    func stopAndResetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }

}
