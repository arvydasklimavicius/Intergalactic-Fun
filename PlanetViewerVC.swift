//
//  ViewController.swift
//  Intergalactic Fun
//
//  Created by Arvydas Klimavicius on 2020-04-23.
//  Copyright © 2020 Arvydas Klimavicius. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlanetViewerVC: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    var planetName: String!
    let baseNode = SCNNode()
    let planetNode = SCNNode()
    let textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self

        addBaseNode()
        addPlanet()

//        let scene = SCNScene(named: "art.scnassets/ship.scn")!

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    func addBaseNode() {
        let baseLocation = SCNVector3(0.0, 0.0, -1.0)
        baseNode.position = baseLocation
        sceneView.scene.rootNode.addChildNode(baseNode)
    }

    func addPlanet() {
        let planet = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: planetName)
        planet.materials = [material]
        planetNode.geometry = planet
        baseNode.addChildNode(planetNode )

        let planetRotate = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 15)
        let repeatRotation = SCNAction.repeatForever(planetRotate)
        planetNode.runAction(repeatRotation )

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }


}
