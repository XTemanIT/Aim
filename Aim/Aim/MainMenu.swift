//
//  MainManu.swift
//  Aim
//
//  Created by Artem Sierokurov on 20.10.2021.
//

import SpriteKit

class MainMenu: SKScene {
    var background:SKSpriteNode!
    var startButtonNode:SKSpriteNode!
    var frstLabelNode:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 2)
        background.zPosition = -1
        self.addChild(background)
        
        frstLabelNode = SKLabelNode(text: "Aim")
        frstLabelNode.fontName = "Palatino"
        frstLabelNode.fontSize = 56
        frstLabelNode.fontColor = UIColor.black
        frstLabelNode.position = CGPoint(x: UIScreen.main.bounds.width - 190, y: UIScreen.main.bounds.height - 320)
        self.addChild(frstLabelNode)
        
        startButtonNode = SKSpriteNode(imageNamed: "New Game Button")
        startButtonNode.size = CGSize(width: 144, height: 70)
        startButtonNode.name = "startButton"
        startButtonNode.position = CGPoint(x: UIScreen.main.bounds.width - 190, y: UIScreen.main.bounds.height - 550)
        self.addChild(startButtonNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in:  self) {
            let nodesArray = self.nodes(at: location)
            
            if  nodesArray.first?.name == "startButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
