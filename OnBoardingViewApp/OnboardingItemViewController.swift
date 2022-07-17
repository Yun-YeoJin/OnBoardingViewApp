

import UIKit

class OnboardingItemViewController: UIViewController {
    
    //Var는 생성이 되는 순간에 바로 생성.
    var mainText = ""
    var subText = ""
    var topImage: UIImage? = UIImage()
    
    
    //IBOutlet으로 불러온 변수는 바로 생성 되지 않는다. viewDidLoad전에 값은 nil이 된다!
    @IBOutlet private weak var topImageView: UIImageView!

    @IBOutlet private weak var mainTitleLabel: UILabel!{
        didSet {
            mainTitleLabel.font = .boldSystemFont(ofSize: 20)
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .boldSystemFont(ofSize: 15)
            descriptionLabel.textColor = .orange
        }
    }
    
    
    // private을 사용함으로써 외부에서 못 가져다 쓰게 함.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTitleLabel.text = mainText
        topImageView.image = topImage
        descriptionLabel.text = subText
    
     
    }



}
