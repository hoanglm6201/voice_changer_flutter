import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  var audioPlayerVM = AudioPlayerViewModel()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      let controller = window?.rootViewController as! FlutterViewController
              let audioChannel = FlutterMethodChannel(name: "audio_effects",
                                                     binaryMessenger: controller.binaryMessenger)
              
              audioChannel.setMethodCallHandler { [weak self] (call, result) in
                  guard let self = self else { return }
                  if call.method == "playAudioWithEffect" {
                      if let args = call.arguments as? [String: Any] {
                          let effect = Effects()
                          effect.pitch = args["pitch"] as? Float ?? 0
                          effect.speed = args["speed"] as? Float ?? 1
                          effect.amplify = args["amplify"] as? Float ?? 0
                          effect.distort = args["distort"] as? [Float] ?? []
                          effect.eq1 = args["eq1"] as? [Float] ?? []
                          effect.eq2 = args["eq2"] as? [Float] ?? []
                          effect.eq3 = args["eq3"] as? [Float] ?? []
                          effect.newEcho = args["newEcho"] as? [Float] ?? []
                          effect.sound_id = args["sound_id"] as? Int ?? 0
                          effect.name = args["name"] as? String ?? ""
                          effect.imageName = args["imageName"] as? String ?? ""

                          // Nhận loại reverb từ Flutter và map sang enum AVAudioUnitReverbPreset
                          if let reverbName = args["newReverb"] as? String {
                              switch reverbName {
                              case "smallRoom": effect.newReverb = .smallRoom
                              case "mediumRoom": effect.newReverb = .mediumRoom
                              case "largeRoom": effect.newReverb = .largeRoom
                              case "mediumHall": effect.newReverb = .mediumHall
                              case "largeHall": effect.newReverb = .largeHall
                              case "plate": effect.newReverb = .plate
                              case "mediumChamber": effect.newReverb = .mediumChamber
                              case "largeChamber": effect.newReverb = .largeChamber
                              case "cathedral": effect.newReverb = .cathedral
                              case "largeRoom2": effect.newReverb = .largeRoom2
                              case "mediumHall2": effect.newReverb = .mediumHall2
                              case "mediumHall3": effect.newReverb = .mediumHall3
                              case "largeHall2": effect.newReverb = .largeHall2
                              default: effect.newReverb = nil
                              }
                          }

                          // Nhận loại filter từ Flutter và map sang enum AVAudioUnitEQFilterType
                          if let filterName = args["filter"] as? String {
                              switch filterName {
                              case "lowPass": effect.filter = .lowPass
                              case "highPass": effect.filter = .highPass
                              case "resonantLowPass": effect.filter = .resonantLowPass
                              case "resonantHighPass": effect.filter = .resonantHighPass
                              case "bandPass": effect.filter = .bandPass
                              case "bandStop": effect.filter = .bandStop
                              case "lowShelf": effect.filter = .lowShelf
                              case "highShelf": effect.filter = .highShelf
                              case "parametric": effect.filter = .parametric
                              case "resonantLowShelf": effect.filter = .resonantLowShelf
                              case "resonantHighShelf": effect.filter = .resonantHighShelf
                              default: effect.filter = nil
                              }
                          }

                          // Nhận loại distortion từ Flutter và map sang enum AVAudioUnitDistortionPreset
                          if let distortTypeName = args["distortType"] as? String {
                              switch distortTypeName {
                              case "drumsBitBrush": effect.distortType = .drumsBitBrush
                              case "drumsBufferBeats": effect.distortType = .drumsBufferBeats
                              case "drumsLoFi": effect.distortType = .drumsLoFi
                              case "multiBrokenSpeaker": effect.distortType = .multiBrokenSpeaker
                              case "multiCellphoneConcert": effect.distortType = .multiCellphoneConcert
                              case "multiDecimated1": effect.distortType = .multiDecimated1
                              case "multiDecimated2": effect.distortType = .multiDecimated2
                              case "multiDecimated3": effect.distortType = .multiDecimated3
                              case "multiDecimated4": effect.distortType = .multiDecimated4
                              case "multiDistortedFunk": effect.distortType = .multiDistortedFunk
                              case "multiDistortedCubed": effect.distortType = .multiDistortedCubed
                              case "multiDistortedSquared": effect.distortType = .multiDistortedSquared
                              case "multiEcho1": effect.distortType = .multiEcho1
                              case "multiEcho2": effect.distortType = .multiEcho2
                              case "multiEchoTight1": effect.distortType = .multiEchoTight1
                              case "multiEchoTight2": effect.distortType = .multiEchoTight2
                              case "multiEverythingIsBroken": effect.distortType = .multiEverythingIsBroken
                              case "speechAlienChatter": effect.distortType = .speechAlienChatter
                              case "speechCosmicInterference": effect.distortType = .speechCosmicInterference
                              case "speechGoldenPi": effect.distortType = .speechGoldenPi
                              case "speechRadioTower": effect.distortType = .speechRadioTower
                              case "speechWaves": effect.distortType = .speechWaves
                              default: effect.distortType = .drumsBitBrush // Giá trị mặc định nếu không khớp
                              }
                          }
                          print("play audio")
                          self.audioPlayerVM.playAudioWithEffect(effect: effect)
//                          self.callCaveEffect();
                          result(nil)
                      } else {
                          result(FlutterError(code: "INVALID_ARGUMENTS",
                                              message: "Invalid arguments passed",
                                              details: nil))
                      }
                  } else if call.method == "stopAudio" {
                      self.audioPlayerVM.stopAudio()
                      result(nil)
                  } else {
                      result(FlutterMethodNotImplemented)
                  }
              }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    func callCaveEffect() {
//        let effects = Effects.listEffect()
//        if let caveEffect = effects.first(where: { $0.name == "Cave" }) {
//            self.audioPlayerVM.playAudioWithEffect(effect: caveEffect)
//        } else {
//            print("Cave effect not found.")
//        }
//    }
}
