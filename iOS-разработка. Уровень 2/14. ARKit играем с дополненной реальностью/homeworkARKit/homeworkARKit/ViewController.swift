import UIKit
import SceneKit
import ARKit
//Skillbox
//Скиллбокс
/*
 Прочитайте отличную статью про геометрию в SceneKit: https://medium.com/@maxxfrazer/scenekit-geometry-part1-e5dca2156d8

 Разработайте свою игру, в которой при запуске в 3D AR пространстве будет генерироваться 100 кубов случайных цветов (6 любых цветов на ваш выбор). Внизу экрана есть панель, в которой можно выбрать один из этих цветов. По нажатию на экран в AR пространство вылетает шар выбранного цвета. При столкновении с кубом такого же цвета оба исчезают. При столкновении с кубом другого цвета должен исчезать только шар
*/

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var CollectionColor: UICollectionView!
    var boxes = 0
    /// Default color: systemRed
    var sphereColor: UIColor = .systemRed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set  the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //MARK: обязательно указать контакт делегат!
        sceneView.scene.physicsWorld.contactDelegate = self
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        self.drawAim()
        self.CollectionColor.delegate = self
    }
    
    func drawAim() {
        let path = UIBezierPath(ovalIn: CGRect(x: self.view.center.x - 10, y: self.view.center.y - 10, width: 20, height: 20))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = .none
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = #colorLiteral(red: 0.862745098, green: 0.07843137255, blue: 0.2352941176, alpha: 1)
        self.view.layer.addSublayer(shapeLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // обнаружение горизонтальной плоскости
        // configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
        
        Timer.scheduledTimer(withTimeInterval: Double.random(in: 1.0...2.0), repeats: true) { timer in
            self.boxes += 1
            
            let node = SCNNode()
            node.name = "box"
            let nodeForm = SCNBox(
                width:  CGFloat.random(in: 0.5...0.75),
                height: CGFloat.random(in: 0.5...0.75),
                length: CGFloat.random(in: 0.5...0.75),
                chamferRadius: 0)
            
            node.geometry = nodeForm
            let shape = SCNPhysicsShape(geometry: nodeForm, options: nil)
            node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
            node.physicsBody?.isAffectedByGravity = false
            
            // битовая маска для обнаружения столкновения
            node.physicsBody?.categoryBitMask = CollisionCategory.box.rawValue
            node.physicsBody?.contactTestBitMask = CollisionCategory.sphere.rawValue
            
            node.geometry?.firstMaterial?.diffuse.contents = colors.randomElement()!
            node.geometry?.firstMaterial?.isDoubleSided = true
            
            node.position = SCNVector3(
                x: Float.random(in: -7.5...7.5),
                y: Float.random(in: -7.5...7.5),
                z: Float.random(in: -7.5...7.5))
                        
            // оживляем кубы
            let action: SCNAction = SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1.0)
            let forever = SCNAction.repeatForever(action)
            node.runAction(forever)
            
            //self.boxNodeInfo(node: boxNode)
            self.sceneView.scene.rootNode.addChildNode(node)

            if self.boxes == 100 { timer.invalidate() }
        }
    }
        
    func boxNodeInfo(node: SCNNode) {
        print("– * – * – * – Сreate node №\(boxes) 🥳 - * – * – * – ")
        print(node.position)
        print(node.geometry!)
        print("––––––––––––––––––––––––––––––––––––––––––––––")
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.first != nil {
            print("touches.first != nil")
            let (dir, pos) = self.getUserVector()
            var nodeDir = SCNVector3()
            
            let nodeForm = SCNSphere(radius: 0.15)
            nodeForm.firstMaterial?.diffuse.contents = sphereColor
            nodeForm.firstMaterial?.isDoubleSided = true
            
            let sphere = SCNNode(geometry: nodeForm)
            sphere.name = "sphere"
            sphere.position = pos
            
            sphere.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            sphere.physicsBody?.isAffectedByGravity = false
            
            // битовая маска для обнаружения столкновения
            sphere.physicsBody?.categoryBitMask = CollisionCategory.sphere.rawValue
            sphere.physicsBody?.collisionBitMask = CollisionCategory.box.rawValue
            
            nodeDir = SCNVector3(dir.x*4,dir.y*4,dir.z*4)
            sphere.physicsBody?.applyForce(nodeDir, asImpulse: true)

            sceneView.scene.rootNode.addChildNode(sphere)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                sphere.removeFromParentNode() // принудительное удаление через 10 секунд
            }
        }
    }
    
    /// (direction, position)
    func getUserVector() -> (SCNVector3, SCNVector3) {
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform)
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // ориентация камеры в пространстве
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // расположение камеры в пространстве
            
            return (dir, pos)
        }
        return (SCNVector3(0, 0, 0), SCNVector3(0, 0, -0.1))
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.box.rawValue || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.sphere.rawValue {
                        
            let sphereColor = contact.nodeA.geometry?.firstMaterial?.diffuse.contents as! UIColor
            let boxColor = contact.nodeB.geometry?.firstMaterial?.diffuse.contents as! UIColor
            
            if sphereColor == boxColor { // пропадают куб и шар
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
            } else {
                contact.nodeB.removeFromParentNode() // пропадает шар
            }
        }
    }
    // MARK: - ARSCNViewDelegate
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = colors[indexPath.row]
        cell.layer.cornerRadius = cell.frame.width / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.sphereColor = colors[indexPath.row]
    }
}
struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let sphere  = CollisionCategory(rawValue: 1 << 0)
    static let box = CollisionCategory(rawValue: 1 << 1)
}
