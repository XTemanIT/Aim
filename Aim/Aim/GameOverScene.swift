//
//  GameOverScene.swift
//  Aim
//
//  Created by Artem Sierokurov on 21.10.2021.
//

import UIKit
import SpriteKit
import GameplayKit
import WebKit

class GameOverScene: SKScene {
    var background:SKSpriteNode!
    var backButtonNode:SKSpriteNode!
    var lblGameOverNode:SKLabelNode!
    
    var winner:Bool = false
    
    override func didMove(to view: SKView) {
        background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 2)
        background.zPosition = -1
        self.addChild(background)
        
        if winner == true {
            lblGameOverNode = SKLabelNode(text: "You Win!")
        } else { lblGameOverNode = SKLabelNode(text: "You lose!") }
        lblGameOverNode.fontName = "Palatino"
        lblGameOverNode.fontSize = 44
        lblGameOverNode.fontColor = UIColor.black
        lblGameOverNode.position = CGPoint(x: UIScreen.main.bounds.width - 190, y: UIScreen.main.bounds.height - 320)
        self.addChild(lblGameOverNode)
        
        backButtonNode = SKSpriteNode(imageNamed: "Back Button")
        backButtonNode.size = CGSize(width: 144, height: 70)
        backButtonNode.name = "backButton"
        backButtonNode.position = CGPoint(x: UIScreen.main.bounds.width - 190, y: UIScreen.main.bounds.height - 550)
        self.addChild(backButtonNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in:  self) {
            let nodesArray = self.nodes(at: location)
            
            if  nodesArray.first?.name == "backButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let mainMenu = MainMenu(size: UIScreen.main.bounds.size)
                self.view?.presentScene(mainMenu, transition: transition)
            }
        }
    }
}
