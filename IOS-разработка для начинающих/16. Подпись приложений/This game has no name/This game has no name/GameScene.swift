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
    
    private var GamerHalo: SKShapeNode?

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
        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(FuncGamerHalo), SKAction.wait(forDuration: 0.25)])))
//        run(SKAction.repeatForever(SKAction.sequence( [SKAction.run(Surprise), SKAction.wait(forDuration: 0.25)])))
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
    func CreateGamerHalo(delay: TimeInterval, wScale: CGFloat, hScale: CGFloat, ColorHalo: CGColor, X: Int, Y: Int) {
        let w = (self.size.width + self.size.height) * 0.05
        self.GamerHalo = SKShapeNode.init(rectOf: CGSize.init(width: w * wScale, height: w * hScale), cornerRadius: w / 2.5)
        if let playerSpinnyNode = self.GamerHalo {
            playerSpinnyNode.lineWidth = 2.25
            playerSpinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: delay)))
            playerSpinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: delay),SKAction.fadeOut(withDuration: delay),
            SKAction.removeFromParent()]))
        }
        if let halo = self.GamerHalo?.copy() as! SKShapeNode? {
            halo.strokeColor = SKColor.init(cgColor: ColorHalo)
                halo.position = gamer.position
                self.addChild(halo)
                halo.run(SKAction.move(by: CGVector(dx: X, dy: Y), duration: delay))
        }
    }
    func FuncGamerHalo() {
        if self.points >= 5 && self.points <= 10 {
            CreateGamerHalo(delay: 1/4, wScale: 1.25, hScale: 1.25, ColorHalo: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), X: 0, Y: 0)
        } else if self.points >= 10 && points <= 20 {
            CreateGamerHalo(delay: 1/3, wScale: 1.25, hScale: 1.25, ColorHalo: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), X: 0, Y: 0)
            CreateGamerHalo(delay: 1/4, wScale: 1.20, hScale: 1.20, ColorHalo: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), X: -50, Y: 0)
        } else if points >= 20 && points <= 30 {
            CreateGamerHalo(delay: 1/4, wScale: 1.25, hScale: 1.25, ColorHalo: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), X: 0, Y: 0)
            CreateGamerHalo(delay: 1/4, wScale: 1.20, hScale: 1.20, ColorHalo: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), X: -50, Y: 0)
            CreateGamerHalo(delay: 1/5, wScale: 1.15, hScale: 1.15, ColorHalo: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), X: -75, Y: 0)
        } else if points >= 30 && points <= 40 {
            CreateGamerHalo(delay: 1/4, wScale: 1.25, hScale: 1.25, ColorHalo: #colorLiteral(red: 0.5882352941, green: 0, blue: 0.5882352941, alpha: 1), X: 0, Y: 0)
            CreateGamerHalo(delay: 1/4, wScale: 1.20, hScale: 1.20, ColorHalo: #colorLiteral(red: 0.3921568627, green: 0, blue: 0.5882352941, alpha: 1), X: -50, Y: 0)
            CreateGamerHalo(delay: 1/5, wScale: 1.15, hScale: 1.15, ColorHalo: #colorLiteral(red: 0.2174631357, green: 0, blue: 0.6803928018, alpha: 1), X: -80, Y: 0)
        } else if points >= 40 && points <= 50 {
            CreateGamerHalo(delay: 1/4, wScale: 1.25, hScale: 1.25, ColorHalo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), X: 0, Y: 0)
            CreateGamerHalo(delay: 1/4, wScale: 1.20, hScale: 1.20, ColorHalo: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), X: -50, Y: 0)
            CreateGamerHalo(delay: 1/4, wScale: 1.15, hScale: 1.15, ColorHalo: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), X: -75, Y: 0)
            CreateGamerHalo(delay: 1/5, wScale: 1.10, hScale: 1.10, ColorHalo: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), X: -100, Y: 0)
        } else if points >= 50 && points <= 60 {
            CreateGamerHalo(delay: 1/5, wScale: 1.25, hScale: 1.25, ColorHalo: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), X: 0, Y: 0)
            CreateGamerHalo(delay: 1/4, wScale: 1.20, hScale: 1.20, ColorHalo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), X: -50, Y: 0)
            CreateGamerHalo(delay: 1/3, wScale: 1.15, hScale: 1.15, ColorHalo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), X: -75, Y: 0)
            CreateGamerHalo(delay: 1/2, wScale: 1.10, hScale: 1.10, ColorHalo: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), X: -100, Y: 0)
            CreateGamerHalo(delay: 1/1, wScale: 1.05, hScale: 1.05, ColorHalo: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), X: -125, Y: 0)
        } else if points >= 60 {
            CreateGamerHalo(delay: 1/6, wScale: 1.25, hScale: 1.25, ColorHalo: #colorLiteral(red: 0.8823529412, green: 0, blue: 0.1960784314, alpha: 1), X: 0, Y: 0)
            CreateGamerHalo(delay: 1/5, wScale: 1.20, hScale: 1.20, ColorHalo: #colorLiteral(red: 0.7843137255, green: 0, blue: 0.1960784314, alpha: 1), X: -50, Y: 0)
            CreateGamerHalo(delay: 1/4, wScale: 1.15, hScale: 1.15, ColorHalo: #colorLiteral(red: 0.6862745098, green: 0, blue: 0.1960784314, alpha: 1), X: -75, Y: 0)
            CreateGamerHalo(delay: 1/3, wScale: 1.10, hScale: 1.10, ColorHalo: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), X: -100, Y: 0)
            CreateGamerHalo(delay: 1/2, wScale: 1.05, hScale: 1.05, ColorHalo: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), X: -133, Y: 0)
            CreateGamerHalo(delay: 1/1, wScale: 1.00, hScale: 1.00, ColorHalo: #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), X: -166, Y: 0)
        }
    }
    func Surprise() {
        let n = sqrt(Double(points))
        if n == 5 || n == 10 || n == 15 || n == 20 {
            self.gamer.isHidden = true
        } else {
            self.gamer.isHidden = false
        }
    }
}
