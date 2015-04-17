//
//  President.swift
//  PresidentShooter
//
//  Created by Scot Brown on 2015-04-16.
//  Copyright (c) 2015 Scot Brown. All rights reserved.
//

import Foundation
import SpriteKit
let bundle = NSBundle.mainBundle()
let path = bundle.pathForResource("presidents", ofType: "json")
let presidentData = NSData(contentsOfFile: path!)
let presidentJSON = JSON(data: presidentData!)
let presidents = presidentJSON["items"].arrayValue
var imageCache = [String: UIImage]()

func getImageFromURL(str: String)->UIImage {
    let url = NSURL(string: str)
    let data = NSData(contentsOfURL: url!)
    return UIImage(data: data!)!
}
class President: SKSpriteNode {
    /*
    Initializes with a random image from list
    */
    let image: UIImage?
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        let president = presidents[Int(arc4random_uniform(UInt32(presidents.count)))]
        let name = president["label"].stringValue
        if let img = imageCache[name] {
            image = img
        } else {
            image = getImageFromURL(president["imageURL"].stringValue)
        }
        let texture = SKTexture(image: image!)
        let size = CGSize(width: 50, height: 50)
        super.init(texture: texture, color: nil, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.physicsBody!.mass = 1
        self.physicsBody!.categoryBitMask = 2
        self.name = name
    }
}