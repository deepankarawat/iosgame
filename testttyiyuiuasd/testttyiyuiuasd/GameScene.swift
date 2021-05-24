
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    struct physicsCategory {
        static let FLOOR: UInt32 = 0b1
        static let RED: UInt32 = 0b10
        static let COIN1: UInt32 = 0b100
        static let COIN2: UInt32 = 0b10000
        static let COIN3: UInt32 = 0b100000
        static let COIN4: UInt32 = 0b1000000
        static let COIN5: UInt32 = 0b10000000
        static let COIN6: UInt32 = 0b100000000
        static let COIN7: UInt32 = 0b1000000000
        
        static let PLAYER: UInt32 = 0b1000
    }
    
    private var girl = SKSpriteNode()
    private var idleGirlFrames: [SKTexture] = []
    private var walkGirlFrames: [SKTexture] = []
    private var animation: String = "Idle"
    var point = [Int]()
    var score = SKLabelNode()
    var isRemoved1 = [Int]()
    var isRemoved2 = [Int]()
    var isRemoved3 = [Int]()
    var isRemoved4 = [Int]()
    var isRemoved5 = [Int]()
    var isRemoved6 = [Int]()
    var isRemoved7 = [Int]()
    private var gameOverScene: GameOverScene!
    
    
    private var secondScene: SKScene!
    
    
    
    let floor = SKSpriteNode(color: UIColor.black, size: CGSize(width: 1000, height: 20))
    let redPlata1 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 1000, height: 20))
    let redPlata2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 1000))
    let redPlata3 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 1000))
    let redPlata4 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 500))
    let redPlata5 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 500))
    let redPlata6 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 500, height: 20))
    let redPlata7 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20, height: 20))
    let redPlata8 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20, height: 20))
    let redPlata9 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20, height: 20))
    let redPlata10 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20, height: 20))
    let redPlata11 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20, height: 20))
    let redPlata12 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20, height: 20))
    let redPlata13 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20, height: 20))
    
    override func sceneDidLoad() {
        secondScene = SKScene(fileNamed: "gameOver")
        score = self.childNode(withName:"Score") as!
        SKLabelNode
    }
    override func didMove(to view: SKView) {
        backgroundColor = .blue
        startGame()
        //physics world
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        buildGirl()
    }
    func startGame()
    {
        point = [0]
        isRemoved1 = [0]
        isRemoved2 = [0]
        isRemoved3 = [0]
        isRemoved4 = [0]
        isRemoved5 = [0]
        isRemoved6 = [0]
        isRemoved7 = [0]
        score.text = "\(point[0])"
    }
    func addScore (wasItScore : SKSpriteNode)
    {
        if wasItScore == girl{
            point[0] = point[0] + 1
            score.text = "\(point[0])"
            
        }
        
        
    }
    func removeScore (ItScore : SKSpriteNode)
    {
        if ItScore == girl{
            point[0] = 0
            score.text = "\(point[0])"
            
            
        }
        if isRemoved1[0] == 1
        {
            self.addChild(redPlata7)
            
        }
        
        if isRemoved2[0] == 1
        {
            self.addChild(redPlata8)
            
        }
        if isRemoved3[0] == 1
        {
            self.addChild(redPlata9)
            
        }
        if isRemoved4[0] == 1
        {
            self.addChild(redPlata10)
            
        }
        if isRemoved5[0] == 1
        {
            self.addChild(redPlata11)
            
        }
        if isRemoved6[0] == 1
        {
            self.addChild(redPlata12)
            
        }
        if isRemoved7[0] == 1
        {
            self.addChild(redPlata13)
            
        }
        
        
        
    }
    func buildGirl(){
        
        let girlIdleatlas = SKTextureAtlas(named: "idlea")
        var idleFrames: [SKTexture] = []
        
        let girlWalkatlas = SKTextureAtlas(named: "move")
        var walkFrames: [SKTexture] = []
        
        let numImages = girlIdleatlas.textureNames.count
        for i in 1...numImages{
            let girlTextureName = "idle\(i)"
            idleFrames.append(girlIdleatlas.textureNamed(girlTextureName))
            
            //WALK ANIMATION
            
            let numImages2 = girlWalkatlas.textureNames.count
            for i in 1...numImages2{
                let girlWalkTextureName = "walk\(i)"
                walkFrames.append(girlWalkatlas.textureNamed(girlWalkTextureName))
            }
            
        }
        idleGirlFrames = idleFrames
        walkGirlFrames = walkFrames
        
        let firstFrameTexture = idleGirlFrames[0]
        girl = SKSpriteNode(texture: firstFrameTexture)
        girl.position = CGPoint(x: frame.midX , y: frame.midY)
        
        //Hero Physics
        girl.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: girl.size.width * 0.05  , height: girl.size.height * 0.5))
        girl.physicsBody?.isDynamic = true
        girl.physicsBody?.affectedByGravity = true
        girl.physicsBody?.allowsRotation = false
        girl.physicsBody?.categoryBitMask = physicsCategory.PLAYER
        girl.physicsBody?.contactTestBitMask = physicsCategory.FLOOR | physicsCategory.RED | physicsCategory.COIN1 | physicsCategory.COIN2 | physicsCategory.COIN3 | physicsCategory.COIN4 | physicsCategory.COIN5 | physicsCategory.COIN6 | physicsCategory.COIN7
        //redplataforms
        redPlata1.position = CGPoint(x: frame.midX , y: frame.midY + 500)
        redPlata1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1000, height: 20))
        redPlata1.physicsBody?.isDynamic = false
        redPlata1.physicsBody?.categoryBitMask = physicsCategory.RED
        redPlata1.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata2.position = CGPoint(x: frame.midX + 370, y: frame.midY )
        redPlata2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 1000))
        redPlata2.physicsBody?.isDynamic = false
        redPlata2.physicsBody?.categoryBitMask = physicsCategory.RED
        redPlata2.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata3.position = CGPoint(x: frame.midX - 370 , y: frame.midY )
        redPlata3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 1000))
        redPlata3.physicsBody?.isDynamic = false
        redPlata3.physicsBody?.categoryBitMask = physicsCategory.RED
        redPlata3.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        
        redPlata4.position = CGPoint(x: frame.midX + 240 , y: frame.midY )
        redPlata4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 500))
        redPlata4.physicsBody?.isDynamic = false
        redPlata4.physicsBody?.categoryBitMask = physicsCategory.RED
        redPlata4.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata5.position = CGPoint(x: frame.midX - 240 , y: frame.midY )
        redPlata5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 500))
        redPlata5.physicsBody?.isDynamic = false
        redPlata5.physicsBody?.categoryBitMask = physicsCategory.RED
        redPlata5.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata6.position = CGPoint(x: frame.midX , y: frame.midY - 240)
        redPlata6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 20))
        redPlata6.physicsBody?.isDynamic = false
        redPlata6.physicsBody?.categoryBitMask = physicsCategory.RED
        redPlata6.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata7.position = CGPoint(x: frame.midX , y: frame.midY + 200)
        redPlata7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        redPlata7.physicsBody?.isDynamic = false
        redPlata7.physicsBody?.categoryBitMask = physicsCategory.COIN1
        redPlata7.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata8.position = CGPoint(x: frame.midX + 300 , y: frame.midY - 200)
        redPlata8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        redPlata8.physicsBody?.isDynamic = false
        redPlata8.physicsBody?.categoryBitMask = physicsCategory.COIN2
        redPlata8.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata9.position = CGPoint(x: frame.midX - 300 , y: frame.midY - 200)
        redPlata9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        redPlata9.physicsBody?.isDynamic = false
        redPlata9.physicsBody?.categoryBitMask = physicsCategory.COIN3
        redPlata9.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata10.position = CGPoint(x: frame.midX + 300 , y: frame.midY )
        redPlata10.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        redPlata10.physicsBody?.isDynamic = false
        redPlata10.physicsBody?.categoryBitMask = physicsCategory.COIN4
        redPlata10.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata11.position = CGPoint(x: frame.midX - 300 , y: frame.midY )
        redPlata11.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        redPlata11.physicsBody?.isDynamic = false
        redPlata11.physicsBody?.categoryBitMask = physicsCategory.COIN5
        redPlata11.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata12.position = CGPoint(x: frame.midX + 300 , y: frame.midY + 200)
        redPlata12.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        redPlata12.physicsBody?.isDynamic = false
        redPlata12.physicsBody?.categoryBitMask = physicsCategory.COIN6
        redPlata12.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        redPlata13.position = CGPoint(x: frame.midX - 300 , y: frame.midY + 200)
        redPlata13.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        redPlata13.physicsBody?.isDynamic = false
        redPlata13.physicsBody?.categoryBitMask = physicsCategory.COIN7
        redPlata13.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        //Floor
        floor.position = CGPoint(x: frame.midX , y: frame.midY - 500)
        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1000, height: 20))
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.categoryBitMask = physicsCategory.FLOOR
        floor.physicsBody?.contactTestBitMask = physicsCategory.PLAYER
        
        self.addChild(girl)
        self.addChild(redPlata1)
        self.addChild(redPlata2)
        self.addChild(redPlata3)
        self.addChild(redPlata4)
        self.addChild(redPlata5)
        self.addChild(redPlata6)
        self.addChild(redPlata7)
        self.addChild(redPlata8)
        self.addChild(redPlata9)
        self.addChild(redPlata10)
        self.addChild(redPlata11)
        self.addChild(redPlata12)
        self.addChild(redPlata13)
        
        self.addChild(floor)
        gameOverScene = (SKScene(fileNamed: "gameOver") as!
            GameOverScene)
    }
    
    func animateHero(_Array: [SKTexture], String: String){
        girl.run(SKAction.repeatForever(SKAction.animate(with: _Array, timePerFrame: 0.1, resize: false, restore: true)), withKey:"idleGirlinPlace")
        animation = String
    }
    
    
    func moveGirl(location: CGPoint) {
        
        var multiplierForDirection: CGFloat
        
        let moveDifference = CGPoint(x: location.x - girl.position.x, y: location.y - girl.position.y)
        
        
        if moveDifference.x < 0 {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
        
        girl.xScale = abs(girl.xScale) * multiplierForDirection
        
        girl.physicsBody?.applyForce(CGVector(dx: moveDifference.x, dy: moveDifference.y))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        moveGirl(location: CGPoint(x: location.x, y: location.y))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let v = girl.physicsBody?.velocity {
            if v == CGVector(dx: 0, dy: 0) && animation != "Idle"{
                animateHero(_Array: idleGirlFrames, String: "Idle")
            }else if v != CGVector(dx: 0, dy: 0) && animation != "Walk"{
                animateHero(_Array: walkGirlFrames, String: "Walk")
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.RED) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.RED)
        {
            
            girl.run(SKAction.move(to: CGPoint(x: frame.midX , y: frame.midY), duration: 0.5))
            removeScore(ItScore: girl)
            isRemoved1[0] = 0
            isRemoved2[0] = 0
            isRemoved3[0] = 0
            isRemoved4[0] = 0
            isRemoved5[0] = 0
            isRemoved6[0] = 0
            isRemoved7[0] = 0
            
        }
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.FLOOR) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.FLOOR)
        {
             gameOverScene.message = "YOU WON!"
              gameOverScene.scaleMode = .aspectFit
            self.view?.presentScene(gameOverScene, transition: .reveal(with: .right, duration: 1))
        }
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.COIN1) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.COIN1)
        {
            redPlata7.removeFromParent()
            isRemoved1 [0] = 1
            addScore(wasItScore: girl)
        }
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.COIN2) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.COIN2)
        {
            isRemoved2 [0] = 1
            redPlata8.removeFromParent()
            addScore(wasItScore: girl)
        }
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.COIN3) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.COIN3)
        {
            isRemoved3 [0] = 1
            redPlata9.removeFromParent()
            addScore(wasItScore: girl)
        }
        
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.COIN4) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.COIN4)
        {
            isRemoved4 [0] = 1
            redPlata10.removeFromParent()
            addScore(wasItScore: girl)
        }
        
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.COIN5) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.COIN5)
        {
            isRemoved5 [0] = 1
            redPlata11.removeFromParent()
            addScore(wasItScore: girl)
        }
        
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.COIN6) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.COIN6)
        {
            isRemoved6 [0] = 1
            redPlata12.removeFromParent()
            addScore(wasItScore: girl)
        }
        
        
        if (contact.bodyA.node == girl && contact.bodyB.categoryBitMask == physicsCategory.COIN7) ||
            (contact.bodyB.node == girl && contact.bodyA.categoryBitMask == physicsCategory.COIN7)
        {
            isRemoved7 [0] = 1
            redPlata13.removeFromParent()
            addScore(wasItScore: girl)
        }
    }
}

