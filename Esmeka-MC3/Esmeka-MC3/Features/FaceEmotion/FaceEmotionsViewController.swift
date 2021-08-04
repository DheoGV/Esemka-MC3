////
////  FaceEmotionsViewController.swift
////  Esmeka-MC3
////
////  Created by Dheo Gildas Varian on 03/08/21.
////
//
//import UIKit
//import ARKit
//
//class FaceEmotionsViewController: UIViewController {
//
//    @IBOutlet weak var sceneView: ARSCNView!
//    
//    let model = try! VNCoreMLModel(for: CNNEmotions().model)
//    var textNode: SCNNode?
//    
//    var totalEmotion = 0
//    var goodEmotion = 0
//    var faceEmotionScore:Int = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//    
//    func setup() {
//        guard ARWorldTrackingConfiguration.isSupported else { return }
//        sceneView.delegate = self
//        sceneView.showsStatistics = true
//        sceneView.session.run(ARFaceTrackingConfiguration(), options: [.resetTracking,.removeExistingAnchors])
//    }
//    
//    func addTextNode(faceGeometry: ARSCNFaceGeometry) {
//        let text = SCNText(string: "", extrusionDepth: 1)
//        text.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.systemYellow
//        text.materials = [material]
//        
//        let textNode = SCNNode(geometry: faceGeometry)
//        textNode.position = SCNVector3(-0.1, 0.3, -0.5)
//        textNode.scale = SCNVector3(0.003, 0.003, 0.003)
//        textNode.geometry = text
//        self.textNode = textNode
//        sceneView.scene.rootNode.addChildNode(textNode)
//    }
//
//    
//
//}
//
//extension FaceEmotionsViewController: ARSCNViewDelegate{
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        guard let device = sceneView.device else { return nil }
//        let node = SCNNode(geometry: ARSCNFaceGeometry(device: device))
//        node.geometry?.firstMaterial?.fillMode = .lines
//        return node
//    }
//    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let faceGeomery = node.geometry as? ARSCNFaceGeometry, textNode == nil else { return }
//        addTextNode(faceGeometry: faceGeomery)
//    }
//    
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let faceAnchor = anchor as? ARFaceAnchor,
//            let faceGeometry = node.geometry as? ARSCNFaceGeometry,
//            let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage
//            else {
//            return
//        }
//        faceGeometry.update(from: faceAnchor.geometry)
//        
//        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:]).perform([VNCoreMLRequest(model: model) { [weak self] request, error in
//                guard let firstResult = (request.results as? [VNClassificationObservation])?.first else { return }
//            DispatchQueue.main.async { [self] in
//
//                    if firstResult.confidence > 0.92 {
//                        (self?.textNode?.geometry as? SCNText)?.string = firstResult.identifier
//                        print(firstResult.identifier)
//                        self?.totalEmotion += 1
//                        if firstResult.identifier == "Happy" || firstResult.identifier == "Neutral" || firstResult.identifier == "Surprise"{
//                            self?.goodEmotion += 1
//                        }
//                    }
//                    
//                }
//            }])
//    }
//}
