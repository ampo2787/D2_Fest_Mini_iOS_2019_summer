//
//  Convert_MovieToImage.swift
//  CinemaGraph
//
//  Created by JihoonPark on 20/07/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit
import AVFoundation

class Convert_MovieToImage: NSObject {
    // MARK: - User Function
    var frames:[UIImage] = []
    private var generator:AVAssetImageGenerator!
    
    func getAllFrames(videoUrl:URL) {
        let asset:AVAsset = AVAsset(url:videoUrl)
        let duration:Float64 = CMTimeGetSeconds(asset.duration)
        
        let frameRate:Float? = asset.tracks.last?.nominalFrameRate
        
        self.generator = AVAssetImageGenerator(asset:asset)
        self.generator.appliesPreferredTrackTransform = true
        self.frames = []
        
        //get All Frame From video FrameRate
        for index:Int in 1 ..< Int(duration) {
            self.getFrame(fromTime:Float64(index))
            /*
            for frameIndex:Int in 1..<Int(frameRate!) {
                    let floatIndex = Float(index)
                    let floatFrameIndex = Float(frameIndex)
                
                    let thisIndex = ((floatIndex/frameRate!) * floatFrameIndex)
                    self.getFrame(fromTime:Float64(thisIndex))
                
            }
 */
        }
        self.generator = nil
    }
    
    private func getFrame(fromTime:Float64) {
        let time:CMTime = CMTimeMakeWithSeconds(fromTime, preferredTimescale:600)
        let image:CGImage
        do {
            try image = self.generator.copyCGImage(at:time, actualTime:nil)
        } catch {
            return
        }
        self.frames.append(UIImage(cgImage:image))
    }
}
