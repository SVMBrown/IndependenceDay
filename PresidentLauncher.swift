//
//  PresidentLauncher.swift
//  PresidentShooter
//
//  Created by Scot Brown on 2015-04-16.
//  Copyright (c) 2015 Scot Brown. All rights reserved.
//

import Foundation
import SpriteKit

class PresidentLauncher: SKNode {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let amount = 7
    let impulse = CGVector(dx: 300, dy: 550)
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
    func launch() {
        let pres = President()
        //should automatically generate at 0, 0
        addChild(pres)
        pres.physicsBody?.applyImpulse(impulse)
    }
    func update(currentTime: CFTimeInterval) {
        if children.count < amount {
            if readyToLaunch {
                launch()
                readyToLaunch = false
                self.runAction(delay)
                
            }
        }
        enumerateChildNodesWithName("*") {
            node, stop in
            if let foundChild = node {
                if foundChild.position.y + self.position.y < 0 {
                    foundChild.removeFromParent()
                }
            }
        }
    }
}