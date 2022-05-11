//
//  DiaryViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/14.
//

import Tabman
import Pageboy

class DiaryViewController: TabmanViewController {

 
    // MARK: - Properties
    
    private var viewControllers: Array<UIViewController> = []
    
    let bar: TMBar.ButtonBar = TMBar.ButtonBar()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addViews()
        setConstraints()
                
        setTabBar(bar: bar)
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            self.navigationController?.isNavigationBarHidden = true
        }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)

           self.navigationController?.isNavigationBarHidden = false
       }

    // MARK: - Handlers
    
    func setUp() {
        configureBar()
    }
    
    private func configureBar() {
        let calendarVC = UIStoryboard.init(name: "Diary", bundle: nil).instantiateViewController(withIdentifier: "CalendarView") as! CalendarViewController
        let bookmarkVC = UIStoryboard.init(name: "Diary", bundle: nil).instantiateViewController(withIdentifier: "BookmarkView") as! BookmarkViewController
            
        viewControllers.append(calendarVC)
        viewControllers.append(bookmarkVC)
        
        self.dataSource = self
    }
    
    
    func addViews(){
        addBar(bar, dataSource: self, at: .top)
    }
    
    func setConstraints() {
        barConstraints()
        
    }
    
    func setTabBar (bar : TMBar.ButtonBar) {
        bar.backgroundView.style = .blur(style: .light)
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 20)
            button.selectedFont = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
        
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress

        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        bar.layout.interButtonSpacing = 35
        bar.layout.transitionStyle = .snap
    }
     
    
    // MARK: - Constraints

    private func barConstraints() {
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
     
 
    
}

    // MARK: - Pageboy DataSource, TMBar DataSource
extension DiaryViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "다이어리 보기")
        case 1:
            return TMBarItem(title: "즐겨찾기 보기")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
}
