//
//  GameViewController.swift
//  Aim
//
//  Created by Artem Sierokurov on 20.10.2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(Del), name: Notification.Name("GameOver"), object: nil)
    }
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func Del() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let webViewController = storyboard.instantiateViewController(identifier: "WebViewController") as? WebViewController else { return }
        show(webViewController, sender: nil)
    }
}
