import SpriteKit
import GameplayKit

enum PhysicsCategory: UInt32 {
    case null = 0
    case gamer = 1
    case object = 2
    case death = 100
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var pointslabel: SKLabelNode?
    private var playerSpinnyNode: SKShapeNode?
    
    private var GamerHalo1: SKShapeNode?
    private var GamerHalo2: SKShapeNode?
    private var GamerHalo3: SKShapeNode?
    private var GamerHalo4: SKShapeNode?
    
    private var ObjectRedHalo: SKShapeNode?
    private var ObjectGreenHalo: SKShapeNode?
    private var ObjectBlueHalo: SKShapeNode?
    
    private var audio: SKAudioNode?
            
    private var death: SKNode?
    private var gamer: SKSpriteNode!
    
    private var points = 0
    private var RightObjectCount = 0
    private var LeftObjectCount = 0
                    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero // отмена гравитации
        physicsWorld.contactDelegate = self
        
        self.death = self.childNode(withName: "death")
        self.pointslabel = self.childNode(withName: "//pointslabel") as? SKLabelNode

// MARK: Счетчик
        if (UIScreen.main.bounds.height / UIScreen.main.bounds.width) < 1.4 {
            self.pointslabel?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY / 2)
            self.pointslabel?.fontSize = 100
        } else if (UIScreen.main.bounds.height / UIScreen.main.bounds.width) < 1.8 {
            self.pointslabel?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY / 1.5)
            self.pointslabel?.fontSize = 125
        } else if (UIScreen.main.bounds.height / UIScreen.main.bounds.width) > 2 {
            self.pointslabel?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY / 1.5)
            self.pointslabel?.fontSize = 150
        }
        createPlayer()
        repeatForever()
    }
    
    func createPlayer() {
      gamer = SKSpriteNode(imageNamed: "background")
      gamer.position = CGPoint(x: 0, y: 0)
      gamer.size = (CGSize(width: 100, height: 100))
      gamer.zPosition = 1
      gamer.physicsBody = SKPhysicsBody(circleOfRadius: gamer.size.width / 2)
      gamer.physicsBody?.allowsRotation = false
      gamer.physicsBody?.linearDamping = 0.5

      gamer.physicsBody?.isDynamic = true
      gamer.physicsBody?.categoryBitMask = PhysicsCategory.gamer.rawValue
      gamer.physicsBody?.contactTestBitMask = PhysicsCategory.object.rawValue
      gamer.physicsBody?.collisionBitMask = PhysicsCategory.null.rawValue
      gamer.physicsBody?.usesPreciseCollisionDetection = true

      self.playerSpinnyNode = self.childNode(withName: "playerSpinnyNode") as? SKShapeNode
      gamer.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(-Double.pi), duration: 0.5))) // Пассивная вертушка при старте
      addChild(gamer)
    }
    
    func repeatForever() {
        func random1() -> CGFloat { return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF)) }
        func random2(min: CGFloat, max: CGFloat) -> CGFloat { return random1() * (max - min) + min }
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(CreateRightObject), SKAction.wait(forDuration: 1)])))
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(CreateLeftObject), SKAction.wait(forDuration: 1)])))
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(HaloGamer1), SKAction.wait(forDuration: 0.25)])))
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(HaloGamer2), SKAction.wait(forDuration: 0.25)])))
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(HaloGamer3), SKAction.wait(forDuration: 0.25)])))
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(HaloGamer4), SKAction.wait(forDuration: 0.25)])))
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(Surprise), SKAction.wait(forDuration: 0.25)])))
    }
    
