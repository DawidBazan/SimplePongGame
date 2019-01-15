//
//  GameScene.swift
//  FirstSwiftGame
//
//  Created by BZN8 on 08/03/2018.
//  Copyright © 2018 BZN8. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var player = SKSpriteNode()
    var topLbl = SKLabelNode()
    var bottomLbl = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        topLbl = self.childNode(withName: "topLbl") as! SKLabelNode
        bottomLbl = self.childNode(withName: "bottomLbl") as! SKLabelNode
        
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        enemy = self.childNode(withName: "Enamy") as! SKSpriteNode
        player = self.childNode(withName: "Player") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx:20, dy:20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }

    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        bottomLbl.text = "\(score[0])"
    }
    
    func addScore(winnerPlayer: SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if winnerPlayer == player {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            
        }else if winnerPlayer == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        
        topLbl.text = "\(score[1])"
        bottomLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
        let location = touch.location(in: self)
        
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= player.position.y - 25 {
            addScore(winnerPlayer: enemy)
            
        }else if ball.position.y >= enemy.position.y + 25 {
            addScore(winnerPlayer: player)
        }
        
        
    }
}
