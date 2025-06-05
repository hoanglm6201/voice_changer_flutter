//
//  VideoMerger.swift
//  Runner
//
//  Created by Quang Linh Pham on 4/6/25.
//

import Foundation
import AVFoundation

@objc class VideoMerger: NSObject {

    @objc static func mergeVideos(videoPaths: [String], outputPath: String, completion: @escaping (Bool, String?) -> Void) {
        let mixComposition = AVMutableComposition()
        guard !videoPaths.isEmpty else {
            completion(false, "No input video paths")
            return
        }

        var insertTime = CMTime.zero
        let mainInstruction = AVMutableVideoCompositionInstruction()
        var layerInstructions: [AVMutableVideoCompositionLayerInstruction] = []

        for path in videoPaths {
            let url = URL(fileURLWithPath: path)
            let asset = AVURLAsset(url: url)
            guard let videoTrack = asset.tracks(withMediaType: .video).first else {
                completion(false, "Cannot read video track")
                return
            }

            let timeRange = CMTimeRangeMake(start: .zero, duration: asset.duration)

            guard let compositionTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else {
                completion(false, "Failed to create composition track")
                return
            }

            try? compositionTrack.insertTimeRange(timeRange, of: videoTrack, at: insertTime)

            let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compositionTrack)
            let transform = videoTrack.preferredTransform
            instruction.setTransform(transform, at: insertTime)
            instruction.setOpacity(0.0, at: CMTimeAdd(insertTime, asset.duration))
            layerInstructions.append(instruction)

            insertTime = CMTimeAdd(insertTime, asset.duration)
        }

        mainInstruction.timeRange = CMTimeRange(start: .zero, duration: insertTime)
        mainInstruction.layerInstructions = layerInstructions

        let videoComposition = AVMutableVideoComposition()
        videoComposition.instructions = [mainInstruction]
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        
        // Get the natural size of the first video
        if let firstVideoTrack = AVURLAsset(url: URL(fileURLWithPath: videoPaths[0])).tracks(withMediaType: .video).first {
            let naturalSize = firstVideoTrack.naturalSize
            videoComposition.renderSize = naturalSize
        }

        guard let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) else {
            completion(false, "Export session failed")
            return
        }

        let outputURL = URL(fileURLWithPath: outputPath)
        if FileManager.default.fileExists(atPath: outputPath) {
            try? FileManager.default.removeItem(at: outputURL)
        }

        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.videoComposition = videoComposition

        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(true, outputPath)
            case .failed, .cancelled:
                completion(false, exportSession.error?.localizedDescription ?? "Unknown error")
            default:
                break
            }
        }
    }
}

