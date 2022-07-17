

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let itemVC1 = OnboardingItemViewController.init(nibName: "OnboardingItemViewController", bundle: nil)
        itemVC1.mainText = "첫번째"
        itemVC1.topImage = UIImage(named: "banner01")
        itemVC1.subText = "첫번째 내용이 여기에 나옵니다!"
        
        let itemVC2 = OnboardingItemViewController.init(nibName: "OnboardingItemViewController", bundle: nil)
        itemVC2.mainText = "두번째"
        itemVC2.topImage = UIImage(named: "banner02")
        itemVC2.subText = "두번째 내용이 여기에 나옵니다!"
        
        let itemVC3 = OnboardingItemViewController.init(nibName: "OnboardingItemViewController", bundle: nil)
        itemVC3.mainText = "세번째"
        itemVC3.topImage = UIImage(named: "banner03")
        itemVC3.subText = "세번째 내용이 여기에 나옵니다!"
        
        //itemVC1, VC2, VC3 를 pages 배열에 넣어주기
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        //pageViewController 시작 페이지 설정하기.
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
        
    }


}
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    //PageView를 구현하기 위해 해야하는 것,
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentindex = pages.firstIndex(of: viewController) else {
            return nil
        }//firstindex = 찾으면 끝나는 것.
        //해당되는 값이 몇번 index인지 알려줌. //옵셔널값이라 guard let
        if currentindex == 0 {
           return pages.last
        } else {
        return pages[currentindex - 1]
    }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
   
        guard let currentindex = pages.firstIndex(of: viewController) else {
            return nil
        }
        if currentindex == pages.count - 1 //마지막 index가 맞으면
        {
            return pages.first
        } else {
        return pages[currentindex + 1]
        }
    
}
}
