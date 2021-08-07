//
//  VideoFetchClass.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 07/08/21.
//

import UIKit
import Photos
class VideoFetchClass {
    
    
    func loadLastVideo()->PHAsset{
        
        let fetchResult =  PHAsset.fetchAssets(with: .video, options: fetchOptions()).lastObject
        
        PHImageManager().requestAVAsset(forVideo: fetchResult!, options: nil, resultHandler: { (avurlAsset, audioMix, dict) in
            if let newObj = avurlAsset as? AVURLAsset{
                print(newObj.url)
                
            } else {
                
            }
        })
    
        return fetchResult!
    }
    
    func loadLastVideoWithTypeData()->Data {
        let fetchResult =  PHAsset.fetchAssets(with: .video, options: fetchOptions()).lastObject
        
        var data = Data()
        
        PHImageManager().requestAVAsset(forVideo: fetchResult!, options: nil, resultHandler: { (avurlAsset, audioMix, dict) in
            if let newObj = avurlAsset as? AVURLAsset{
                print("PATH", newObj.url)
                do {
                    data = try Data(contentsOf: newObj.url)
                    print("SUCCESS", data)
                } catch {
                    print("ERROR")
                }
              
            } else {
                
            }
        })
    
        return data
    }
    
    func areDifferentAssets(asset1:PHAsset, asset2:PHAsset)->Bool{
        var isDifferent = false
        asset1.getURL { url1 in
            asset2.getURL { url2 in
                if url1==url2{
                    isDifferent = true
                }
            }
        }
        return isDifferent
    }
    
    func fetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return fetchOptions
    }
    
}

extension PHAsset {

    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
            })
        } else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }
    }
}
