import UIKit

class PageViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var PagerScroll: UIScrollView!
    
    var PageViewController: PageController? {
    didSet { PageViewController?.PageDelegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pageControl.addTarget(self, action: Selector("didChangePageControlValue"), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let PageViewController = segue.destination as? PageController {
            self.PageViewController = PageViewController
        }
    }

    @IBAction func didTapNextButton(_ sender: Any) {
        PageViewController?.scrollToNextViewController()
    }

    func didChangePageControlValue() {
//        PageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension PageViewController: PageControllerDelegate {
    func PageViewController(PageViewController: PageController,
        didUpdatePageCount count: Int) {
//        pageControl.numberOfPages = count
        PagerScroll.frame = CGRect(x: 0, y: 88, width: self.view.frame.width, height: 40)
    }
    
    func PageViewController(PageViewController: PageController,
        didUpdatePageIndex index: Int) {
        print(index)
//        pageControl.currentPage = index
    }
}
