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
    func videoToImageArray(url:URL) -> UIImage?{
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        
        let startTime = CMTime(seconds: 0, preferredTimescale: 60)
        let playTime = asset.duration
        
        if let cgImage = try? generator.copyCGImage(at: CMTime(seconds: 2, preferredTimescale: 60), actualTime: nil) {
            return UIImage(cgImage: cgImage)
        }
        else {
            return nil
        }
    }
}
