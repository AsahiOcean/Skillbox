import UIKit

// MARK: -- 1. Прочитать статью про ООП.
// https://www.raywenderlich.com/599-object-%20oriented-programming-in-swift

// MARK: В чем различие между классом и объектом?

// Класс - это набор характеристик по которому создаются объекты, а объект - это уже конкретная сущность, которая сделана по шаблону класса.

// MARK: Класс: автомобиль - в класс заложено, что у каждого автомобиля есть двигатель, кузов, цвет, габариты
// MARK: Объект: седан, джип, автобус, грузовик - в объекте будут заданы свойства двигателя, кузова, цвета и габариты

// MARK:  -- 2. Решить задачу разделения сущностей на классы (используя наследование, где нужно) и протоколы в следующих программах:
// MARK:  в игре есть сундук с инвентарем. Инвентарь — это различные игровые объекты, например: растения, оружие, квестовые предметы — картинка;

protocol Objects {
    func loot(stuff: Inventory) -> String
}

class Inventory {
    func loot(stuff: Objects...) -> String {
        var result = ""
        for loot in stuff{
            result += loot.loot(stuff: self) + "; "
        }
        return result
    }
}

class Plant: Objects {
    func loot(stuff: Inventory) -> String {
        return "Находится в сундуке"
    }
}

class Weapons: Objects {
    func loot(stuff: Inventory) -> String {
        return "Находится в сундуке"
    }
}

class QuestItems: Objects {
    func loot(stuff: Inventory) -> String {
        return "Находится в сундуке"
    }
}

let Sunduk = Inventory()

let Ogurec = Plant()
let Kaptoxa = Plant()
let Pushka = Weapons()
let Kolotushka = Weapons()
let Crystal = QuestItems()

Sunduk.loot(stuff: Ogurec, Kolotushka, Kaptoxa, Pushka, Crystal)

// MARK: в игре показывается карта с: игроками, монстрами (ими управляет компьютер), интерактивными предметами и неподвижными элементами (например, деревья, стены) — картинка;

protocol Created {
    func create(on the: Map) -> String
}

class Map {
    func create(objects: Created...) -> String {
        var result = ""
        for object in objects{
            result += object.create(on: self) + "; "
        }
        return result
    }
}

class Player: Created {
    func create(on the: Map) -> String {
        return "Player is created"
    }
    func move(){}
}

class Monsters: Created{
    func create(on the: Map) -> String {
        return "Monsters is created"
    }
    func fight(){}
}

enum InteractiveObject: Created {
    case Cash, Loot
    
    func create(on the: Map) -> String {
        return "Created \(self)"
    }
}

enum FixedElements: Created {
    case Derevo, Stena

    func create(on the: Map) -> String {
        return "Created \(self)"
    }
}

let World = Map()
let Igrok = Player()
let Monster1 = Monsters()
let Monster2 = Monsters()
let Monetka = InteractiveObject.Cash
let Loot = InteractiveObject.Loot
let Berezka = FixedElements.Derevo
let Zabor = FixedElements.Stena

World.create(objects: Igrok, Monster1, Monster2, Monetka, Loot, Berezka, Zabor)

// MARK: у приложения есть 3 модели машин, у каждой из которых есть 3 комплектации. Модели отличаются названием, картинкой. Комплектации — названием, ценой, цветом, объемом двигателя.

protocol COMPLECTATION {
    func NextGereration_A()
    func NextGereration_B()
    func NextGereration_C()
}

enum ColorsModels: CaseIterable {
    case Red, White, Blue, Green, Black, Yellow, Purple, Brown, Pink, Gray, Copper
}

class MODELS_A {
    func Model() -> String { return "Model A" }
    func Image() -> String { return "AAA.png" }
    private var ClassModel: String = ""
    private var Name = 0
    private var Price: Float = 125000.0
    private var Color = ColorsModels.allCases.randomElement()!
    private var Engine: Float = 1.0
}
    extension MODELS_A: COMPLECTATION {
        func NextGereration_A() {
            ClassModel = "A"
            Name += 100
            Price = (Price + (Price/5))
            Color = ColorsModels.allCases.randomElement()!
            Engine += 0.25
            print("Name: Model A\(Name)")
            print("Price: \(Price) RUR")
            print("Color: \(Color)")
            print("Engine: \(Engine)L")
            print("- - - - - - - - - - -")
        }
        func NextGereration_B() {
            ClassModel = "B"
            Name += 125
            Price = (Price + (Price/2.5))
            Color = ColorsModels.allCases.randomElement()!
            Engine += 0.50
            print("Name: Model B\(Name)")
            print("Price: \(Price) RUR")
            print("Color: \(Color)")
            print("Engine: \(Engine)L")
            print("- - - - - - - - - - -")
        }
        func NextGereration_C() {
            ClassModel = "C"
            Name += 150
            Price = (Price + (Price/1.5))
            Color = ColorsModels.allCases.randomElement()!
            Engine += 1
            print("Name: Model C\(Name)")
            print("Price: \(Price) RUR")
            print("Color: \(Color)")
            print("Engine: \(Engine)L")
            print("- - - - - - - - - - -")
        }
    }

let Model_A = MODELS_A()
Model_A.NextGereration_A()
Model_A.NextGereration_A()
Model_A.NextGereration_A()

