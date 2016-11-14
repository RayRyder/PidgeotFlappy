//
//  GameScene.swift
//  Demo54_GameFlappyBird
//
//  Created by BuiDuyTuan on 8/29/16.
//  Copyright (c) 2016 BuiDuyTuan. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    enum VaCham:UInt32{
        case player = 1
        case ongnuoc = 2
        case score = 3
        case grass = 4
    }
    
    var Player:SKSpriteNode!
    var background:SKSpriteNode = SKSpriteNode(imageNamed: "bg.jpg")
    var ONST:[SKSpriteNode] = []
    var ONSD:[SKSpriteNode] = []
    var nodeScore:SKNode!
    var timer:NSTimer!
    var status:Bool = true
    var label:SKLabelNode!
    var buttonAgain:SKSpriteNode!
    var score:Int32 = 0
    var lblScore:SKLabelNode!
    var lblHighScore:SKLabelNode!
    var highScore:Int = 0
    var started:Bool = false
    var logoGame:SKSpriteNode!
    var nameGame:SKLabelNode!
    var gifBird:SKSpriteNode!
    var taptoplay:SKSpriteNode!
    var grass:[SKSpriteNode] = []
    var gifThrow:SKSpriteNode!
    var gifOpenBall:SKSpriteNode!
    var gifBallFly:SKSpriteNode!
    var actionPlayBGSound:AVAudioPlayer!
    var actionHitSound:SKAction!
    var actionJumpSound:SKAction!
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        //self.view?.showsPhysics = true
        
        loadBackGround()
        flashScren()
        //if
        if NSUserDefaults.standardUserDefaults().objectForKey("highscore") != nil {
        highScore = NSUserDefaults.standardUserDefaults().objectForKey("highscore") as! Int
        }
        //starGame()
        //Code tren mang
        //        let fadeOut = SKAction.sequence([SKAction.waitForDuration(3.0)])
        //
        //        let welcomeReturn = SKAction.runBlock({
        //            let Transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
        //            let welcomeScene = GameScene(fileNamed: "GameScene")
        //            welcomeScene!.scaleMode = .AspectFill
        //            self.scene!.view?.presentScene(welcomeScene!, transition: Transition)
        //        })
        //
        //        let sequence = SKAction.sequence([fadeOut, welcomeReturn])
        //        self.runAction(sequence)
        
    }
    func saveHighScore(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(Int(highScore), forKey: "highscore")
        userDefaults.synchronize()
    }
    func flashScren(){
        logoGame = SKSpriteNode(imageNamed: "logogame")
        logoGame.position = CGPoint(x: self.size.width/2 - 5, y: self.size.height * 0.7)
        logoGame.size = CGSize(width: 200, height: 70)
        addChild(logoGame)
        
        nameGame = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        nameGame.text = "Flappy Pidgeot"
        nameGame.fontSize = 24
        nameGame.zPosition = 10
        nameGame.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.6)
        addChild(nameGame)
        
        taptoplay = SKSpriteNode(imageNamed: "taptoplay")
        taptoplay.zPosition = 10
        taptoplay.size = CGSize(width: 200, height: 50)
        taptoplay.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.3)
        taptoplay.name = "taptoplay"
        addChild(taptoplay)
        
        
        var gifTextures: [SKTexture] = [];
        
        for i in 0...52 {
            gifTextures.append(SKTexture(imageNamed: "frame_\(i)_delay-0.03s.gif"));
            //gifTextures[ i - 1 ].filteringMode = .Nearest
        }
        let anim = SKAction.animateWithTextures(gifTextures, timePerFrame: 0.03)
        let flap = SKAction.repeatActionForever(anim)
        gifBird = SKSpriteNode(texture: gifTextures[0])
        gifBird.runAction(flap)
        gifBird.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.5)
        gifBird.size = CGSize(width: 100, height: 100)
        addChild(gifBird)
        
        
        
    }
    func PokeBallFly(){
        gifBallFly = SKSpriteNode(texture: SKTexture(imageNamed: "Pokeball.gif"))
        //gifOpenBall.runAction(anim2)
        gifBallFly.position = CGPoint(x: self.size.width/2 - 10, y: self.size.height * 0.4)
        gifBallFly.size = CGSize(width: 15, height: 15)
        addChild(gifBallFly)
        
    }
    
    func openPokeBall(){
        
        
        var gifTextures2: [SKTexture] = [];
        
        for i in 0...14 {
            gifTextures2.append(SKTexture(imageNamed: "frame_\(i)_delay-0.1s.gif"));
            //gifTextures[ i - 1 ].filteringMode = .Nearest
        }
        let anim2 = SKAction.animateWithTextures(gifTextures2, timePerFrame: 0.1)
        //let flap1 = SKAction.repeatActionForever(anim1)
        gifOpenBall = SKSpriteNode(texture: gifTextures2[0])
        gifOpenBall.runAction(anim2)
        gifOpenBall.position = CGPoint(x: self.size.width/2 - 10, y: self.size.height * 0.5)
        gifOpenBall.size = CGSize(width: 50, height: 50)
        addChild(gifOpenBall)
        gifBallFly.removeFromParent()
        let actionPlaySound:SKAction = SKAction.playSoundFileNamed("pidgeot2.mp3", waitForCompletion: false)
        self.runAction(actionPlaySound)
        
    }
    func throwPokeBall(){
        var gifTextures1: [SKTexture] = [];
        for i in 0...4 {
            gifTextures1.append(SKTexture(imageNamed: "trback000_0\(i + 1).gif"));
                    }
        let anim1 = SKAction.animateWithTextures(gifTextures1, timePerFrame: 0.15)
        //let flap1 = SKAction.repeatActionForever(anim1)
        gifThrow = SKSpriteNode(texture: gifTextures1[0])
        gifThrow.runAction(anim1)
        gifThrow.position = CGPoint(x: self.size.width/4, y: self.size.height * 0.1)
        gifThrow.size = CGSize(width: 200, height: 200)
        addChild(gifThrow)
        NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: "PokeBallFly", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "openPokeBall", userInfo: nil, repeats: false)
    }
    
    func starGame(){
        view?.userInteractionEnabled = false
        
        throwPokeBall()
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "createPlayer", userInfo: nil, repeats: false)
        //createPlayer()
        createONS()
        createScore()
        createContactNodeScore()
        
        
    }
    
    func createScore(){
        lblScore = SKLabelNode(fontNamed: "Copperplate")
        lblScore.text = "Score: \(score)"
        lblScore.fontSize = 24
        lblScore.zPosition = 10
        lblScore.position = CGPoint(x: self.size.width/2 , y: self.size.height * 0.7)
        self.addChild(lblScore)
        lblHighScore = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        lblHighScore.text = "HighScore: \(highScore)"
        lblHighScore.fontSize = 20
        lblHighScore.zPosition = 10
        lblHighScore.position = CGPoint(x: self.size.width * 0.8 , y: self.size.height * 0.95)
        self.addChild(lblHighScore)
    }
    func loadBackGround() // You define the function and what it does
    {
        
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -20
        background.name = "background"
        background.size = self.scene!.size
        scene!.addChild(background)
        
        for i in 0...2 {
            grass.append(SKSpriteNode(imageNamed: "pasto"))
            grass[i].zPosition = 10
            grass[i].size = CGSize(width: self.size.width , height: 100)
            grass[i].position = CGPoint(x: (self.size.width - 10) * CGFloat(i) , y: 10)
            grass[i].name = "grass"
            addChild(grass[i])
            grass[i].physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: grass[i].size.width, height: grass[i].size.height/10))
            grass[i].physicsBody?.dynamic = false
            grass[i].physicsBody?.categoryBitMask = VaCham.grass.rawValue
            grass[i].physicsBody?.contactTestBitMask = VaCham.player.rawValue
        }
        let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("pokemongo", ofType: "mp3")!)
        do{
            actionPlayBGSound = try AVAudioPlayer(contentsOfURL:coinSound)
            actionPlayBGSound.prepareToPlay()
            actionPlayBGSound.numberOfLoops = -1
            actionPlayBGSound.play()
        }catch {
            print("Error getting the audio file")
        }

    }
    func createPlayer(){
        view?.userInteractionEnabled = true
        
        let birdTexture1 = SKTexture(imageNamed: "018")
        birdTexture1.filteringMode = .Nearest
        let birdTexture2 = SKTexture(imageNamed: "019")
        birdTexture2.filteringMode = .Nearest
        
        let anim = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.2)
        let flap = SKAction.repeatActionForever(anim)
        
        Player = SKSpriteNode(texture: birdTexture1)
        Player.setScale(2.0)
        Player.runAction(flap)
        
        Player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        Player.size = CGSize(width: 50, height: 50)
        addChild(Player)
        Player.physicsBody = SKPhysicsBody(circleOfRadius: Player.size.width/2 - 10)
        Player.physicsBody?.dynamic = true
        Player.physicsBody?.allowsRotation = false
        Player.physicsBody?.categoryBitMask = VaCham.player.rawValue
        Player.physicsBody?.contactTestBitMask = VaCham.ongnuoc.rawValue | VaCham.grass.rawValue
        
        gifThrow.runAction(SKAction.fadeOutWithDuration(1))
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameScene.removeGifThrow), userInfo: nil, repeats: false)
        started = true
    }
    func removeGifThrow(){
        gifThrow.removeFromParent()
        gifOpenBall.removeFromParent()
    }
    func random(min:CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    func createONS(){
        let theWidth:CGFloat = self.size.width/2
        let theHeight:CGFloat = self.size.height
        for i in 0...2{
            let theHeightRandom:CGFloat = random(-theHeight * 0.5  + 175, max: theHeight * 0.5 - 15)
            ONST.append(SKSpriteNode(imageNamed: "pipe" ))
            ONST[i].size = CGSize(width: 50, height: theHeight)
            ONST[i].position = CGPoint(x: theWidth * CGFloat(i+3) + 25, y: theHeight  - theHeightRandom + 150 )
            ONST[i].physicsBody = SKPhysicsBody(rectangleOfSize: ONST[i].size)
            ONST[i].physicsBody?.dynamic = true
            ONST[i].physicsBody?.affectedByGravity = false
            ONST[i].physicsBody?.categoryBitMask = VaCham.ongnuoc.rawValue
            ONST[i].physicsBody?.contactTestBitMask = VaCham.player.rawValue | VaCham.score.rawValue
            ONST[i].physicsBody?.collisionBitMask = 0
            addChild(ONST[i])
            ONSD.append(SKSpriteNode(imageNamed: "pipe" ))
            ONSD[i].size = CGSize(width: 50, height: theHeight)
            ONSD[i].position = CGPoint(x: theWidth * CGFloat(i+3) + 25, y: -theHeightRandom )
            ONSD[i].physicsBody = SKPhysicsBody(rectangleOfSize: ONSD[i].size)
            ONSD[i].physicsBody?.dynamic = true
            ONSD[i].physicsBody?.affectedByGravity = false
            ONSD[i].physicsBody?.categoryBitMask = VaCham.ongnuoc.rawValue
            ONSD[i].physicsBody?.contactTestBitMask = VaCham.player.rawValue
            ONSD[i].physicsBody?.collisionBitMask = 0
            addChild(ONSD[i])
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "moveON", userInfo: nil, repeats: true)
    }
    func createContactNodeScore(){
        //nodeScore = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 50, height: 50))
        nodeScore = SKNode()
        nodeScore.position = CGPointMake(75, CGRectGetMidY( self.frame ))
        nodeScore.physicsBody =  SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: self.frame.size.height))
        nodeScore.physicsBody?.dynamic = false
        nodeScore.physicsBody?.affectedByGravity = false
        nodeScore.physicsBody?.categoryBitMask =  VaCham.score.rawValue
        nodeScore.physicsBody?.contactTestBitMask = VaCham.ongnuoc.rawValue
        nodeScore.physicsBody?.collisionBitMask = 0
        addChild(nodeScore)
    }
    func moveON(){
        for i in 0...2{
            ONSD[i].position.x--
            ONST[i].position.x--
            grass[i].position.x--
            if ONSD[i].position.x <= -25 {
                ONSD[i].position.x = self.size.width * 1.5 - 25
            }
            if ONST[i].position.x <= -25 {
                ONST[i].position.x = self.size.width * 1.5 - 25
            }
            if grass[i].position.x <= -grass[i].size.width/2 {
                grass[i].position.x = self.size.width * 2
            }
        }
    }
    func didBeginContact(contact: SKPhysicsContact) {
        let contactA = contact.bodyA.categoryBitMask
        let contactB = contact.bodyB.categoryBitMask
        
        
        if (contactA == VaCham.player.rawValue && contactB == VaCham.ongnuoc.rawValue) || (contactB == VaCham.player.rawValue && contactA == VaCham.ongnuoc.rawValue) || (Player.position.y > self.size.height * 1.5 ) || (contactA == VaCham.player.rawValue && contactB == VaCham.grass.rawValue) || (contactB == VaCham.player.rawValue && contactA == VaCham.grass.rawValue) {
            Player.removeFromParent()
            //            (contact.bodyA.node as! SKSpriteNode).removeFromParent()
            //            (contact.bodyB.node as! SKSpriteNode).removeFromParent()
            actionHitSound = SKAction.playSoundFileNamed("sfx_hit", waitForCompletion: false)
            self.runAction(actionHitSound)
            self.removeActionForKey("Jump")
            label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
            label.text = "You Lose"
            label.fontSize = 30
            label.zPosition = 10
            label.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(label)
            buttonAgain = SKSpriteNode(imageNamed: "playagain")
            buttonAgain.zPosition = 10
            buttonAgain.size = CGSize(width: 200, height: 70)
            buttonAgain.position = CGPoint(x: label.position.x, y: label.position.y - buttonAgain.size.height - 10)
            buttonAgain.name = "ButtonAgain"
            self.addChild(buttonAgain)
            actionPlayBGSound.stop()
            status = false
            timer.invalidate()
        }
        if (contactA == VaCham.score.rawValue && contactB == VaCham.ongnuoc.rawValue) || (contactB == VaCham.score.rawValue && contactA == VaCham.ongnuoc.rawValue)  {
            score += 1
            lblScore.text = "Score: \(score/2 )"
            //Add a little visual feedback for the score increment
            lblScore.runAction(SKAction.sequence([SKAction.scaleTo(1.5, duration:NSTimeInterval(0.1)), SKAction.scaleTo(1.0, duration:NSTimeInterval(0.1))]))
        }
    }
    func action(){
        view?.userInteractionEnabled = true
    }
    
    func removeFlashScreen(){
        logoGame.removeFromParent()
        nameGame.removeFromParent()
        gifBird.removeFromParent()
        taptoplay.removeFromParent()
        starGame()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let nodePlayAgain = nodeAtPoint(location)
            
            if started == false {
                logoGame.runAction(SKAction.fadeOutWithDuration(0.6))
                nameGame.runAction(SKAction.fadeOutWithDuration(0.6))
                gifBird.runAction(SKAction.fadeOutWithDuration(0.6))
                taptoplay.runAction(SKAction.fadeOutWithDuration(0.6))
                NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: "removeFlashScreen", userInfo: nil, repeats: false)
            }
            //NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "action", userInfo: nil, repeats: false)
            if started == true {
                if status == true{
                actionJumpSound = SKAction.playSoundFileNamed("sound_point", waitForCompletion: false)
                self.runAction(actionJumpSound, withKey: "Jump")
                }
                Player.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
            }
            if status == false && nodePlayAgain.name == "ButtonAgain" {
                status = true
                self.removeAllChildren()
                label.removeFromParent()
                if Int(score/2) > highScore{
                    highScore = Int(score/2)
                    saveHighScore()
                    lblHighScore.position = CGPoint(x: lblScore.position.x, y: lblScore.position.y - 30 )
                }

                loadBackGround()
                starGame()
                lblHighScore.text = "HighScore: \(highScore)"
                score = 0
                lblScore.text = "Score: \(score )"
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
