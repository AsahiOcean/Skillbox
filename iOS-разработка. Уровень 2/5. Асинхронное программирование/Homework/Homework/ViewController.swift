import UIKit
// Skillbox
// Скиллбокс
/*
 Сыграйте в игру на понимание ошибок мультипоточности: https://deadlockempire.github.io

 Прочитайте дополнительную теорию: https://medium.com/@gabriel_lewis/threading-in-swift-simply-explained-5c8dd680b9b2 и https://hackernoon.com/swift-multi-threading-using-gcd-for-beginners-2581b7aa21cb
 */

// MARK: -- Какие бывают типы потоков и в чем их различие?
// https://habr.com/ru/post/320152/

// MARK: В DispatchQueue.main происходят все UI операции
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// .userInteractive — для задач, которые взаимодействуют с пользователем
let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// .userInitiated — для задач, которые инициируются пользователем и требуют обратной связи
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// .utulity — для задач, которые требуют некоторого времени для выполнения и не требуют немедленной обратной связи,
let utilityQueue = DispatchQueue.global(qos: .utility)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// .background — для задач, не связанных с визуализацией и не критичных ко времени исполнения;
// например, backups или синхронизация с web — сервисом.
let backgroundQueue = DispatchQueue.global(qos: .background)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// .default — для задач, не связанных с визуализацией и не критичных ко времени исполнения;
let defaultQueue = DispatchQueue.global(qos: .default)
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//MARK: DispatchQueue.global != DispatchQueue.main
//MARK: DispatchQueue.global(qos:.userInteractive).async { }
//MARK: допустимо, когда нужно быстро выполнить что-то в фоновом потоке
//MARK: когда пользователь взаимодействует с приложением
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Создайте проект, в котором каждая задача будет в виде отдельного экрана (модуля):

// загрузка изображения в фоновом потоке и показ его на экране
// загрузка изображения и применение к нему эффекта размытия в фоновом потоке и показ на экране
// одно текстовое поле с вводом числа и кнопка “Рассчитать”. После нажатия на кнопку приложение должно в фоновом режиме найти все простые числа (которые делятся без остатка только на 1 и себя) от единицы до введенного числа. Все найденные числа нужно вывести в консоль вместе с длительностью расчета этих чисел (сколько времени ушло на поиск этих чисел).

class ViewController: UIViewController {
    @IBOutlet weak var DispatchQueueTime: UILabel!
    @IBOutlet weak var DispatchQueueTime2: UILabel!
    @IBOutlet weak var GlobalTime: UILabel!
    
    let delay = 0.1
    
    var timer: Timer?
    var counter: Float = 0.00 {
    didSet { DispatchQueueTime.text = String(format: "%.1f", counter) }
    }
    var timer2: Timer?
    var counter2: Float = 0.00 {
    didSet { GlobalTime.text = String(format: "%.1f", counter) }
    }

    override func viewDidLoad() { // MARK: viewDidLoad == Main queue
        super.viewDidLoad()
        //MARK: НИКОГДА НЕ вызывайте метод sync на Main queue - это приведет к блокировке приложения
        DispatchQueue.main.async {
        self.timer = Timer.scheduledTimer(timeInterval: self.delay, target:self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
            //MARK: sync указывает на выполнение кода в блоке синхронно с тем потоком, где он вызван
            //MARK: поток остановится на время выполнения кода в sync
            utilityQueue.sync {
            self.timer2 = Timer.scheduledTimer(timeInterval: self.delay, target:self, selector: #selector(self.UpdateTimer2), userInfo: nil, repeats: true)
            }
        }
    }
    @objc func UpdateTimer() { counter = counter + Float(delay) }
    @objc func UpdateTimer2() { counter2 = counter2 + Float(delay) }
}
/*
https://medium.com/hackernoon/swift-multi-threading-using-gcd-for-beginners-2581b7aa21cb

https://www.raywenderlich.com/966538-arc-and-memory-management-in-swift

https://hackernoon.com/swift-avoiding-memory-leaks-by-examples-f901883d96e5
*/
