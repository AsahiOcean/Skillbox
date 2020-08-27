import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        
        skView.showsPhysics = false // границы объектов
        skView.showsFPS = true // частота обновлений сцены
        skView.showsNodeCount = true // число объектов на сцене
        skView.ignoresSiblingOrder = true // для оптимизации рендеринга
        
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
}