// MARK: -- CreateRightObject
    func CreateRightObject() {
        if points > 0 {
        let RightObject = SKSpriteNode(imageNamed: "RightObject")
        
        let randomHeight = CGFloat.random(in: ((self.frame.minY / 1.5)...(self.frame.maxY / 1.5))) // рандом по выcоте
        RightObject.position = CGPoint(x: self.frame.maxX + RightObject.size.width, y: randomHeight) // откуда летят
        
        let delay = TimeInterval(1)

        // куда летят // (gamer.position.y)! - в игрока
        let actionMove = SKAction.move(to: CGPoint(x: self.frame.minX, y: randomHeight), duration: delay)
        
        // уничтожение
        let actionMoveDone = SKAction.removeFromParent()
        RightObject.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        addChild(RightObject)
        
        RightObject.size = (CGSize(width: 100, height: 100))
        RightObject.physicsBody = SKPhysicsBody(rectangleOf: RightObject.size) // привязать к размерам объекта
        RightObject.physicsBody?.isDynamic = true
        RightObject.physicsBody?.categoryBitMask = PhysicsCategory.object.rawValue // приоритет
        RightObject.physicsBody?.contactTestBitMask = PhysicsCategory.gamer.rawValue // касание с игроком
        RightObject.physicsBody?.collisionBitMask = PhysicsCategory.null.rawValue

            if points > 15 {
                RightObject.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: delay / 4)))
            }
        }
    }
    
// MARK: -- CreateLeftObject
    func CreateLeftObject() {
        if points > 20 {
        let LeftObject = SKSpriteNode(imageNamed: "LeftObject")

        let randomHeight = CGFloat.random(in: ((self.frame.minY / 1.5)...(self.frame.maxY / 1.5)))
        LeftObject.position = CGPoint(x: self.frame.minX - LeftObject.size.width, y: randomHeight)
        
        let delay = TimeInterval(1)

        let actionMove = SKAction.move(to: CGPoint(x: self.frame.maxX, y: randomHeight), duration: delay)
        
        let actionMoveDone = SKAction.removeFromParent()
        LeftObject.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        addChild(LeftObject)

        LeftObject.size = (CGSize(width: 100, height: 100))
        LeftObject.physicsBody = SKPhysicsBody(rectangleOf: LeftObject.size)
        LeftObject.physicsBody?.isDynamic = true
        LeftObject.physicsBody?.categoryBitMask = PhysicsCategory.object.rawValue
        LeftObject.physicsBody?.contactTestBitMask = PhysicsCategory.gamer.rawValue
        LeftObject.physicsBody?.collisionBitMask = PhysicsCategory.null.rawValue
            
            if points > 30 {
                LeftObject.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: delay / 4)))
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {    }
    
    func touchMoved(toPoint pos : CGPoint) {    }

// MARK: touchUp
    func touchUp(atPoint pos : CGPoint) {
        if points >= 0 {
            points += 1
            gamer.physicsBody!.applyImpulse(CGVector(dx: 0, dy: +100))
            gamer.run(SKAction.rotate(byAngle: CGFloat(-Double.pi), duration: 0.5)) // вертушка
        }
    }

// MARK: -- Для регистрации касаний (НЕ УДАЛЯТЬ!)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
// MARK: -- GameOver
    func GameOver(gamer: SKSpriteNode, object: SKSpriteNode) {
        gamer.removeFromParent()
        points = 0
        createPlayer()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
         var firstBody: SKPhysicsBody
         var secondBody: SKPhysicsBody
         if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
           firstBody = contact.bodyA
           secondBody = contact.bodyB
         } else {
           firstBody = contact.bodyB
           secondBody = contact.bodyA
         }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.object.rawValue != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.gamer.rawValue != 0)) {
           if let object = firstBody.node as? SKSpriteNode,
            let gamer = secondBody.node {
            
            GameOver(gamer: gamer as! SKSpriteNode, object: object)
           }
         }
    }

