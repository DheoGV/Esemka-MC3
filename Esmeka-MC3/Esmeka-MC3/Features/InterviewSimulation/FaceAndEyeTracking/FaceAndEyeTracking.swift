//
//  FaceAndEyeTracking.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 04/08/21.
//

import UIKit
import ARKit

extension InterviewSimulationViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = scene.device else { return nil }
        let node = SCNNode(geometry: ARSCNFaceGeometry(device: device))
        //Projects the white lines on the face.
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
              let faceGeometry = node.geometry as? ARSCNFaceGeometry,
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
        self.listOfCoordinate.append(Coordinate(x: Int(resultCGPoint2.x), y: Int(resultCGPoint2.y)))
        
        self.listOfCoordinateTemp.append(Coordinate(x: Int(resultCGPoint2.x), y: Int(resultCGPoint2.y)))
        
        
        
        let batasMaxX = listOfCoordinateTemp[0].x + 75
        let batasMinX = listOfCoordinateTemp[0].x - 75
        
        
//        print("batas Max X \(batasMaxX)")
//        print("batas Min X \(batasMinX)")
        
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            
            self.countFrameRenderer += 1
            
            if(countFrameRenderer == 30) {
                countFrameRenderer = 0
//                print("Jumlah ", listOfCoordinate.count)
                DispatchQueue.main.async { [self] in
                    if ( listOfCoordinate.count >= 2) {
                        for(index,_) in listOfCoordinate.enumerated() {
//                            print("Batas Max", batasMaxX)
//                            print("Batas Min", batasMinX)
//                            print("Nilai X ",listOfCoordinate[index].x)
                            
                            
                            if listOfCoordinate[index].x > batasMaxX || listOfCoordinate[index].x < batasMinX  {
                                
                                self.countMissFrameRenderer += 1
                                
//                                print("Coun miss Frame", countFrameRenderer)
        
                                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                    countMiss += 1
                                    countMissInSecond = countMiss / 60
//                                    print("Coun Miss", countMissInSecond)
//                                    print("Coun Miss second", countMissInSecond)
                                    
                                }
                                
                                
                            } else {
                                //self.statusLabe.text = ""
                            }
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.listOfCoordinate.removeAll()
                }
                
            }
        }
        
        
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
        
        faceGeometry.update(from: faceAnchor.geometry)
        
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

