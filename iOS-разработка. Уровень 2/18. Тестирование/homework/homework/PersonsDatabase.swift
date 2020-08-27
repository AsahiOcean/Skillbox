import Foundation
import RealmSwift

final class PersonDetails: Object {
    @objc dynamic var fullname: String?
    @objc dynamic var height: Double = 0.0
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var gender: String?
    @objc dynamic var dateOfBirth: String?
}

final class Manager {
    static let shared = Manager()
    private let realm = try! Realm()
    var results: Results<PersonDetails>!
    
    internal func getPersons() -> Results<PersonDetails> {
        realm.objects(PersonDetails.self)
    }
    
    internal func printPersons() {
        let objects = realm.objects(PersonDetails.self)
        for i in objects.indices {
            print(objects[i].fullname!)
        }
    }
    
    //MARK: добавляет новых
    internal func person(fullname: String, height: Double, weight: Double, gender: String, dateOfBirth: String) -> PersonDetails {
        let person = PersonDetails()
        person.fullname = fullname
        person.height = height
        person.weight = weight
        person.gender = gender
        person.dateOfBirth = dateOfBirth
        return person
    }
    
    internal func add(person: PersonDetails) {
        try! realm.write {
            realm.add(person)
        }
    }
    
    //MARK: удаляет старых
    internal func remove(person: PersonDetails) -> Bool {
        try! realm.write {
            self.realm.delete(person)
                return true
        }
    }
    internal func deleteAll() -> Bool {
        try! realm.write {
            self.realm.deleteAll()
                return true
            }
    }
    
    //MARK: Поиск самого старшего
    func findDinosaur() -> PersonDetails? {
        if realm.objects(PersonDetails.self).count > 0 {
            var older = realm.objects(PersonDetails.self)[0]
            for human in realm.objects(PersonDetails.self) {
                if !compareDateOfBirth(p1: human, p2: older) {
                older = human
            }}
            print("Dinosaur 🦖: \(older.fullname!) (\(older.dateOfBirth!.toDateISO8601().1) years)")
            return older
        }
        return nil
    }
    
    //MARK: Поиск самого молодого
    func findYoung() -> PersonDetails? {
        if realm.objects(PersonDetails.self).count > 0 {
            var young = realm.objects(PersonDetails.self)[0]
            for human in realm.objects(PersonDetails.self) {
                if compareDateOfBirth(p1: human, p2: young) {
                young = human
            }}
            print("Zoomer 🗿: \(young.fullname!) (\(young.dateOfBirth!.toDateISO8601().1) years)")
            return young
        }
        return nil
    }

    private func compareDateOfBirth(p1: PersonDetails, p2: PersonDetails) -> Bool {
        let p1bday = Int(truncating: (p1.dateOfBirth?.toDateISO8601().0.timeIntervalSinceNow)! as NSNumber)
        let p2bday = Int(truncating: (p2.dateOfBirth?.toDateISO8601().0.timeIntervalSinceNow)! as NSNumber)
        return p1bday > p2bday
    }
}

extension String {
    /// https://en.wikipedia.org/wiki/ISO_8601
    internal func toDateISO8601() -> (Date,Int) {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-DD"
        guard let date = df.date(from: self) else {
            // checking format date
            preconditionFailure("Error convert: unknown date format in input")
        }
        let age = Calendar.current.dateComponents([.year], from: date, to: Date())
        return (date, age.year!)
    }
}
