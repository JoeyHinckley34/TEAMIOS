///NEEDS REVISION!!!!!


import Foundation
import SpriteKit

class SimpleProjectile: Projectile {
    override init() {
        super.init()
        
        let node = SKShapeNode(circleOfRadius: 3)
        node.fillColor = UIColor.blackColor()
        node.strokeColor = UIColor.clearColor()
        
        addChild(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}