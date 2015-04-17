//
//  GameScene.swift
//  PresidentShooter
//
//  Created by Scot Brown on 2015-04-15.
//  Copyright (c) 2015 Scot Brown. All rights reserved.
//

import SpriteKit

/*
Enumeration for bitmasks: President, Cannon, Projectile
*/

class GameScene: SKScene, SKPhysicsContactDelegate {
    var score = [String: Int]()
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //println("Scene Created")
        /*
        Add Scorekeeper, Cannon, and Start President Generation(?)
        */
        backgroundColor = UIColor.grayColor()
        let rocket = Launcher()
        rocket.position = CGPoint(x: self.frame.size.width/2, y: 20)
        rocket.name = "ROCKET"
        addChild(rocket)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        var presNode = PresidentLauncher()
        presNode.position = CGPoint(x: self.frame.size.width/6, y: self.frame.size.height/2)
        addChild(presNode)
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        // Called auto
        
        /*
        If Pres x Projectile
        Destroy pres and explode Projectile
        */
        var fireworkBody:SKPhysicsBody?
        var presidentBody:SKPhysicsBody?
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            fireworkBody = contact.bodyA
            presidentBody = contact.bodyB
        } else {
            fireworkBody = contact.bodyB
            presidentBody = contact.bodyA
        }
        if let firework = fireworkBody?.node as? Firework {
            firework.explode()
        }
        if let pres = presidentBody?.node as? President {
            if let node = childNodeWithName("label") as? SKLabelNode {
                node.removeFromParent()
            }
            var name = pres.name
            if score[name!] != nil {
                score[name!]! += 1
            } else {
                score[name!] = 1
            }
            var label = SKLabelNode(text: "\(name!): \(score[name!]!) times!")
            label.name = "label"
            label.fontName = "Impact"
            label.fontSize = 28
            label.color = UIColor.whiteColor()
            addChild(label)
            label.position = CGPoint(x: self.frame.size.width/2, y: (self.frame.size.height * 11/12))
            
        }
        presidentBody?.node?.removeFromParent()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if let node = childNodeWithName("ROCKET") as? Launcher {
                node.launch(location)
            }
            
        }
        
        /*
        rotate cannon and fire projectile towards touch, with a small cooldown
        */
        
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //println("new frame")
        self.enumerateChildNodesWithName("*") {
            node, stop in
            if let foundLaunch = node as? PresidentLauncher {
                foundLaunch.update(currentTime)
            }
        }
    }
}
