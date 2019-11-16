//
//  GameScene.swift
//  11-Pachinko
//
//  Created by Audrey Welch on 11/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        // Set background image
        let background = SKSpriteNode(imageNamed: "background.jpg")
        
        // SpriteKit positions things based on their center
        background.position = CGPoint(x: 512, y: 384)
        
        // Good for things without gaps, such as the background - ignore any alpha values
        background.blendMode = .replace
        
        // Should be behind everything else
        background.zPosition = -1
        
        // Add node to current screen
        addChild(background)
        
        // Ad a physics body to the whole scene that is a line on each edge
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Pull out any screen touches from the touches set
        if let touch = touches.first {
            
            // Use its locatation(in:) method to find where the screen was touched in relation to self
            let location = touch.location(in: self)
            
            // Generate a node filled with an image
            let ball = SKSpriteNode(imageNamed: "ballRed")
            
            // Add a physics body to the ball that is a circle half the size as the image
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            
            ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
            
            // Bounciness level - 0 to 1
            ball.physicsBody?.restitution = 0.4
            
            // Set the new ball's position to where the tap happened
            ball.position = location
            
            ball.name = "ball"
            
            // Add to the scene
            addChild(ball)
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        
        // Centered horizontally on the bottom edge of teh scene
        // bouncer.position = CGPoint(x: 512, y: 0)
        
        bouncer.position = position
        
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        
        // When true, the object will be moved by the physics simulator based on gravity & collisions
        // When false, the object will still collide with other things, but won't be moved
        // as a result
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        
        if object.name == "good" {
            destroy(ball: ball)
        } else if object.name == "bad" {
            destroy(ball: ball)
        }
    }
    
    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if contact.bodyA.node?.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if contact.bodyB.node?.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
