import UIKit

class PageController: UIPageViewController {
    
    weak var PageDelegate: PageControllerDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            self.storyboardID("MultiScrollVC"),
            self.storyboardID("BlankVC"),
            self.storyboardID("SearchExample")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(viewController: initialViewController)
        }
        PageDelegate?.PageViewController(PageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    }
    
    
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
           let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(viewController: nextViewController)
        }
    }
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
           let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    
    func storyboardID(_ name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(name)")
    }
    
    private func scrollToViewController(viewController: UIViewController, direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            self.notifyPageDelegateOfNewIndex()
                           })
    }
    
    
    private func notifyPageDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
           let index = orderedViewControllers.firstIndex(of: firstViewController) {
            PageDelegate?.PageViewController(PageViewController: self, didUpdatePageIndex: index)
        }
    }
}

extension PageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController)
        else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController)
        else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
}

extension PageController: UIPageViewControllerDelegate {
    private func pageViewController(pageViewController: UIPageViewController,
                                    didFinishAnimating finished: Bool,
                                    previousViewControllers: [UIViewController],
                                    transitionCompleted completed: Bool) {
        notifyPageDelegateOfNewIndex()
    }
}

protocol PageControllerDelegate: class {
    func PageViewController(PageViewController: PageController,
                            didUpdatePageCount count: Int)
    func PageViewController(PageViewController: PageController,
                            didUpdatePageIndex index: Int)
}