class MODELS_B: MODELS_A {
    override func Model() -> String { return "Model B+" }
    override func Image() -> String { return "BBBB.PNG" }
}
let Model_B = MODELS_B()
Model_B.NextGereration_B()
Model_B.NextGereration_B()
Model_B.NextGereration_B()

class MODELS_C: MODELS_A {
    override func Model() -> String { return "Model C++" }
    override func Image() -> String { return "CCCCC.PNG" }
}
let Model_C = MODELS_C()
Model_C.NextGereration_C()
Model_C.NextGereration_C()
Model_C.NextGereration_C()

// MARK: В каких случаях лучше использовать наследование, а в каких — расширения (extension)?
// MARK: Наследование используют в случаях когда нужно переопределение характеристик унаследованых от родительского класса, в то время как расширения добавят новую функциональность и при этом можно не трогать существующую.

// MARK: -- 3. Ответить, не используя xcode: что выведется в консоль в результате выполнения следующего кода (если код некорректен, написать, какая строчка и почему не скомпилируется):

protocol A {
    func a()
}

protocol B {
    func b()
}

extension B {
    func b() {
        print("extB")
    }
}

class C: A { // "class C" наследует "protocol A"
    func a() {
        print("A")
    }
    func c() {
        print("C")
    }
}

class D: C, B { // "class D" наследует "class C" и "protocol B"
    func b() {
        print("B")
}
    func d() {
        print("D")
    }
}


let v1: A = D()

v1.a()

// let v2: B = C() // MARK: протокол B наследован классу D, "C" нужно заменить на "D"

// v2.c() // MARK: в классе D нет функции "c", нужно заменить "b", т.к. эта она присвоена протоколом B

let v3: C = D()

// v3.d() // MARK: в class C нет func d(), d можно заменить на "a" или "c", т.к. они присвоены классом "C"

let v4: D = D()

v4.a()

// MARK: -- 4. Выучить определения полиморфизма, инкапсуляции и наследования — наверняка об этом спросят на собеседовании! Если их суть не до конца понятна, нужно пересмотреть видео, перечитать статью или написать в Телеграм. Свободно ориентироваться в этих понятиях крайне важно!

// MARK: Приведите пример полиморфизма, инкапсуляции и наследования с полным описанием.
// Полиморфизм дает возможность взаимозаменять типы одной иерархии
// Например:

class Person{
    var name: String
    var age: Int
        init(name: String, age: Int){
            self.name = name
            self.age = age
        }
    func display(){
        print("Имя: \(name)  Возраст: \(age)")
    }
}

class Employee : Person{
    var company: String
        init(name: String, age: Int, company: String) {
            self.company = company
            super.init(name: name, age: age) // здесь "Employee" наследует от "Person" параметры "name" и "age"
        }
    override func display(){
        print("Имя: \(name)  Возраст: \(age)  Сотрудник компании: \(company)")
    }
}

class Manager : Employee{
    override func display(){
        print("Имя: \(name)  Возраст: \(age)  Менеджер компании: \(company)")
        // Manager наследует все параметры родительских классов
        // А именно "company" от "Employee" и в то же время "name" и "age", т.к. они были наследованы "Employee" от "Person"
    }
}

let tom: Person = Person(name:"Tom", age: 23)
let bob: Person = Employee(name: "Bob", age: 28, company: "Apple")
let alice: Person = Manager(name: "Alice", age: 31, company: "Microsoft")

tom.display()
bob.display()
alice.display()

print("- - - - - - - - - - -")
// MARK: Инкапсуляция - это возможность объединить и скрыть свойства и данные, к примеру от других людей работующих с программой.
// MARK: Допустим, секретарь используя программу заполняет какую-то форму, ему не обязательно знать как программа работает.
// MARK: Все манипуляции "под капотом" программы делает разработчик.

class Control {
    var Name: String = ""
    var Surname: String = ""
    var Age: Int
    init(Name: String, Surname: String, Age: Int) {
        self.Name = Name
        self.Surname = Surname
        self.Age = Age
        Age > 18 ? print("\(Name), добро пожаловать снова!") : print("\(Name), ты еще молод! Всему своё время.");
    }
}

var User1 = Control(Name: "Иван", Surname: "Иванов", Age: 25)
var User2 = Control(Name: "Эрик", Surname: "Картман", Age: 10)

print("- - - - - - - - - - -")

// MARK: -- Наследование

class Junior{
    var level = 0
    var exp = 0
    func display(){
        print("Опыта: \(exp). Ты пук в лужу :/")
    }
}

class Middle : Junior{
    var MiddleBonusExp: Int { return super.exp + 1000 } // новая переменная с изменением наследованного exp от Junior
    override func display(){  // переопредяем родительскую функцию
        print("Новый уровень! Бонус к опыту +\(MiddleBonusExp)!")
    }
}

class Senior : Middle{
    var SeniorBonusExp: Int { return super.MiddleBonusExp + 5000 } // новая переменная из наследованного MiddleBonusExp от Middle
    override func display(){  // переопредяем func display() наследованную из класса Middle
        print("Вот это балдёж!! +\(SeniorBonusExp) к опыту!!!")
    }
}

var Jun = Junior()
var Mdl = Middle()
var Snr = Senior()
Jun.display()
Mdl.display()
Snr.display()
