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
        addText()
        addShip()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    func addBaseNode() {
        let baseLocation = SCNVector3(0.0, 0.0, -1.5)
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

    func addText() {
        let text = SCNText(string: planetName.capitalized, extrusionDepth: 1)
        text.font = UIFont(name: "futura", size: 16)
        text.flatness = 0
        let scaleFactor = 0.1 / text.font.pointSize
        textNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        textNode.geometry = text
        let max = textNode.boundingBox.max.x
        let min = textNode.boundingBox.min.x
        let midpoint = -((max - min) / 2 + min) * Float(scaleFactor)
        textNode.position = SCNVector3(midpoint, 0.35, 0)
        baseNode.addChildNode(textNode)
    }

    func addShip() {
        let orbitAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 6)
        let repeatOrbit = SCNAction.repeatForever(orbitAction)

        let shipUpAction = SCNAction.move(to: SCNVector3(-0.35, 0.2, 0), duration: 2)
        shipUpAction.timingMode = .easeInEaseOut
        let shipDownAction = SCNAction.move(to: SCNVector3(-0.35, -0.2, 0), duration: 2)
        shipDownAction.timingMode = .easeInEaseOut
        let upDown = SCNAction.sequence([shipUpAction, shipDownAction])
        let repeatUpDown = SCNAction.repeatForever(upDown)


        let scene = SCNScene(named: "art.scnassets/ship.scn")
        if let shipNode = scene?.rootNode.childNode(withName: "ship", recursively: true ) {
            shipNode.scale = SCNVector3(0.2, 0.2, 0.2)
            shipNode.position = SCNVector3(-0.35, 0, 0)
            let rotateNode = SCNNode()
            baseNode.addChildNode(rotateNode)
            rotateNode.addChildNode(shipNode)
            rotateNode.runAction(repeatOrbit)
            shipNode.runAction(repeatUpDown)

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }


}
