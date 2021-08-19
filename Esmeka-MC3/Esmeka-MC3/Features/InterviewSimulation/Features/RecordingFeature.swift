//
//  RecordingFeature.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 05/08/21.
//

import UIKit
import ReplayKit

extension InterviewSimulationViewController : RPPreviewViewControllerDelegate{
    func startRecording(){
        let recorder = RPScreenRecorder.shared()
//        guard recorder.isAvailable else { return }
        recorder.isMicrophoneEnabled = true
        recorder.startRecording{ [unowned self] (error) in
//            guard error == nil else { return }
            if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
            } else {
                prevVideo = VideoFetchClass().loadLastVideo()
                startCountdownView()
                startRecordCountView()
            }
        }
    }
    
    func stopRecording(){
        let recorder = RPScreenRecorder.shared()
        recorder.stopRecording { [unowned self] (preview, error) in
            if let unwrappedPreview = preview {
                unwrappedPreview.previewControllerDelegate = self
                self.present(unwrappedPreview, animated: true)
            }
        }
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
        let currVideo = VideoFetchClass().loadLastVideo()
        if VideoFetchClass().areDifferentAssets(asset1: currVideo, asset2: prevVideo){
            isVideoSaved = true
        }
        saveData()
    }
    
}
