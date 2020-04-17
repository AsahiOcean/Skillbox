/*
 Для всех задач сделать один проект, в котором все задачи будут реализованы на отдельных экранах.

 1. Создать UICollectionView со всеми элементами, как показано на картинке. При запуске должно показываться 6 ячеек.

 2. Создать UITableView с ячейками, идентичную скриншоту настроек.

 3. Создать UIScrollView, в которой будет аналогичный контент, как на скриншоте. Контент должен адаптироваться к ширине экрана (сохранять отступы). Дизайнить все элементы один в один как на скриншоте не нужно, можно просто обозначить их цветными блоками.

 Ключевое в этой задаче — констрейнты между элементами и скролл вью.
 */

import UIKit

class ViewController: UIViewController {

    var ItemsArray = ["Ботинки", "Пальто", "Джинсы", "Пуховик", "Рубашка", "Брюки", "Бомбер", "Плащ", "Парка", "Кроссовки", "Cвитер", "Толстовка", "Жилет", "Поло", "Чиносы", "Ботинки", "Пальто", "Джинсы", "Пуховик", "Рубашка", "Брюки", "Бомбер", "Плащ", "Парка", "Кроссовки", "Cвитер", "Толстовка", "Жилет", "Поло", "Чиносы" ]

    @IBOutlet weak var CollectionView: UICollectionView!
    
// Navigation Bar
    @IBOutlet weak var NavigationBarOutlet: UINavigationBar!
    @IBOutlet weak var NavigationBarLabel: UINavigationItem!
    
// Строка поиска // Search // SearchBar // SearchLine
    @IBOutlet weak var SearchLineTextField: UITextField!

// Кнопки
    @IBOutlet weak var SearchButton: UIButton! // поиск
    @IBAction func SearchTap(_ sender: Any) {
        print("Нажата кнопка Поиск")
    }

    @IBOutlet weak var FilterButton: UIButton! // фильтр
    @IBAction func FilterTap(_ sender: Any) {
        print("Нажата кнопка Фильтры")
    }

    @IBOutlet weak var TagButton: UIButton! // вкладка 1
    @IBAction func TagTap(_ sender: Any) {
        print("Нажата первая вкладка")
    }
    
    @IBOutlet weak var ShirtButton: UIButton! // вкладка 2
    @IBAction func ShirtTap(_ sender: Any) {
        print("Нажата вторая вкладка")
    }

    @IBOutlet weak var HouseButton: UIButton! // вкладка 3
    @IBAction func HouseTap(_ sender: Any) {
        print("Нажата третья вкладка")
    }

    @IBOutlet weak var BagButton: UIButton! // вкладка 4
    @IBAction func BagTap(_ sender: Any) {
        print("Нажата четвертая вкладка")
    }
    
    @IBOutlet weak var AccountButton: UIButton! // вкладка 5
    @IBAction func AccountTap(_ sender: Any) {
        print("Нажата пятая вкладка")
    }

// Для подсчета ширины ячейки под соотношение сторон экрана
// Например для айпада

    var RatioForWidth: CGFloat = (UIScreen.main.bounds.height / UIScreen.main.bounds.width) > 1.5 ? 2 : 3

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemsArray.count
    }

// Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.size.width - 25) / RatioForWidth), height: (view.frame.size.height / 3))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! CollectionViewCell

// Генератор фигни
        let OldPrice = (arc4random() % 100000 < 19990 ? 9990 : UInt32(29990))
        let Skidon = (arc4random() % 100) >= 50 ? arc4random() % 50 : +(arc4random() % 50)
        let NewPrice = (OldPrice - ((OldPrice / 100) * Skidon))
        let ItemName = ItemsArray.randomElement()

// Вывод
        cell.ItemImageView.image = UIImage.init(named: ItemName!)
        cell.OldPriceLabel.text = String(OldPrice) + " ₽"
        cell.NewPriceLabel.text = String(NewPrice <= 9990 ? "Распродано" : String(NewPrice) + " ₽")
        cell.ItemLabel.text = ItemName
        cell.Skidon.text = String(NewPrice <= 9990 ? "🔔" : String("-\(Int(Skidon))%"))
        return cell
    }
}
