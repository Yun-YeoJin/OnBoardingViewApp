

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    
    var pages = [UIViewController]()
    var bottomButtonMargin: NSLayoutConstraint?
    var pageControl = UIPageControl()
    let startindex = 0
    
    var currentindex = 0 { //currentindex -> startindex
        didSet {
            pageControl.currentPage = currentindex
        }
    }
    
    func makePageVC() {
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
        self.delegate = self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.makePageVC()
        self.makeBottomButton()
        self.makePageControl()
        
        
    }
    
    func makePageControl() {
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black //선택된 점의 페이지 색깔
        pageControl.pageIndicatorTintColor = .lightGray //선택 안된 점의 색깔
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startindex //현재 페이지
        
        pageControl.isUserInteractionEnabled = true //모든 터치와 관련된 이벤트는 동작하지 않는다!
        
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    //페이지컨트롤의 누른 페이지 내용을 보여주기!
    @objc func pageControlTapped(sender: UIPageControl) {
        
        if sender.currentPage > self.currentindex { // 1페이지에서 2페이지로 간다면
        self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        } else {
        self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)

        }
        
        self.currentindex = sender.currentPage //누른 페이지를 기억해야한다.
        buttonPresentationStyle()
    }
    //버튼 코드로 만들기.
    func makeBottomButton() {
        
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        //버튼 Constratints 코드로 설정하기!
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false //오토레이아웃 하려면 false값을 줘야한다.
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true // x축 센터 설정
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true // 왼쪽 여백 설정
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true // 오른쪽 여백 설정
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true // height 설정
        
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0) //값이 커지면 버튼이 더 내려간다.
        bottomButtonMargin?.isActive = true
        hideButton() // 초기화면에 숨겨놔야함.
    }
    
    @objc func dismissPageVC() {
        self.dismiss(animated: true, completion: nil)
    }

}
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    //PageView를 구현하기 위해 해야하는 것,
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentindex = pages.firstIndex(of: viewController) else {
            return nil
        }//firstindex = 찾으면 끝나는 것.
        //해당되는 값이 몇번 index인지 알려줌. //옵셔널값이라 guard let
        self.currentindex = currentindex //현재 페이지 알려주기
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
        self.currentindex = currentindex //현재 페이지 알려주기
        if currentindex == pages.count - 1 //마지막 index가 맞으면
        {
            return pages.first
        } else {
        return pages[currentindex + 1]
        }
    
}
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentVC = pageViewController.viewControllers?.first else { //0번째 인덱스
            return
        }
        guard let currentindex = pages.firstIndex(of: currentVC) else {
            return
        }
        self.currentindex = currentindex
        buttonPresentationStyle()
        
    }
    
    func buttonPresentationStyle() {
        if currentindex == pages.count - 1 { // 마지막 index가 맞으면!
            // 버튼 보여야함
            self.showButton()
        } else {
            // 버튼 숨겨야함
            self.hideButton()
        }
        //버튼 내리고 올라가는 동작 변경하기!
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded()
//        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showButton() {
        bottomButtonMargin?.constant = 0
    }
    
    func hideButton() {
        bottomButtonMargin?.constant = 100
    }
}
