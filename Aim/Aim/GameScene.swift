//
//  GameScene.swift
//  Aim
//
//  Created by Artem Sierokurov on 20.10.2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var target = "target"
    var background:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var stopGame:Bool = false
    var winner:Bool = false
    var dict = ["winner":"false"]
    
    var counter = 0
    var counterTimer = Timer()
    var counterStartValue = 0
    var timerLabel:SKLabelNode!
    
    override func didMove(to view: SKView) {
        background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 2)
        background.zPosition = -1
        self.addChild(background)
        
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontName = "Palatino"
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: UIScreen.main.bounds.width - 340, y: UIScreen.main.bounds.height - 70)
        score = 0
        self.addChild(scoreLabel)
        
        
        timerLabel = SKLabelNode(text: "Time: \(counterStartValue)")
        timerLabel.fontName = "Palatino"
        timerLabel.fontSize = 24
        timerLabel.fontColor = UIColor.black
        timerLabel.position = CGPoint(x: UIScreen.main.bounds.width - 338, y: UIScreen.main.bounds.height - 90)
        self.addChild(timerLabel)
        
        addTarget()
        startCounter()
        
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
    
    @objc func addTarget() {
        let target = SKSpriteNode(imageNamed: "target")
        let randomPosX = GKRandomDistribution(lowestValue: 35, highestValue: 345)
        let randomPosY = GKRandomDistribution(lowestValue: 35, highestValue: 805)
        target.name = "newTarget"
        target.position = CGPoint(x: randomPosX.nextInt(), y: randomPosY.nextInt())
        target.size = CGSize(width: 64, height: 64)
        self.addChild(target)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "newTarget" && score != 10 {
                score += 1
            }
            if score == 10 {
                counterTimer.invalidate()
                stopGame = true
                gameOver()
            }
            if touchedNode.name == "newTarget" && stopGame != true {
                addTarget()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "newTarget" {
                touchedNode.removeFromParent()
            }
        }
    }
    
    func startCounter() {
        counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CounterPlus), userInfo: nil, repeats: true)
    }
    @objc func CounterPlus() {
        counter += 1
        timerLabel.text = "Time: \(counter)"
    }
    
    func gameOver() {
        NotificationCenter.default.post(name: Notification.Name("GameOver"), object: nil)
        if counter < 8 {
            winner = true
            dict = ["winner":"true"]
        }
        NotificationCenter.default.post(name: Notification.Name("WoL"), object: nil, userInfo: dict)
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: UIScreen.main.bounds.size)
        gameOverScene.winner = winner
        self.view?.presentScene(gameOverScene, transition: transition)
    }
}
