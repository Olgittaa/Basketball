//
//  ViewController.swift
//  Delo
//
//  Created by Ольга Чарная on 10.10.2022.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    
    @IBOutlet var skView: SKView!
    var mouseLocation: NSPoint? { self.view.window?.mouseLocationOutsideOfEventStream }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

