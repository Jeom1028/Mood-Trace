import UIKit

final class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "square.grid.2x2"), tag: 0)

        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        settingsVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 1)

        viewControllers = [homeVC, settingsVC]
    }
}
