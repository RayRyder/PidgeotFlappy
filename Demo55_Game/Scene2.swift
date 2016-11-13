//
//  Scene2.swift
//  Demo55_Game
//
//  Created by BuiDuyTuan on 8/29/16.
//  Copyright © 2016 BuiDuyTuan. All rights reserved.
//

import SpriteKit

class Scene2: SKScene {

    override func didMoveToView(view: SKView) {
        var node:SKSpriteNode = SKSpriteNode(color: UIColor.blueColor(),size: CGSize(width: 50, height: 50))
        node.position = CGPoint(x: 100, y: 100)
        addChild(node)
   
    }
    
}
