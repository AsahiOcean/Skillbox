// https://ru.wikipedia.org/wiki/Заместитель_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Proxy_pattern
/*
 Заместитель — это объект, который выступает прослойкой между клиентом и реальным сервисным объектом. Заместитель получает вызовы от клиента, выполняет свою функцию (контроль доступа, кеширование, изменение запроса и прочее), а затем передаёт вызов сервисному объекту. Заместитель имеет тот же интерфейс, что и реальный объект, поэтому для клиента нет разницы — работать через заместителя или напрямую. (Источник: https://refactoring.guru/ru/design-patterns/proxy/swift/example)
*/
import Foundation

protocol SOCKS {
    func request(from: String, site: String)
}

// Объект, для которого создается прокси
class Object: SOCKS {
    func request(from: String, site: String) {
        print("\(site): поступил запрос от \(from)")
    }
}

// Proxy – посредник или заместитель объекта. Хранит ссылку на конечный объект, контролирует доступ к нему, может управлять его созданием и удалением. При необходимости Proxy переадресует запросы к Object
class Proxy: SOCKS {
    var object: Object?
    internal var ip: String = "5.1.4.9"
    
    func request(from: String, site: String) {
        print("\(type(of: self)): \(from) хочет открыть \(site)")
        if (object == nil) {
            object = Object()
        }
        print("\(type(of: self)): обращаюсь к \(site) от имени \(self.ip)")
        object?.request(from: self.ip, site: site)
    }
}

// Client: использует Proxy для доступа к Object
class Client {
    internal var ip: String = "1.2.3.4"
    
    func test() {
        let proxy: SOCKS = Proxy()
        let url: String = "Google"
        print("\(type(of: self)): открываю \(url) с помощью \(type(of: proxy))")
        proxy.request(from: self.ip, site: url)
    }
}

let client = Client()
client.test()

// Skillbox
// Скиллбокс
