import SceneKit
import GameplayKit

class GameOverScene: SKScene {
    let header = SKLabelNode(fontNamed: "Chalkduster")
    let hint = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        header.text = "Game Over"
        header.position = CGPoint(x: frame.midX, y: frame.midY+header.fontSize)
        header.fontSize = 32
        self.addChild(header)
        
        hint.text = "press the screen\nto again start the game"
        hint.position = CGPoint(x: header.frame.midX, y: frame.midY-header.frame.height)
        hint.fontSize = 24
        hint.numberOfLines = 0
        
        // wtf? почему текст не центрируется по горизонтали??
        hint.verticalAlignmentMode = .center
        hint.horizontalAlignmentMode = .center
        self.addChild(hint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let scene = GameScene(size: frame.size)
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(scene, transition: transition)
        self.removeFromParent()
    }
}
