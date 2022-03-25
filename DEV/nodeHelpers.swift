//NEEDS REVISION!!!!!!!!!!!!!!!!!!
//
//


import Foundation
import SpriteKit

extension SKNode{
    
    /**
        distance between two CGPoints
    */
    func distanceBetweenPoints(first: CGPoint, second: CGPoint) -> Float {
        return Float(hypot(second.x - first.x, second.y - first.y))
    }
    
    /**
        distance between this node and a CGPoint
     */
    func distanceTo(point: CGPoint) -> Float{
        return distanceBetweenPoints(position, second: point)
    }
    
    /**
        distance between this node and another node
     */
    func distanceToNode(node: SKNode) -> Float{
        return distanceBetweenPoints(position, second: node.position)
    }
    
    /**
        point at a percentage of the distance between two CGPoints
     */
    func midPointOfPoints(point1: CGPoint, point2: CGPoint, percentage: Float) -> CGPoint{
        return CGPoint(x: point1.x + (point2.x - point1.x) * CGFloat(percentage), y: point1.y + (point2.y - point1.y) * CGFloat(percentage))
    }
    
    /**
        point at a percentage of the distance between this node and a CGPoint
     */
    func midPointToPoint(point: CGPoint, percentage: Float) -> CGPoint{
        return midPointOfPoints(position, point2: point, percentage: percentage)
    }
    
    /**
        point at a percentage of the distance between this node and another node
     */
    func midPointToNode(node: SKNode, percentage: Float) -> CGPoint{
        return midPointToPoint(node.position, percentage: percentage)
    }
    
    /*
        duration to move the distance with a specific speed
    */
    func durationToMove(distance: Float, distancePerSecond: Int) -> NSTimeInterval{
        return NSTimeInterval(distance / Float(distancePerSecond))
    }
    
}