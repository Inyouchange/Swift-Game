//
//  GameViewController.swift
//  testwalk1031
//
//  Created by Betty on 2018/10/31.
//  Copyright © 2018 Betty. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = view as? SKView {
            //Create the scene programmatically
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            // Present the scene
            view.presentScene(scene)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
