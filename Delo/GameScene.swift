import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var x = 0.0
    var y = 0.0
    var v = 0.0
    var vx = 0.0
    var vy = 0.0
    
    var dx = 0.0
    var dy = 0.0
    
    var ax = 0.0
    var ay = -200.0
    var lastT = TimeInterval()
    var dt = 0.0
    var moved = false
    
    var path = [CGPoint(x: 10, y: 10), CGPoint(x: 100, y: 100)]
    
    func drawArrow(){
        deleteLines()
        computeArrowPosition()
        
        let dr = SKShapeNode(splinePoints: &path, count: 2)
        dr.name = "line"
        dr.lineWidth = 3
        dr.fillColor = .white
        addChild(dr)
    }
    
    
    fileprivate func computeArrowPosition() {
        path[0] = childNode(withName: "ball")!.position
        
    }
    
    fileprivate func deleteLines() {
        children.forEach{ node in
            if node.name == "line"{
                node.removeFromParent()
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        path[0] = childNode(withName: "ball")!.position
        x = path[0].x
        y = path[0].y
    }
    
    func touchDown(atPoint pos : CGPoint) {
        moved = false
        x = path[0].x
        y = path[0].y
        drawBall()
        path[1] = pos
        drawArrow()
        
        if let shapeNode = childNode(withName: "ball") as? SKShapeNode {
            shapeNode.fillColor = .orange
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        path[1] = pos
        drawArrow()
    }
    
    func touchUp(atPoint pos : CGPoint) {
        deleteLines()
        shoot()
    }
    
    func drawBall(){
        childNode(withName: "ball")?.position = CGPoint(x: x, y: y)
    }
    
    func shoot(){
        moved = true
        let r = sqrt(pow(path[0].x.distance(to: path[1].x), 2) + pow(path[0].y.distance(to: path[1].y), 2)) * 2
        vx = path[1].x.distance(to: path[0].x) * r / 100
        vy = path[1].y.distance(to: path[0].y) * r / 100
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        dt = currentTime - lastT
        lastT = currentTime
        move()
        drawBall()
    }
    
    func move(){
        if moved && checkPosition(){
            vx = vx + ax * dt
            vy = vy + ay * dt
            x = x + vx * dt
            y = y + vy * dt
        }
    }
    
    func checkPosition() -> Bool{
        let ball = childNode(withName: "ball")!
        let kos = childNode(withName: "basket")!
        
        if kos.position.x - 10.0 < ball.position.x && ball.position.x < kos.position.x + 10.0 && kos.position.y - 10.0 < ball.position.y && ball.position.y < kos.position.y {
            if let shapeNode = ball as? SKShapeNode {
                shapeNode.fillColor = .green
            }
            return false
        }
        
        if ball.position.y < -271.0 {
            return false
        }
        return true
    }
}
