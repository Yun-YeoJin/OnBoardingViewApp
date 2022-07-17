

import UIKit

class ViewController: UIViewController {


    var didShowOnboardingView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //viewDidLoad에 넣으면 안됨! lifeCycle 이해해야함.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if didShowOnboardingView == false {
//        didShowOnboardingView = true
        //instance화 시켜준다.
        let pageVC = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        // 페이지뷰 넘기는 스타일 바꾸기. (scroll / curl)
        pageVC.modalPresentationStyle = .fullScreen //전체화면으로 표시
        //get-only property 는 만들때만 수정가능하고, 만들고 난 후에는 바꿀 수 없음.
        
        self.present(pageVC, animated: true, completion: nil)
    }

}

