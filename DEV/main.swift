import UIKit


var time = 2
//Delay variable

struct WorldObject {
    var size: Int

    var enemyArray = [Enemy]()

    var towerArray = [Tower]((values))
    
    

    init(default insize: Int){
        self.size = insize

    }

    var path = [[Bool]](count: size, repeatedBalue: false)

    func addPath(x: Int, y:Int){
        self.path[x][y] = true
    }

    func visMap(){

    }

    func addTower(x: Int, y:Int){
        newTower = Tower(x,y)
        self.towerArray.append(newTower)
    }
    func addEnemy(x: Int, y:Int){
        newEnemy = Enemy(x,y)
        self.towerArray.append(newEnemy)
    }

    func Update(){
        for eachEnemy in self.enemyArray{
            eachEnemy.advance(self.path)
        }
        for eachTower in self.towerArray{
            eachTower.act(enemyArray)
        }

    }

}

/*To Do:
Enemy class:
    Enemy will have to know its location and a method for advancing
    Will have to have a death method
Tower class:
    Will have to know its location
    Check if there's an enemy close enough to it through the enemyArray
WorldObject:
    Vizualization
General:
    Debugging/Testing

    */








OurWorld = WorldObject()


UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(AppDelegate.self)

    PlayerActions()

    OurWorld.update()

    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        // do stuff time later
    }



)
