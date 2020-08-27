import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let playerNode = SKShapeNode()
    let enemyNode = SKShapeNode()
    
    var scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        sceneSettings()
                
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY*0.90)
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
                
        self.playerSettings()
        addChild(playerNode)
        
        self.enemySettings()
        addChild(enemyNode)
    }
    
    func sceneSettings() {
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        sceneBody.pinned = true
        physicsBody = sceneBody
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.border
    }
    
    func playerSettings() {
        playerNode.name = "player"
        playerNode.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let v = self.size.width*0.20
        let rect = CGRect(x: -v/2, y: -v/2, width: v, height: v)
        let circle = UIBezierPath(ovalIn: rect)
        playerNode.path = circle.cgPath
        playerNode.fillColor = .systemGreen
        playerNode.lineWidth = 0
        
        // physicsBody settings
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: circle.bounds.size)
        playerNode.physicsBody?.isDynamic = true
        
        playerNode.physicsBody?.categoryBitMask = PhysicsCategory.player
        playerNode.physicsBody?.contactTestBitMask = PhysicsCategory.enemy
        playerNode.physicsBody?.contactTestBitMask = PhysicsCategory.border
        playerNode.physicsBody?.collisionBitMask = PhysicsCategory.border
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func enemySettings() {
        enemyNode.name = "enemy"
        enemyNode.position = .zero
        
        let v = self.size.width*0.15
        let rect = CGRect(x: -v/2, y: -v/2, width: v, height: v)
        let circle = UIBezierPath(ovalIn: rect)
        enemyNode.path = circle.cgPath
        enemyNode.fillColor = .systemRed
        enemyNode.lineWidth = 0
        
        // physicsBody settings
        enemyNode.physicsBody = SKPhysicsBody(rectangleOf: circle.bounds.size)
        enemyNode.physicsBody?.isDynamic = true
        
        enemyNode.physicsBody?.categoryBitMask = PhysicsCategory.enemy
        enemyNode.physicsBody?.contactTestBitMask = PhysicsCategory.player
        enemyNode.physicsBody?.collisionBitMask = PhysicsCategory.border
        enemyNode.physicsBody?.usesPreciseCollisionDetection = true
        
        self.pursuePlayer()
        self.enemySize()
    }
    
    func move(node: SKNode, to: CGPoint, duration: TimeInterval, completion: (() -> Void)? = nil) {
        self.score += 1
        let move = SKAction.move(to: to, duration: duration)
        node.run(move, completion: completion ?? { })
    }
        
    func pursuePlayer() {
        move(node: enemyNode, to: playerNode.position, duration: 1) { [unowned self] in
            self.pursuePlayer()
        }
    }

    func enemySize() {
        // каждые 5 секунд радиус круга противника должен увеличиваться на 1 px.
        self.enemyNode.xScale += 0.01
        self.enemyNode.yScale += 0.01
        enemyNode.run(SKAction.wait(forDuration: 5.0)) { [unowned self] in
            print("enemy radius: \((self.enemyNode.frame.size.width / 2) * CGFloat.pi)")
            self.enemySize()
            self.score += 1
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if (firstBody.categoryBitMask == PhysicsCategory.player) && (secondBody.categoryBitMask == PhysicsCategory.border) {
            print("player touched the wall")
        }

        if (firstBody.categoryBitMask == PhysicsCategory.player) && (secondBody.categoryBitMask == PhysicsCategory.enemy) {
            print("game over")
        }
    }

//MARK: -- Регистрация нажатий
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard location != .zero else { return }
        playerNode.run(SKAction.move(to: location, duration: 0.3))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard location != .zero else { return }
        // периодически touches выдает (0,0) и игрок улетает в угол, поэтому сделал через guard
        playerNode.run(SKAction.move(to: location, duration: 0.3))
    }
    
    override func didEvaluateActions() {
        super.didEvaluateActions()
        if playerNode.intersects(enemyNode) {
            let scene = GameOverScene(size: frame.size)
            let transition = SKTransition.flipHorizontal(withDuration: 0.3)
            view?.presentScene(scene, transition: transition)
            self.removeFromParent()
        }
    }

    override func update(_ currentTime: TimeInterval) { }
}
struct PhysicsCategory {
    static let player: UInt32 =  0x1 << 1
    static let enemy:  UInt32 = 0x1 << 2
    static let border: UInt32 = 0x1 << 3
}
