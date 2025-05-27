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
        
        guard let url = Bundle.main.url(forResource: "demovoice2", withExtension: "m4a") else {
            print("Audio file not found demo voice")
            return
        }

        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Failed to load audio file: \(error)")
        }
    }
    
    func playAudioWithEffect(effect: Effects, url: URL) {
        print("playAudioWithEffect: \(url)")
        // Stop the audio player node if it's already playing
        
        audioPlayerNode.stop()

        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Failed to load audio file: \(error)")
        }
        
        self.playAudioWithEffect(effect: effect)
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
    
    
    func extractAudio(from videoUrl: URL, completion: @escaping (AVAudioFile?) -> Void) {
        let asset = AVAsset(url: videoUrl)
        guard let audioTrack = asset.tracks(withMediaType: .audio).first else {
            print("Không tìm thấy audio track trong video.")
            completion(nil)
            return
        }
        
        
        let fileManager = FileManager.default
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("extracted_audio.m4a")

        if fileManager.fileExists(atPath: outputURL.path) {
            do {
                try fileManager.removeItem(at: outputURL)
                print("🗑 Đã xoá file cũ: \(outputURL)")
            } catch {
                print("❌ Lỗi khi xoá file: \(error)")
            }
        }
        
        let composition = AVMutableComposition()
        guard let compositionTrack = composition.addMutableTrack(withMediaType: .audio,
                                                                 preferredTrackID: kCMPersistentTrackID_Invalid) else {
            completion(nil)
            return
        }
        
        do {
            try compositionTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration),
                                                 of: audioTrack,
                                                 at: .zero)
            let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)!
            exporter.outputFileType = .m4a
            exporter.outputURL = outputURL
            exporter.exportAsynchronously {
                if exporter.status == .completed {
                    do {
                        let audioFile = try AVAudioFile(forReading: outputURL)
                        completion(audioFile)
                    } catch {
                        print("Lỗi tải audio file: \(error)")
                        completion(nil)
                    }
                } else {
                    print("Xuất audio thất bại: \(exporter.error?.localizedDescription ?? "Không rõ lỗi")")
                    completion(nil)
                }
            }
        } catch {
            print("Lỗi trích xuất âm thanh: \(error)")
            completion(nil)
        }
    }
    
    func mergeAudioWithVideo(videoUrl: URL, audioUrl: URL, outputUrl: URL, completion: @escaping (Bool) -> Void) {
        let mixComposition = AVMutableComposition()
        
        // Load video
        let videoAsset = AVAsset(url: videoUrl)
        guard let videoTrack = videoAsset.tracks(withMediaType: .video).first else {
            print("Không tìm thấy video track.")
            completion(false)
            return
        }
        
        let videoCompositionTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        do {
            try videoCompositionTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration),
                                                       of: videoTrack,
                                                       at: .zero)
        } catch {
            print("Lỗi chèn video track: \(error)")
            completion(false)
            return
        }
        
        // Load new audio
        let audioAsset = AVAsset(url: audioUrl)
        guard let audioTrack = audioAsset.tracks(withMediaType: .audio).first else {
            print("Không tìm thấy audio track.")
            completion(false)
            return
        }
        
        let audioCompositionTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        do {
            try audioCompositionTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: audioAsset.duration),
                                                       of: audioTrack,
                                                       at: .zero)
        } catch {
            print("Lỗi chèn audio track: \(error)")
            completion(false)
            return
        }
        
        // Xuất video mới
        let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
        exporter.outputURL = outputUrl
        exporter.outputFileType = .mov
        exporter.exportAsynchronously {
            if exporter.status == .completed {
                print("Xuất video thành công!")
                completion(true)
            } else {
                print("Lỗi xuất video: \(exporter.error?.localizedDescription ?? "Không rõ lỗi")")
                completion(false)
            }
        }
    }
    
    func processAudioWithEffect(effect: Effects, inputUrl: URL, outputUrl: URL, completion: @escaping (Bool) -> Void) {
        let audioEngine = AVAudioEngine()
        let audioPlayerNode = AVAudioPlayerNode()
        let pitchControl = AVAudioUnitTimePitch()
        
        pitchControl.pitch = effect.pitch
        pitchControl.rate = effect.speed
        
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(pitchControl)
        audioEngine.connect(audioPlayerNode, to: pitchControl, format: nil)
        audioEngine.connect(pitchControl, to: audioEngine.mainMixerNode, format: nil)

        do {
            let audioFile = try AVAudioFile(forReading: inputUrl)
            let outputFile = try AVAudioFile(forWriting: outputUrl, settings: audioFile.fileFormat.settings)

            audioPlayerNode.scheduleFile(audioFile, at: nil) {
                DispatchQueue.main.async {
                    completion(true)
                }
            }

            try audioEngine.start()
            audioPlayerNode.play()
            guard let format = audioFile.processingFormat.copy() as? AVAudioFormat else {
                print("❌ Lỗi: Không thể lấy định dạng âm thanh")
                return
            }
            print("🎵 Định dạng âm thanh: \(format)")

            audioEngine.mainMixerNode.installTap(onBus: 0, bufferSize: 4096, format: audioFile.processingFormat) { (buffer, _) in
                do {
                    try outputFile.write(from: buffer)
                } catch {
                    print("❌ Lỗi khi ghi file audio: \(error)")
                    completion(false)
                }
            }

            let durationInSeconds = Double(audioFile.length) / audioFile.processingFormat.sampleRate
            DispatchQueue.global().asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(Int(durationInSeconds * 1000))) {
                audioEngine.stop()
                audioPlayerNode.stop()
                audioEngine.mainMixerNode.removeTap(onBus: 0)
                completion(true)
            }

        } catch {
            print("❌ Lỗi khi xử lý audio: \(error)")
            completion(false)
        }
    }
    
    func processAudioWithEffect(inputUrl: URL, effect: Effects, outputFileName: String, completion: @escaping (URL?) -> Void) {
        let audioEngine = AVAudioEngine()
        let audioPlayerNode = AVAudioPlayerNode()
        let pitchControl = AVAudioUnitTimePitch()
        let eqNode = AVAudioUnitEQ(numberOfBands: 3)
        
        let outputUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("\(outputFileName).m4a")
        
        // Xóa file cũ nếu tồn tại
        if FileManager.default.fileExists(atPath: outputUrl.path) {
            try? FileManager.default.removeItem(at: outputUrl)
        }

        do {
            let audioFile = try AVAudioFile(forReading: inputUrl)
            let format = audioFile.processingFormat
            let frameCount = AVAudioFrameCount(audioFile.length)

            // Cấu hình hiệu ứng
            pitchControl.pitch = effect.pitch
            pitchControl.rate = effect.speed

            // Cấu hình EQ nếu có
            if effect.eq1.count == 3 {
                eqNode.bands[0].frequency = effect.eq1[0]
                eqNode.bands[0].bandwidth = effect.eq1[1]
                eqNode.bands[0].gain = effect.eq1[2]
            }

            // Kết nối các node vào audio engine
            audioEngine.attach(audioPlayerNode)
            audioEngine.attach(pitchControl)
            audioEngine.attach(eqNode)

            audioEngine.connect(audioPlayerNode, to: pitchControl, format: format)
            audioEngine.connect(pitchControl, to: eqNode, format: format)
            audioEngine.connect(eqNode, to: audioEngine.mainMixerNode, format: format)

            // Bắt đầu audio engine
            try audioEngine.start()
            audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
//            audioPlayerNode.play()

            // Ghi âm thanh đã xử lý ra file
            do {
                let outputFile = try AVAudioFile(forWriting: outputUrl, settings: audioFile.fileFormat.settings)
                
                let format = audioEngine.mainMixerNode.outputFormat(forBus: 0) // Lấy định dạng chính xác
                
                try audioEngine.start() // Đảm bảo audioEngine đã chạy

                audioEngine.mainMixerNode.installTap(onBus: 0, bufferSize: 4096, format: format) { (buffer, when) in
                    do {
                        try outputFile.write(from: buffer)
                    } catch {
                        print("❌ Lỗi ghi file: \(error)")
                    }
                }
            } catch {
                print("❌ Lỗi: \(error.localizedDescription)")
            }
            
            audioPlayerNode.scheduleFile(audioFile, at: nil) {
                DispatchQueue.main.async {
                    audioEngine.stop()
                    audioPlayerNode.stop()
                    audioEngine.mainMixerNode.removeTap(onBus: 0)
                    completion(outputUrl)
                }
            }
            audioPlayerNode.play()

//            DispatchQueue.global().asyncAfter(deadline: .now() + 5) { // Chờ 5 giây để xử lý xong
//                audioEngine.stop()
//                audioPlayerNode.stop()
//                audioEngine.mainMixerNode.removeTap(onBus: 0)
//                completion(outputUrl)
//            }

        } catch {
            print("❌ Lỗi xử lý file: \(error)")
            completion(nil)
        }
    }
    
    func processAudioWithEffect2(inputUrl: URL, effect: Effects, outputFileName: String, completion: @escaping (URL?) -> Void) {
        let audioEngine = AVAudioEngine()
            let audioFile: AVAudioFile
            let outputUrl = FileManager.default.temporaryDirectory.appendingPathComponent("\(outputFileName).m4a")
            
            // Xóa file cũ nếu tồn tại
            if FileManager.default.fileExists(atPath: outputUrl.path) {
                try? FileManager.default.removeItem(at: outputUrl)
            }

            do {
                audioFile = try AVAudioFile(forReading: inputUrl)
                let format = audioFile.processingFormat
                let frameCount = AVAudioFrameCount(audioFile.length)
                
                // Tạo buffer chứa toàn bộ dữ liệu âm thanh
                guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
                    completion(nil)
                    return
                }
                
                try audioFile.read(into: buffer)
                
                // Thiết lập các node xử lý
                let pitchControl = AVAudioUnitTimePitch()
                let eqNode = AVAudioUnitEQ(numberOfBands: 3)
                
                // Cấu hình hiệu ứng
                pitchControl.pitch = effect.pitch
                pitchControl.rate = effect.speed
                
                if effect.eq1.count == 3 {
                    eqNode.bands[0].frequency = effect.eq1[0]
                    eqNode.bands[0].bandwidth = effect.eq1[1]
                    eqNode.bands[0].gain = effect.eq1[2]
                }
                
                // Thiết lập file output
                let outputSettings = audioFile.fileFormat.settings
                let outputFile = try AVAudioFile(forWriting: outputUrl, settings: outputSettings)
                
                // Thiết lập engine offline
                let inputNode = AVAudioPlayerNode()
                
                audioEngine.attach(inputNode)
                audioEngine.attach(pitchControl)
                audioEngine.attach(eqNode)
                
                audioEngine.connect(inputNode, to: pitchControl, format: format)
                audioEngine.connect(pitchControl, to: eqNode, format: format)
                audioEngine.connect(eqNode, to: audioEngine.mainMixerNode, format: format)
                
                // Thiết lập tap để ghi dữ liệu
                let tapFormat = audioEngine.mainMixerNode.outputFormat(forBus: 0)
                audioEngine.mainMixerNode.installTap(onBus: 0, bufferSize: 4096, format: tapFormat) { (tapBuffer, time) in
                    do {
                        try outputFile.write(from: tapBuffer)
                    } catch {
                        print("❌ Lỗi ghi file: \(error)")
                    }
                }
                
                // Khởi động engine
                try audioEngine.start()
                
                // Xử lý buffer
                inputNode.scheduleBuffer(buffer) {
                    // Chờ một chút để đảm bảo dữ liệu được ghi xong
                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                        audioEngine.stop()
                        audioEngine.mainMixerNode.removeTap(onBus: 0)
                        completion(outputUrl)
                    }
                }
                
                inputNode.play()
                
                // Tính toán thời gian xử lý an toàn
                let duration = Double(frameCount) / Double(format.sampleRate) / Double(effect.speed)
                let processingTime = duration + 1.0 // Thêm thời gian đệm để đảm bảo xử lý hoàn tất
                
                // Timeout bảo vệ nếu callback không được gọi
                DispatchQueue.global().asyncAfter(deadline: .now() + processingTime) {
                    if audioEngine.isRunning {
                        audioEngine.stop()
                        audioEngine.mainMixerNode.removeTap(onBus: 0)
                        completion(outputUrl)
                    }
                }
                
            } catch {
                print("❌ Lỗi xử lý file: \(error)")
                completion(nil)
            }
    }

    func processAudioOffline(inputUrl: URL, effect: Effects, outputFileName: String, completion: @escaping (URL?) -> Void) {
        let outputUrl = FileManager.default.temporaryDirectory.appendingPathComponent("\(outputFileName).m4a")
        
        // Xóa file cũ nếu tồn tại
        if FileManager.default.fileExists(atPath: outputUrl.path) {
            try? FileManager.default.removeItem(at: outputUrl)
        }
        
        // Tạo asset từ input url
        let asset = AVAsset(url: inputUrl)
        
        // Tạo export session với các thiết lập tùy chỉnh
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else {
            completion(nil)
            return
        }
        
        // Thiết lập audio mix
        let audioMix = AVMutableAudioMix()
        let audioTracks = asset.tracks(withMediaType: .audio)
        
        guard let audioTrack = audioTracks.first else {
            completion(nil)
            return
        }
        
        // Tạo audio mix input parameters để áp dụng hiệu ứng
        let audioMixInputParameters = AVMutableAudioMixInputParameters(track: audioTrack)
        
        // Áp dụng audio effects
        var audioTimePitchAlgorithm: AVAudioTimePitchAlgorithm = .timeDomain
        
        // Thiết lập các tham số giống như trong AVAudioUnitTimePitch
        if abs(effect.pitch) > 0 {
            // Chọn thuật toán phù hợp cho việc thay đổi pitch
            audioTimePitchAlgorithm = .spectral
        }
        
        // Áp dụng thuật toán time pitch cho audio mix
        audioMixInputParameters.audioTimePitchAlgorithm = audioTimePitchAlgorithm
        
        // Thiết lập audio mix
        audioMix.inputParameters = [audioMixInputParameters]
        exportSession.audioMix = audioMix
        
        // Thiết lập export session
        exportSession.outputURL = outputUrl
        exportSession.outputFileType = .m4a
        
        // Tạo AudioProcessingTap để áp dụng các hiệu ứng nâng cao
        var callbacks = MTAudioProcessingTapCallbacks(
            version: kMTAudioProcessingTapCallbacksVersion_0,
            clientInfo: UnsafeMutableRawPointer(Unmanaged.passUnretained(effect).toOpaque()),
            init: { (tap, clientInfo, tapStorageOut) in
                tapStorageOut.pointee = clientInfo
            },
            finalize: { (tap) in },
            prepare: { (tap, maxFrames, processingFormat) in },
            unprepare: { (tap) in },
            process: { (tap, numberFrames, flags, bufferListInOut, numberFramesOut, flagsOut) in
                // Lấy thông tin effect - không sử dụng guard let vì không phải Optional
                let tapStorage = MTAudioProcessingTapGetStorage(tap)
                
                // Chuyển đổi con trỏ thành Effects
                let effect = Unmanaged<Effects>.fromOpaque(tapStorage).takeUnretainedValue()
                
                // Áp dụng các hiệu ứng EQ và khác tại đây
                
                // Đặt số frame đã xử lý
                numberFramesOut.pointee = numberFrames
                flagsOut.pointee = 0  // Gán giá trị 0 trực tiếp
            }
        )
        
        // Áp dụng audio processing tap
        var tap: Unmanaged<MTAudioProcessingTap>?
        let status = MTAudioProcessingTapCreate(kCFAllocatorDefault, &callbacks, kMTAudioProcessingTapCreationFlag_PreEffects, &tap)
        
        if status == noErr, let unwrappedTap = tap {
            audioMixInputParameters.audioTapProcessor = unwrappedTap.takeRetainedValue()
        }
        
        // Thực hiện export
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(outputUrl)
            default:
                print("❌ Export failed: \(exportSession.status), error: \(String(describing: exportSession.error))")
                completion(nil)
            }
        }
    }
    
    func processVideoWithEffect(videoUrl: URL, effect: Effects, outputUrl: URL) {
        extractAudio(from: videoUrl) { extractedAudioFile in
            guard let extractedAudioFile = extractedAudioFile else {
                print("❌ Lỗi khi trích xuất audio từ video")
                return
            }

//            let processedAudioURL = FileManager.default.temporaryDirectory.appendingPathComponent("processed_audio.m4a")
            let outputVideoURL = FileManager.default.temporaryDirectory.appendingPathComponent("video_with_effect.mp4")
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: outputVideoURL.path) {
                do {
                    try fileManager.removeItem(at: outputVideoURL)
                    print("🗑 Đã xoá file cũ: \(outputVideoURL)")
                } catch {
                    print("❌ Lỗi khi xoá file: \(error)")
                }
            }
        
            self.processAudioOffline(inputUrl: extractedAudioFile.url, effect: effect, outputFileName: "processed_audio") { outputUrl in
                if let outputUrl = outputUrl {
                    print("✅ Audio đã được lưu tại: \(outputUrl)")
//                    self.mergeAudioWithVideo(videoUrl: videoUrl, audioUrl: outputUrl, outputUrl: outputVideoURL) { success in
//                        if success {
//                            print("✅ Video đã hoàn tất xử lý: \(outputVideoURL)")
//                        }
//                    }
                    self.combineVideoWithAudio(videoURL: videoUrl, audioURL: outputUrl, outputURL: outputVideoURL) { success in
                        if success {
                            print("✅ Video đã hoàn tất xử lý: \(outputVideoURL)")
                        }
                    }
                } else {
                    print("❌ Xử lý audio thất bại")
                }
            }
        }
    }

    private func combineVideoWithAudio(videoURL: URL, audioURL: URL, outputURL: URL, completion: @escaping (Bool) -> Void) {
            let videoAsset = AVAsset(url: videoURL)
            let audioAsset = AVAsset(url: audioURL)
            
            // Create a mutable composition
            let composition = AVMutableComposition()
            
            // Add the video track to the composition
            guard let videoTrack = videoAsset.tracks(withMediaType: .video).first else {
                print("Failed to get video track")
                completion(false)
                return
            }
            guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else {
                print("Failed to create composition video track")
                completion(false)
                return
            }
            
            do {
                try compositionVideoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration), of: videoTrack, at: .zero)
            } catch {
                print("Failed to insert video track: \(error)")
                completion(false)
                return
            }
            var transform = compositionVideoTrack.preferredTransform
            transform = CGAffineTransform(rotationAngle: .pi / 2) // Rotate 90 degrees
            
            // Apply the transform to the composition track
            compositionVideoTrack.preferredTransform = transform

            // Add the audio track to the composition
            guard let audioTrack = audioAsset.tracks(withMediaType: .audio).first else {
                print("Failed to get audio track")
                completion(false)
                return
            }
            guard let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) else {
                print("Failed to create composition audio track")
                completion(false)
                return
            }
            
            do {
                try compositionAudioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration), of: audioTrack, at: .zero)
            } catch {
                print("Failed to insert audio track: \(error)")
                completion(false)
                return
            }
            
            // Create an export session
            guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
                print("Failed to create export session")
                completion(false)
                return
            }
            
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mov
            
            // Export the combined video
            exportSession.exportAsynchronously {
                switch exportSession.status {
                case .completed:
                    print("Video exported successfully: \(outputURL.lastPathComponent)")
                    completion(true)
                case .failed:
                    if let error = exportSession.error {
                        print("Export failed: \(error.localizedDescription)")
                    }
                    completion(false)
                case .cancelled:
                    print("Export cancelled")
                    completion(false)
                default:
                    print("Export ended with status: \(exportSession.status.rawValue)")
                    completion(false)
                }
            }
        }
}
