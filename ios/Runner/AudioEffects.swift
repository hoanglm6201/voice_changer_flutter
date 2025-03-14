import Foundation
import AVFoundation

class Effects: Identifiable, Hashable {
    static func == (lhs: Effects, rhs: Effects) -> Bool {
        return lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
          hasher.combine(id)
      }
    var isNotUnlocked : Bool = false
    //MARK: Properties
    let id = UUID()
    var sound_id = 0
    var name: String = ""
    var speed: Float = 1 // 0.03..1..32   ---    -95...0...5000
    var pitch: Float = 0 // -2400..0..2400  --- -60...0...60
    var newEcho: [Float] = [] // (delaytime, feedback, wetDryMix)
    var newReverb: AVAudioUnitReverbPreset? = nil
    var amplify: Float = 0 // AVAudioUnitDistortion pregain (âm lượng khuếch đại). -80..-6..20 0..1..n
    var filter: AVAudioUnitEQFilterType? = nil // AVaudioEngineeq1
    var eq1: [Float] = [] // AVaudioEngineeq1 ([brand]. freq1uency, bandwid, again)
    var eq2: [Float] = []
    var eq3: [Float] = []
    var distort: [Float] = [] // AVAudioUnitDistortion (bóp méo)
    var distortType: AVAudioUnitDistortionPreset = .drumsBitBrush //AVAudioUnitDistortion
    var imageName: String = ""
    
    init(speed: Float = 1, pitch: Float = 0) {
        self.speed = speed
        self.pitch = pitch
    }
    
