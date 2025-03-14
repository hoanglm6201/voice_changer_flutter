//
//  AudioPlayerViewModel.swift
//  New Sound Demo
//
//  Created by Hieu Vu on 23/8/24.
//

import Foundation
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var pitchControl: AVAudioUnitTimePitch!
    var distortion: AVAudioUnitDistortion!
    var reverb: AVAudioUnitReverb!
    var delay: AVAudioUnitDelay!
    var eq: AVAudioUnitEQ!

    init() {
        setupAudio()
    }

    func setupAudio() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        pitchControl = AVAudioUnitTimePitch()
        distortion = AVAudioUnitDistortion()
        reverb = AVAudioUnitReverb()
        delay = AVAudioUnitDelay()
        eq = AVAudioUnitEQ(numberOfBands: 3)
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(pitchControl)

        audioEngine.connect(audioPlayerNode, to: pitchControl, format: nil)
        audioEngine.connect(pitchControl, to: audioEngine.mainMixerNode, format: nil)
        print()
        guard let url = Bundle.main.url(forResource: "demovoice", withExtension: "m4a") else {
            print("Audio file not found demo voice")
            return
        }

        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Failed to load audio file: \(error)")
        }
    }
    func playAudioWithEffect(effect: Effects,fileName:String) {
        // Stop the audio player node if it's already playing
        
        audioPlayerNode.stop()
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(fileName).m4a") else {
            fatalError("Failed to construct the URL for the file.")
        }

        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Failed to load audio file: \(error)")
        }

        // Set the pitch and rate
        pitchControl.pitch = effect.pitch
        pitchControl.rate = effect.speed

        if effect.amplify > 0 || effect.distort.count > 0 {
            let echoNode = AVAudioUnitDistortion()
            if effect.distort.count > 0 {
                echoNode.loadFactoryPreset(effect.distortType)
                echoNode.wetDryMix = effect.distort[0]
            } else {
                echoNode.loadFactoryPreset(.multiCellphoneConcert)
            }
            
            if effect.amplify > 0 {
                echoNode.preGain = effect.amplify
            }
            audioEngine.attach(echoNode)
        }
        let newEcho = AVAudioUnitDelay()
        if effect.newEcho.count == 3 {
            newEcho.delayTime = TimeInterval(effect.newEcho[0])
            newEcho.feedback = effect.newEcho[1]
            newEcho.wetDryMix = effect.newEcho[2]
            audioEngine.attach(newEcho)
        }
        // Add the reverb node to the audio engine
        
        
        // Set the amplification (volume)
        if(effect.amplify > 0) {
            audioPlayerNode.volume = effect.amplify
        }
        var eqNode = AVAudioUnitEQ(numberOfBands: 1)
        if effect.eq2.count == 3, effect.eq2.count == 3 {
            eqNode = AVAudioUnitEQ(numberOfBands: 3)
        } else if effect.eq2.count == 3 || effect.eq2.count == 3 {
            eqNode = AVAudioUnitEQ(numberOfBands: 2)
        }
        
        if effect.eq1.count == 3 {
            if let filter = effect.filter {
                eqNode.bands[0].filterType = filter
            }
            eqNode.bands[0].frequency = effect.eq1[0]
            eqNode.bands[0].bandwidth = effect.eq1[1]
            eqNode.bands[0].gain = effect.eq1[2]
            
            if effect.eq2.count == 3 {
                if let filter = effect.filter {
                    eqNode.bands[1].filterType = filter
                }
                eqNode.bands[1].frequency = effect.eq2[0]
                eqNode.bands[1].bandwidth = effect.eq2[1]
                eqNode.bands[1].gain = effect.eq2[2]
            }
            
            if effect.eq3.count == 3 {
                if let filter = effect.filter {
                    eqNode.bands[2].filterType = filter
                }
                eqNode.bands[2].frequency = effect.eq3[0]
                eqNode.bands[2].bandwidth = effect.eq3[1]
                eqNode.bands[2].gain = effect.eq3[2]
            }
            audioEngine.attach(eqNode)
        }
        
        // Schedule the audio file to be played
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)

        // Start the audio engine and play the audio
        do {
            try audioEngine.start()
            audioPlayerNode.play()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    func playAudioWithEffect(effect: Effects) {
        // Stop the audio player node if it's already playing
        audioPlayerNode.stop()

        // Set the pitch and rate
        pitchControl.pitch = effect.pitch
        pitchControl.rate = effect.speed

        if effect.amplify > 0 || effect.distort.count > 0 {
            let echoNode = AVAudioUnitDistortion()
            if effect.distort.count > 0 {
                echoNode.loadFactoryPreset(effect.distortType)
                echoNode.wetDryMix = effect.distort[0]
            } else {
                echoNode.loadFactoryPreset(.multiCellphoneConcert)
            }
            
            if effect.amplify > 0 {
                echoNode.preGain = effect.amplify
            }
            audioEngine.attach(echoNode)
        }
        let newEcho = AVAudioUnitDelay()
        if effect.newEcho.count == 3 {
            newEcho.delayTime = TimeInterval(effect.newEcho[0])
            newEcho.feedback = effect.newEcho[1]
            newEcho.wetDryMix = effect.newEcho[2]
            audioEngine.attach(newEcho)
        }
        // Add the reverb node to the audio engine
        
        
        // Set the amplification (volume)
        if(effect.amplify > 0) {
            audioPlayerNode.volume = effect.amplify
        }
        var eqNode = AVAudioUnitEQ(numberOfBands: 1)
        if effect.eq2.count == 3, effect.eq2.count == 3 {
            eqNode = AVAudioUnitEQ(numberOfBands: 3)
        } else if effect.eq2.count == 3 || effect.eq2.count == 3 {
            eqNode = AVAudioUnitEQ(numberOfBands: 2)
        }
        
        if effect.eq1.count == 3 {
            if let filter = effect.filter {
                eqNode.bands[0].filterType = filter
            }
            eqNode.bands[0].frequency = effect.eq1[0]
            eqNode.bands[0].bandwidth = effect.eq1[1]
            eqNode.bands[0].gain = effect.eq1[2]
            
            if effect.eq2.count == 3 {
                if let filter = effect.filter {
                    eqNode.bands[1].filterType = filter
                }
                eqNode.bands[1].frequency = effect.eq2[0]
                eqNode.bands[1].bandwidth = effect.eq2[1]
                eqNode.bands[1].gain = effect.eq2[2]
            }
            
            if effect.eq3.count == 3 {
                if let filter = effect.filter {
                    eqNode.bands[2].filterType = filter
                }
                eqNode.bands[2].frequency = effect.eq3[0]
                eqNode.bands[2].bandwidth = effect.eq3[1]
                eqNode.bands[2].gain = effect.eq3[2]
            }
            audioEngine.attach(eqNode)
        }
        
        // Schedule the audio file to be played
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)

        // Start the audio engine and play the audio
        do {
            try audioEngine.start()
            audioPlayerNode.play()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }


    func stopAudio() {
        audioPlayerNode.stop()
        audioEngine.stop()
    }
}
