//
//  FaceAndEyeTracking.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 04/08/21.
//

import UIKit
import ARKit

extension InterviewSimulationViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
//              let faceGeometry = node.geometry as? ARSCNFaceGeometry,
              let pixelBuffer = self.scene.session.currentFrame?.capturedImage
        else {
            return
        }
        
        let leftEye = faceAnchor.leftEyeTransform.position()
        let leftEyeX = scene.projectPoint(leftEye).x
        let leftEyeY = scene.projectPoint(leftEye).y
        
        let rightEye = faceAnchor.rightEyeTransform.position()
        let rightEyeX = scene.projectPoint(rightEye).x
        let rightEyeY = scene.projectPoint(rightEye).y
        
        let totalX: Float = ( leftEyeX + rightEyeX )/2
        let totalY: Float = ( leftEyeY + rightEyeY )/2
        
        let resultCGPoint2 = CGPoint(x: Int(totalX), y: Int(totalY))
        eyeTracking.listOfCoordinate.append(Coordinate(x: Int(resultCGPoint2.x), y: Int(resultCGPoint2.y)))
        
        eyeTracking.listOfCoordinateTemp.append(Coordinate(x: Int(resultCGPoint2.x), y: Int(resultCGPoint2.y)))
        
        let batasMaxX = eyeTracking.listOfCoordinateTemp[0].x + 75
        let batasMinX = eyeTracking.listOfCoordinateTemp[0].x - 75
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            eyeTracking.countFrameRenderer += 1
            
            if(eyeTracking.countFrameRenderer == 30) {
                eyeTracking.countFrameRenderer = 0
                DispatchQueue.main.async { [self] in
                    if ( eyeTracking.listOfCoordinate.count >= 2) {
                        for(index,_) in eyeTracking.listOfCoordinate.enumerated() {
                            if eyeTracking.listOfCoordinate[index].x > batasMaxX || eyeTracking.listOfCoordinate[index].x < batasMinX  {
                                eyeTracking.countMissFrameRenderer += 1
                                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                    eyeTracking.countMiss += 1
                                    eyeTracking.countMissInSecond = eyeTracking.countMiss / 60
                                }
                            }
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    eyeTracking.listOfCoordinate.removeAll()
                }
                
            }
        }
        
        //Face Emotion
//        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:]).perform([VNCoreMLRequest(model: model) { [weak self] request, error in
//
//            guard let firstResult = (request.results as? [VNClassificationObservation])?.first else { return }
//            DispatchQueue.main.async { [self] in
//
//                if firstResult.confidence > 0.92 {
//                    print(firstResult.identifier)
//                    self?.totalEmotion += 1
//                    if firstResult.identifier == "Happy" || firstResult.identifier == "Neutral" || firstResult.identifier == "Surprise"{
//                        self?.goodEmotion += 1
//                    }
//                }
//
//            }
//        }])
        
//        faceGeometry.update(from: faceAnchor.geometry)
    }
}

extension matrix_float4x4 {
    func position() -> SCNVector3 {
        return SCNVector3(columns.2.x, columns.2.y, columns.2.z)
    }
}

extension matrix_float3x3 {
    func position() -> SCNVector3 {
        return SCNVector3(x: 30, y: 30, z: 30)
    }
}

