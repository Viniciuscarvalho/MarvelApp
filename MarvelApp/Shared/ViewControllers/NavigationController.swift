import UIKit
import Foundation

final class NavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setupAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initialized for NSCoder arg")
        return nil
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibNumbleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibNumbleOrNil)
    }
    
    private func setupAppearance() {
        self.navigationBar.barTintColor = .red
        self.navigationBar.isTranslucent = false
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = .black
    }

}