    static func listEffect() -> [Effects] {
        var effects: [Effects] = []
        
        let effect_no_sound = Effects()
        effect_no_sound.name = "No Effect"
        effect_no_sound.imageName = "ic_no_effect"
        effect_no_sound.pitch = 0
        effect_no_sound.speed = 1
        effect_no_sound.sound_id = 0

        let effect2 = Effects()
        effect2.name = "Robot"
        effect2.imageName = "ic_robot"
        effect2.pitch = 120
        effect2.speed = 1.03
        effect2.amplify = 0
        effect2.newEcho = [0.1, 0.1, 0.4]
        effect2.sound_id = 1

        let effect3 = Effects()
        effect3.name = "Cave"
        effect3.imageName = "ic_cave"
        effect3.pitch = 0
        effect3.speed = 1
        effect3.newReverb = .mediumChamber
        effect3.sound_id = 2
        
        let effect4 = Effects()
        effect4.name = "Monster"
        effect4.imageName = "ic_monster"
        effect4.pitch = -400
        effect4.speed = 0.85
        effect4.newReverb = .mediumRoom
        effect4.sound_id = 3
        
        let effect5 = Effects()
        effect5.name = "Nervous"
        effect5.imageName = "ic_nervous"
        effect5.pitch = 1
        effect5.speed = 1.3
        effect5.sound_id = 4
        
        let effect6 = Effects()
        effect6.name = "Drunk"
        effect6.imageName = "ic_drunk"
        effect6.pitch = -200
        effect6.speed = 0.81
        effect6.sound_id = 5
        
        let effect7 = Effects()
        effect7.name = "Squirrel"
        effect7.imageName = "ic_squirrel"
        effect7.pitch = 480
        effect7.speed = 1.06
        effect7.sound_id = 6
        
        let effect8 = Effects()
        effect8.name = "Child"
        effect8.imageName = "ic_child"
        effect8.pitch = 240
        effect8.speed = 1
        effect8.sound_id = 7
        
        let effect9 = Effects()
        effect9.name = "Death"
        effect9.imageName = "ic_death"
        effect9.pitch = -200
        effect9.speed = 0.85
        effect9.amplify = -2
        effect9.newReverb = .cathedral
        effect9.newEcho = [0.14, 0.14, 0.5]
        effect9.sound_id = 8
        
        let effect11 = Effects()
        effect11.name = "Grand Canyon"
        effect11.imageName = "ic_grand_canyon"
        effect11.pitch = 0
        effect11.speed = 0.77
        effect11.newEcho = [0.4, 0.4, 0.7]
        effect11.newReverb = .largeRoom2
        effect11.sound_id = 9
        
        let effect14 = Effects()
        effect14.name = "Telephone"
        effect14.imageName = "ic_telephone"
        effect14.pitch = -120
        effect14.speed = 0.98
        effect14.amplify = 0.5
        effect14.filter = .highPass
        effect14.eq1 = [1300, 15, 8]
        effect14.sound_id = 10
        
        let effect15 = Effects()
        effect15.name = "Underwater"
        effect15.imageName = "ic_underwater"
        effect15.pitch = 0
        effect15.speed = 1
        effect15.amplify = 0.5
        effect15.filter = .lowPass
        effect15.eq1 = [400, 15, 8]
        effect15.sound_id = 11
        
        let effect16 = Effects()
        effect16.name = "Extraterrestrial"
        effect16.imageName = "ic_extraterrestrial"
        effect16.pitch = 120
        effect16.speed = 0.79
        effect16.sound_id = 12
        
        let effect17 = Effects()
        effect17.name = "Factory"
        effect17.imageName = "ic_factory"
        effect17.pitch = 0
        effect17.speed = 1
        effect17.amplify = 2
        //effect17.chorus = [0.3, 0.5, 5]
        effect17.newEcho = [0.2, 0.3, 0.5]
        effect17.sound_id = 13
        
        
        let effect18 = Effects()
        effect18.name = "Villain"
        effect18.imageName = "ic_villain"
        effect18.pitch = -200
        effect18.speed = 0.85
        effect18.amplify = 3
        effect18.filter = .highPass
        effect18.sound_id = 14
        
        let effect19 = Effects()
        effect19.name = "Zombie"
        effect19.imageName = "ic_zombie"
        effect19.pitch = -240
        effect19.speed = 0.66
        //effect19.chorus = [1, 0.35, 0.5, 1, 10,10]
        effect19.newEcho = [0.35, 0.5, 0.1]
        effect19.sound_id = 15
        
        let effect20 = Effects()
        effect20.name = "Megaphone"
        effect20.imageName = "ic_megaphone"
        effect20.pitch = 0
        effect20.speed = 1
        effect20.amplify = 4
        effect20.eq1 = [125, 18, -10]
        effect20.eq2 = [400, 18, 15]
        effect20.eq3 = [400, 18, -10]
        effect20.distort = [0.3]
        effect20.distortType = .speechRadioTower
        effect20.sound_id = 16
        
        
        let effect21 = Effects()
        effect21.name = "Alien"
        effect21.imageName = "ic_alien"
        effect21.pitch = 160
        effect21.speed = 0.9
        //effect21.chorus = [0.18, 0.75, 75]
        effect21.newEcho = [0.18, 0.75, 0.75]
        effect21.sound_id = 17
        
        let effect22 = Effects()
        effect22.name = "Small Alien"
        effect22.imageName = "ic_small_alien"
        effect22.pitch = 320
        effect22.speed = 1.03
        //effect22.chorus = [0.18, 0.75, 75]
        effect22.newEcho = [0.18, 0.76, 0.75]
        effect22.sound_id = 18
        
        let effect23 = Effects()
        effect23.name = "StormWind"
        effect23.imageName = "ic_storm_wind"
        effect23.pitch = 40
        effect23.speed = 1.3
        effect23.amplify = 5
        //effect23.chorus = [0.2, 0.75, 1.5]
        effect23.newEcho = [0.2, 0.75, 1]
        effect23.sound_id = 19
        
        let effect24 = Effects()
        effect24.name = "Motorcycle"
        effect24.imageName = "ic_motorcycle"
        effect24.pitch = -40
        effect24.speed = 1
        effect24.newEcho = [0.1, 0.1, 0.3]
        effect24.sound_id = 20
        //effect24.chorus = [0.6, 0.75, 60]

        
        let effect27 = Effects()
        effect27.name = "Parody"
        effect27.imageName = "ic_parody"
        effect27.pitch = 0
        effect27.speed = 1
        //effect27.chorus = [0.2, 0.75, 300]
        effect27.newEcho = [0.2, 0.75, 1]
        effect27.sound_id = 21
        
        let effect29 = Effects()
        effect29.name = "Basso Singer"
        effect29.imageName = "ic_basso_singer"
        effect29.pitch = -160
        effect29.speed = 1
        effect29.eq1 = [125, 18, 15]
        effect29.eq2 = [400, 18, -10]
        effect29.eq3 = [4000, 18, -10]
        effect29.newReverb = .cathedral
        effect29.sound_id = 22

        
        let effect31 = Effects()
        effect31.name = "Mr Panic"
        effect31.imageName = "ic_mr_panic"
        effect31.pitch = 120
        effect31.speed = 1.18
        effect31.eq1 = [125, 18, -10]
        effect31.eq2 = [400, 18, 15]
        effect31.eq3 = [4000, 18, -10]
        //effect31.phaser = [1, -0.2, 54]
        effect31.newReverb = .mediumHall2
        effect31.sound_id = 23

        let effect32 = Effects()
        effect32.name = "Ghost"
        effect32.imageName = "ic_ghost"
        effect32.pitch = -200
        effect32.speed = 1.3
       // effect32.chorus = [0.14, 0.6, 225]
        effect32.newEcho = [0.14, 0.14, 0.3] //0...1...2 -- 0...500...20000
        effect32.newReverb = .largeHall2
        effect32.sound_id = 24
        
        let effect33 = Effects()
        effect33.name = "Girl"
        effect33.imageName = "ic_girl"
        effect33.pitch = 400
        effect33.speed = 1.01
        effect33.sound_id = 25
        
        let effect34 = Effects()
        effect34.name = "Man"
        effect34.imageName = "ic_man"
        effect34.pitch = -400
        effect34.speed = 1.01
        effect34.sound_id = 26
        
        // NEW UPDATE SOUNDS VER 1.1.2
        let effect35 = Effects()
        effect35.name = "Baby Girl"
        effect35.imageName = "newsound_35"
        effect35.pitch = 1.0
        effect35.speed = 1.0
        effect35.sound_id = 35
        effect35.newReverb = .largeRoom
        effect35.distortType = .drumsBitBrush
        effect35.filter = .bandPass
        
        let effect36 = Effects()
        effect36.name = "Boy"
        effect36.imageName = "newsound_36"
        effect36.pitch = 2.0
        effect36.speed = 2.0
        effect36.sound_id = 36
        effect36.newEcho = [1.0,1.0,1.0]
        effect36.newReverb = .smallRoom
        effect36.distortType = .drumsBitBrush
        effect36.filter = .bandPass
        
        let effect37 = Effects()
        effect37.name = "Bunny girl"
        effect37.imageName = "newsound_37"
        effect37.pitch = 1.40
        effect37.speed = 1.32
        effect37.sound_id = 37
        effect37.newEcho = [1.0,1.0,1.0]
        effect37.newReverb = .smallRoom
        effect37.distortType = .multiDistortedCubed
        effect37.filter = .bandPass
        
        let effect38 = Effects()
        effect38.name = "Cassette Tape"
        effect38.imageName = "newsound_38"
        effect38.pitch = 1.40
        effect38.speed = 1.32
        effect38.sound_id = 38
        effect38.newEcho = [0.43,0.68,0.78]
        effect38.newReverb = .mediumRoom
        effect38.distortType = .multiCellphoneConcert
        effect38.filter = .bandPass
        
        let effect39 = Effects()
        effect39.name = "Monster 2"
        effect39.imageName = "newsound_39"
        effect39.pitch = 1.46
        effect39.speed = 1.03
        effect39.sound_id = 38
        effect39.newEcho = [0.46,0.54,0.54]
        effect39.newReverb = .mediumRoom
        effect39.distortType = .drumsLoFi
        effect39.filter = .bandPass
        
        let effect40 = Effects()
        effect40.name = "Maiden"
        effect40.imageName = "newsound_40"
        effect40.pitch = 1.46
        effect40.speed = 1.03
        effect40.sound_id = 38
        effect40.newEcho = [0.46,0.54,0.54]
        effect40.newReverb = .mediumRoom
        effect40.distortType = .drumsLoFi
        effect40.filter = .bandPass
        
        let effect41 = Effects()
        effect41.name = "Love Robot"
        effect41.imageName = "newsound_41"
        effect41.pitch = 1.66
        effect41.speed = 0.70
        effect41.sound_id = 38
        effect41.newEcho = [0.23,0.37,0.17]
        effect41.newReverb = .mediumChamber
        effect41.distortType = .drumsLoFi
        effect41.filter = .bandPass
        
        let effect42 = Effects()
        effect42.name = "Loudspeaker"
        effect42.imageName = "newsound_42"
        effect42.pitch = 1.66
        effect42.speed = 0.70
        effect42.sound_id = 38
        effect42.newEcho = [0.23,0.37,0.17]
        effect42.newReverb = .cathedral
        effect42.distortType = .drumsLoFi
        effect42.filter = .bandPass
        
        let effect43 = Effects()
        effect43.name = "Joker"
        effect43.imageName = "newsound_43"
        effect43.pitch = 1.66
        effect43.speed = 0.70
        effect43.sound_id = 38
        effect43.newEcho = [0.23,0.37,0.17]
        effect43.newReverb = .largeHall2
        effect43.distortType = .drumsLoFi
        effect43.filter = .bandPass
        
        
        let effect44 = Effects()
        effect44.name = "Baby Boy"
        effect44.imageName = "newsound_44"
        effect44.pitch = 1.66
        effect44.speed = 1.01
        effect44.sound_id = 38
        effect44.newEcho = [0.82,0.82,0.75]
        effect44.newReverb = .largeHall2
        effect44.distortType = .speechRadioTower
        effect44.filter = .bandPass
        
        let effect45 = Effects()
        effect45.name = "Horror"
        effect45.imageName = "newsound_45"
        effect45.pitch = 1.66
        effect45.speed = 1.01
        effect45.sound_id = 38
        effect45.newEcho = [0.82,0.82,0.75]
        effect45.newReverb = .largeHall2
        effect45.distortType = .speechRadioTower
        effect45.filter = .bandPass
        
        let effect46 = Effects()
        effect46.name = "Cute Ghost"
        effect46.imageName = "newsound_46"
        effect46.pitch = 1.66
        effect46.speed = 1.01
        effect46.sound_id = 38
        effect46.newEcho = [0.82,0.82,0.75]
        effect46.newReverb = .largeHall2
        effect46.distortType = .speechRadioTower
        effect46.filter = .bandPass
        
        let effect47 = Effects()
        effect47.name = "Freak"
        effect47.imageName = "newsound_47"
        effect47.pitch = 1.66
        effect47.speed = 1.77
        effect47.sound_id = 38
        effect47.newEcho = [0.82,0.82,0.75]
        effect47.newReverb = .smallRoom
        effect47.distortType = .drumsBitBrush
        effect47.filter = .bandPass
        
        
        let effect48 = Effects()
        effect48.name = "Fighting Robot"
        effect48.imageName = "newsound_48"
        effect48.pitch = 1.66
        effect48.speed = 1.77
        effect48.sound_id = 38
        effect48.newEcho = [0.82,0.82,0.75]
        effect48.newReverb = .smallRoom
        effect48.distortType = .drumsLoFi
        effect48.filter = .bandPass
        
        let effect49 = Effects()
        effect49.name = "Elf"
        effect49.imageName = "newsound_49"
        effect49.pitch = 1.66
        effect49.speed = 1.77
        effect49.sound_id = 38
        effect49.newEcho = [0.82,0.82,0.75]
        effect49.newReverb = .smallRoom
        effect49.distortType = .drumsLoFi
        effect49.filter = .bandPass
        
        let effect50 = Effects()
        effect50.name = "Duck"
        effect50.imageName = "newsound_50"
        effect50.pitch = 1.66
        effect50.speed = 1.77
        effect50.sound_id = 38
        effect50.newEcho = [0.82,0.82,0.75]
        effect50.newReverb = .plate
        effect50.distortType = .drumsLoFi
        effect50.filter = .bandPass
        
        let effect51 = Effects()
        effect51.name = "Drunkard"
        effect51.imageName = "newsound_51"
        effect51.pitch = 1.66
        effect51.speed = 1.77
        effect51.sound_id = 38
        effect51.newEcho = [0.82,0.82,0.70]
        effect51.newReverb = .plate
        effect51.distortType = .drumsBufferBeats
        effect51.filter = .bandPass
        
        let effect52 = Effects()
        effect52.name = "Drinker"
        effect52.imageName = "newsound_52"
        effect52.pitch = 1.66
        effect52.speed = 0.9
        effect52.sound_id = 38
        effect52.newEcho = [0.82,0.82,0.70]
        effect52.newReverb = .plate
        effect52.distortType = .drumsBufferBeats
        effect52.filter = .bandPass
        
        let effect53 = Effects()
        effect53.name = "Cute"
        effect53.imageName = "newsound_53"
        effect53.pitch = 1.66
        effect53.speed = 0.9
        effect53.sound_id = 38
        effect53.newEcho = [0.29,0.24,0.37]
        effect53.newReverb = .plate
        effect53.filter = .bandPass
        
        let effect54 = Effects()
        effect54.name = "Cute Robot"
        effect54.imageName = "newsound_54"
        effect54.pitch = 1.66
        effect54.speed = 1.24
        effect54.sound_id = 38
        effect54.newEcho = [0.7,0.4,0.7]
        effect54.newReverb = .plate
        effect54.distortType = .multiCellphoneConcert
        effect54.filter = .bandPass
        
        let effect55 = Effects()
        effect55.name = "Santa Claus"
        effect55.imageName = "newsound_55"
        effect55.pitch = 1.29
        effect55.speed = 0.5
        effect55.sound_id = 38
        effect55.newEcho = [0.2,0.2,0.2]
        effect55.newReverb = .plate
        effect55.distortType = .multiDistortedCubed
        effect55.filter = .bandPass
        
        let effect56 = Effects()
        effect56.name = "Old Man"
        effect56.imageName = "newsound_56"
        effect56.pitch = 1.29
        effect56.speed = 0.5
        effect56.sound_id = 38
        effect56.newEcho = [0.2,0.2,0.2]
        effect56.newReverb = .plate
        effect56.distortType = .multiDistortedFunk
        effect56.filter = .bandPass
        
        let effect57 = Effects()
        effect57.name = "Old Woman"
        effect57.imageName = "newsound_57"
        effect57.pitch = 1.29
        effect57.speed = 0.5
        effect57.sound_id = 38
        effect57.newEcho = [0.2,0.2,0.2]
        effect57.newReverb = .plate
        effect57.distortType = .multiDistortedSquared
        effect57.filter = .bandPass
        
        let effect58 = Effects()
        effect58.name = "Radio"
        effect58.imageName = "newsound_58"
        effect58.pitch = 1.29
        effect58.speed = 0.5
        effect58.sound_id = 38
        effect58.newEcho = [0.2,0.2,0.2]
        effect58.newReverb = .plate
        effect58.distortType = .speechGoldenPi
        effect58.filter = .bandPass
        
        let effect59 = Effects()
        effect59.name = "Radio 2"
        effect59.imageName = "newsound_59"
        effect59.pitch = 1.54
        effect59.speed = 0.63
        effect59.sound_id = 38
        effect59.newEcho = [0.25,0.35,0.2]
        effect59.newReverb = .plate
        effect59.distortType = .drumsLoFi
        effect59.filter = .bandPass
        
        let effect60 = Effects()
        effect60.name = "Caucasian"
        effect60.imageName = "newsound_60"
        effect60.pitch = 1.55
        effect60.speed = 0.66
        effect60.sound_id = 38
        effect60.newEcho = [0.25,0.35,0.3]
        effect60.newReverb = .plate
        effect60.distortType = .multiEverythingIsBroken
        effect60.filter = .resonantLowShelf
        
        let effect61 = Effects()
        effect61.name = "Santa Clause"
        effect61.imageName = "newsound_61"
        effect61.pitch = 1.54
        effect61.speed = 0.6
        effect61.sound_id = 38
        effect61.newEcho = [0.25,0.3,0.33]
        effect61.newReverb = .plate
        effect61.distortType = .multiEverythingIsBroken
        effect61.filter = .lowShelf
        
        
        let effect62 = Effects()
        effect62.name = "Ghost 2"
        effect62.imageName = "newsound_62"
        effect62.pitch = 1.54
        effect62.speed = 0.65
        effect62.sound_id = 38
        effect62.newEcho = [0.25,0.3,0.33]
        effect62.newReverb = .plate
        effect62.distortType = .multiDecimated4
        effect62.filter = .resonantHighPass
      
        let effect63 = Effects()
        effect63.name = "Well"
        effect63.imageName = "newsound_63"
        effect63.pitch = 1.54
        effect63.speed = 0.65
        effect63.sound_id = 38
        effect63.newEcho = [0.25,0.3,0.33]
        effect63.newReverb = .plate
        effect63.distortType = .speechCosmicInterference
        effect63.filter = .resonantHighPass
        
        
        
        let effect65 = Effects()
        effect65.name = "Shadow"
        effect65.imageName = "newsound_65"
        effect65.pitch = 1.54
        effect65.speed = 0.65
        effect65.sound_id = 38
        effect65.newEcho = [0.25,0.3,0.53]
        effect65.newReverb = .plate
        effect65.distortType = .multiDecimated2
        effect65.filter = .resonantHighShelf
        
       
        
        
        effects = [effect_no_sound,effect2, effect3, effect4, effect5, effect6, effect7, effect33, effect8, effect9, effect11, effect34, effect14, effect15, effect16, effect17, effect18, effect19, effect20, effect21, effect22, effect23, effect24, effect27, effect29, effect31, effect32, effect35, effect36,effect37,effect38,effect39,effect53,effect62,effect57,effect60,effect40,effect41,effect50,effect42,effect51,effect43,effect55,effect44,effect58,effect46,effect47,effect59,effect48,effect49,effect52,effect54,effect56,effect61,effect63,effect65,effect45]
        return effects
    }
}



