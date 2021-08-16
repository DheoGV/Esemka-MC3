//
//  Video.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 15/08/21.
//

import Foundation
import AVKit

extension DetailPageViewController : VideoProtocolDelegate {
    func playVideo() {
        let currVideo = VideoFetchClass().loadLastVideo()
        var duration = 0.0
        duration = currVideo.duration
        
        if duration == 0.0 {
            print("No Video")
        } else {
            currVideo.getURL { url in
                DispatchQueue.main.async {
                    let video = AVPlayer(url: url!)
                    let videoPlayerController = AVPlayerViewController()
                    videoPlayerController.player = video
                    
                    self.present(videoPlayerController, animated: true) {
                        video.play()
                    }
                }
            }
        }
    }
}