// MARK: update
    override func update(_ currentTime: TimeInterval) {
        pointslabel?.text = "\(points)"
        if points > 0 {
            gamer.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -5))
        }
    }

    // MARK: -- HALO
    func HaloGamer1() {
        if points > 20 {
        let delay = TimeInterval(0.25)
        let w = (self.size.width + self.size.height) * 0.05
            self.GamerHalo1 = SKShapeNode.init(rectOf: CGSize.init(width: w * 1.05, height: w * 1.05), cornerRadius: w / 2.5)
        if let playerSpinnyNode = self.GamerHalo1 {
            playerSpinnyNode.lineWidth = 2.5
            playerSpinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: delay))) // время оборота
            playerSpinnyNode.run(SKAction.sequence([
            SKAction.wait(forDuration: delay * 6),
            SKAction.fadeOut(withDuration: delay * 6),
            SKAction.removeFromParent()]))
        }
        if let halo = self.GamerHalo1?.copy() as! SKShapeNode? {
            halo.position = CGPoint(x: gamer.frame.midX, y: gamer.frame.midY)
            halo.run(SKAction.move(by: CGVector(dx: self.frame.minX - halo.frame.width, dy: self.frame.midY), duration: delay * 10))
            halo.strokeColor = SKColor.init(cgColor: #colorLiteral(red: 0.9608287215, green: 0.2057597637, blue: 0.02833223902, alpha: 1))
                self.addChild(halo)
            }
        }
    }
    
    func HaloGamer2() {
        if points >= 15 && points <= 20 {
        let delay = TimeInterval(0.5)
        let w = (self.size.width + self.size.height) * 0.05
            self.GamerHalo2 = SKShapeNode.init(rectOf: CGSize.init(width: w * 1.10, height: w * 1.10), cornerRadius: w / 2.66)
        if let playerSpinnyNode = self.GamerHalo2 {
            playerSpinnyNode.lineWidth = 2.5
            playerSpinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: delay)))
            playerSpinnyNode.run(SKAction.sequence([
            SKAction.wait(forDuration: delay * 2),
            SKAction.fadeOut(withDuration: delay * 2),
            SKAction.removeFromParent()]))
        }
            if let halo = self.GamerHalo2?.copy() as! SKShapeNode? {
                halo.run(SKAction.move(by: CGVector(dx: self.frame.minX - halo.frame.width, dy: self.frame.midY), duration: delay * 4))
                halo.position = CGPoint(x: gamer.frame.midX, y: gamer.frame.midY)
                halo.strokeColor = SKColor.init(cgColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
                  self.addChild(halo)
            }
        }
    }
    func HaloGamer3() {
        if points >= 10 && points <= 15 {
        let delay = TimeInterval(0.75)
        let w = (self.size.width + self.size.height) * 0.05
            self.GamerHalo3 = SKShapeNode.init(rectOf: CGSize.init(width: w * 1.15, height: w * 1.15), cornerRadius: w / 2.75)
        if let playerSpinnyNode = self.GamerHalo3 {
            playerSpinnyNode.lineWidth = 2.5
            playerSpinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: delay)))
            playerSpinnyNode.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.75),
            SKAction.fadeOut(withDuration: 0.75),
            SKAction.removeFromParent()]))
        }
        if let halo = self.GamerHalo3?.copy() as! SKShapeNode? {
            halo.run(SKAction.move(by: CGVector(dx: self.frame.minX - halo.frame.width, dy: self.frame.midY), duration: delay * 2))
            halo.position = CGPoint(x: gamer.position.x, y: gamer.position.y)
            halo.strokeColor = SKColor.init(cgColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                self.addChild(halo)
            }
        }
    }
    func HaloGamer4() {
        if points > 5 && points <= 10 {
        let delay = TimeInterval(1)
        let w = (self.size.width + self.size.height) * 0.05
            self.GamerHalo4 = SKShapeNode.init(rectOf: CGSize.init(width: w * 1.2, height: w * 1.2), cornerRadius: w / 3)
        if let playerSpinnyNode = self.GamerHalo4 {
            playerSpinnyNode.lineWidth = 2.5
            playerSpinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: delay)))
            playerSpinnyNode.run(SKAction.sequence([
            SKAction.wait(forDuration: delay / 2),
            SKAction.fadeOut(withDuration: delay / 2),
            SKAction.removeFromParent()]))
        }
        if let halo = self.GamerHalo4?.copy() as! SKShapeNode? {
            halo.run(SKAction.move(by: CGVector(dx: self.frame.minX - halo.frame.width, dy: self.frame.midY), duration: delay))
            halo.position = CGPoint(x: gamer.position.x, y: gamer.position.y)
            halo.strokeColor = SKColor.init(cgColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                self.addChild(halo)
            }
        }
    }
    func Surprise() {
        if points >= 10 && points <= 11 {
            gamer.isHidden = true
        } else if points >= 20 && points < 21 {
            gamer.isHidden = true
        } else if points >= 30 && points < 31 {
            gamer.isHidden = true
        } else {
            gamer.isHidden = false
        }
    }
}
