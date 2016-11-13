//
//  GameScene.swift
//  Demo55_Game
//
//  Created by BuiDuyTuan on 8/29/16.
//  Copyright (c) 2016 BuiDuyTuan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
//            
//            let node:SKEmitterNode = SKEmitterNode(fileNamed: "Lua.sks")!
//            node.position = location
//            addChild(node)
            //chuyen sang man hinh 2
            let manhinhden:SKScene = Scene2(size: (view?.bounds.size)!)
           
            self.view?.presentScene(manhinhden, transition: SKTransition.doorsOpenHorizontalWithDuration(1))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
