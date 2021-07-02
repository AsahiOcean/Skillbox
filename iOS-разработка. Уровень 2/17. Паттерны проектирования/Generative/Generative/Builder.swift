import Foundation

// Материал из урока
// Порождающие паттерны проектирования: Строитель (Builder pattern)

class House {
    var numberOfDoors = 0
    var numberOfWindows = 0
}

protocol HouseBuilder {
    var house: House { get }
    
    func buildDoors(amount: Int)
    func buildWindows(amount: Int)
}

class WoodHouseBuilder: HouseBuilder {
    let house: House
    
    init(house: House) {
        self.house = house
    }
    
    func buildDoors(amount: Int) {
        house.numberOfDoors = amount + 1
    }
    
    func buildWindows(amount: Int) {
        house.numberOfWindows = amount
    }
}

class SuperLuxuryHouseBuilder: HouseBuilder {
    let house: House
    
    init(house: House) {
        self.house = house
    }
    
    func buildDoors(amount: Int) {
        house.numberOfDoors = amount * 2
    }
    
    func buildWindows(amount: Int) {
        house.numberOfWindows = amount * 2
    }
}

class Director {
    func buildStandartHouse(builder: HouseBuilder) -> House {
        let house = House()
        let builder = WoodHouseBuilder(house: house)
        builder.buildDoors(amount: 2)
        builder.buildWindows(amount: 4)
        return builder.house
    }
}

class Test {
    func test() {
        let house = Director().buildStandartHouse(builder: WoodHouseBuilder(house: House()))
    }
}














