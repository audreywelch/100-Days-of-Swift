//
//  GameScene.swift
//  11-Pachinko
//
//  Created by Audrey Welch on 11/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Pull out any screen touches from the touches set
        if let touch = touches.first {
            
            // Use its locatation(in:) method to find where the screen was touched in relation to self
            let location = touch.location(in: self)
            
            // Generate a node filled with red color
            let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
            
            // Add a physics body to the box that is a rectangle the same size as the box
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            
            // Set the new box's position to where the tap happened
            box.position = location
            
            // Add to the scene
            addChild(box)
        }
    }
}
