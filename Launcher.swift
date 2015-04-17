//
//  Launcher.swift
//  PresidentShooter
//
//  Created by Scot Brown on 2015-04-16.
//  Copyright (c) 2015 Scot Brown. All rights reserved.
//

import Foundation
import SpriteKit

class Launcher: SKNode {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let amount = 1
    var readyToLaunch = false
    var delay:SKAction = SKAction.waitForDuration(NSTimeInterval(0))
    override init() {
        super.init()
        readyToLaunch = true
        let wait = SKAction.waitForDuration(0.6)
        let run = SKAction.runBlock {
            self.readyToLaunch = true
        }
        delay = SKAction.sequence([wait, run])
    }
    func rotate(towards: CGPoint) {
        var deltax = towards.x - position.x
        var deltay = towards.y - position.y
        var angle = atan(deltay/deltax) + CGFloat(M_PI / 2)
        if deltax >= 0 {
            angle += CGFloat(M_PI)
        }
        self.zRotation = angle
    }
    func vectorAtAngle(magnitude m: CGFloat) -> CGVector{
        let angle = CGFloat(zRotation) + CGFloat(M_PI / 2)
        let x = m * cos(angle)
        let y = m * sin(angle)
        return CGVector(dx: x, dy: y)
    }
    func launch(towards: CGPoint) {
        rotate(towards)
        let launchVector = vectorAtAngle(magnitude: 30)
        let firework = Firework()
        firework.position = position
        firework.zRotation = zRotation
        parent!.addChild(firework)
        firework.launch(launchVector)
    }
}