//
//  Firework.swift
//  PresidentShooter
//
//  Created by Scot Brown on 2015-04-16.
//  Copyright (c) 2015 Scot Brown. All rights reserved.
//

import Foundation
import SpriteKit
let colors = [
    UIColor.redColor(),
    UIColor.yellowColor(),
    UIColor.blueColor(),
    UIColor.whiteColor()
]
class Firework: SKSpriteNode {
    var origin = CGPoint(x: 20, y: 20)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        let texture = SKTexture(imageNamed: "Firework")
        let size = CGSize(width: 30, height: 90)
        super.init(texture: texture, color: nil, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.mass = 1.0
        self.physicsBody!.dynamic = true
        self.physicsBody!.linearDamping = 0.0
        self.physicsBody!.angularDamping = 0.0
        self.physicsBody!.categoryBitMask = 1
        self.physicsBody!.contactTestBitMask = 2
    }
    func launch(vec: CGVector) {
        let rate = NSTimeInterval(0.1)
        var propel = SKAction.moveBy(vec, duration: rate)
        runAction(SKAction.repeatActionForever(propel))
        let propulsion = SKEmitterNode(fileNamed: "Propulsion")
        addChild(propulsion)
        propulsion.position = CGPoint(x: 0, y: -40)
    }
    func explode() {
        let particles = SKEmitterNode(fileNamed: "explosion")
        parent!.addChild(particles)
        particles.position = position
        particles.particleColorSequence = nil
        particles.particleColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        let wait = SKAction.waitForDuration(0.3)
        let stop = SKAction.runBlock {
            particles.particleBirthRate = 0
        }
        let kill = SKAction.runBlock {
            particles.removeFromParent()
        }
        particles.runAction(SKAction.sequence([wait, stop, wait, kill]))
        self.removeFromParent()
        
    }
}