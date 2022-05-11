//
//  CalendarViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/15.
//


import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {
    
    // MARK: - Properties
    
    var diaries: Results<Diary>?
    
    let realm = try! Realm()
    
    var diariesDateArray: [String] = []
    var eventsArray: [String] = []
    
    var calendarView = FSCalendar()
    
    let scopeButton: UIButton = {
        let button = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(weight: .light)
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(scopeButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let diaryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        tableView.register(UINib(nibName: "DiaryTableHeaderViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DiaryTableHeaderViewCell")
        return tableView
    }()
    
    var calendarHeightConstraint: NSLayoutConstraint?
    
    let headerView = DiaryTableHeaderUIView()

    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addViews()
        setConstraints()
        
        customCalendar()
        
        loadDiaries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        if let selectedDate = calendarView.selectedDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            
            let dateString = dateFormatter.string(from: selectedDate)
            print(dateString)
            loadDiaries(date: dateString)
        } else {
            loadDiaries()
        }
        calendarView.reloadData()

        
        let headerLabel = headerView.headerLabel
        setUserName(username: headerLabel)
    }
    
    
    // MARK: - Handlers
    
    func setUp() {
        configureCalendarView()
        configureDiaryTableView()
    }
    
    func configureCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.scope = .week
    }
    
    func configureDiaryTableView() {
        diaryTableView.delegate = self
        diaryTableView.dataSource = self
        
        diaryTableView.separatorStyle = .none
        diaryTableView.tableHeaderView = headerView
        
        headerView.headerButton.addTarget(self, action: #selector(viewAll), for: .touchUpInside)
    }
    
    func addViews() {
        view.addSubview(calendarView)
        view.addSubview(scopeButton)
        view.addSubview(diaryTableView)
        
    }
    
    func setConstraints() {
        calendarViewConstraints()
        scopeButtonConstraints()
        diaryTableViewConstraints()
        headerViewConstraints()
    }
    
    func customCalendar() {
        
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        calendarView.headerHeight = 45
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendarView.appearance.headerTitleColor = .tintColorYellow
        calendarView.appearance.weekdayTextColor = .tintColorYellow
        calendarView.appearance.titleDefaultColor = .black
        calendarView.appearance.todayColor = .tintColorYellow
        calendarView.appearance.selectionColor = .borderGray
        calendarView.appearance.titlePlaceholderColor = .borderGray
        calendarView.appearance.eventDefaultColor = .tintColorYellow
        calendarView.appearance.eventSelectionColor = .tintColorYellow
        
        calendarView.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .semibold)
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 18, weight: .semibold)
        calendarView.appearance.titleFont = .systemFont(ofSize: 18, weight: .regular)
    }
    
    @objc func scopeButtonAction(_ sender:UIButton!) {
        print("월/주 button tapped")
        
        if calendarView.scope == .month {
            calendarView.scope = .week
            scopeButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            calendarView.scope = .month
            scopeButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        
    }

    func setUserName(username: UILabel) {
        
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            username.text = "\(nickname) 의 다이어리"
            
        } else {
            username.text = "닉네임을 등록하고 다이어리를 작성해보세요!"
        }
    }

    func loadDiaries(date: String? = nil) {
        
        if date == nil {
            
            diaries = realm.objects(Diary.self).sorted(byKeyPath: "date", ascending: false)
//            diaries = realm.objects(Diary.self).sorted(by: [SortDescriptor(keyPath: "date", ascending: false), SortDescriptor(keyPath: "writeDate", ascending: false)])

            diaryTableView.reloadData()
            
        } else {
            guard let date = date else { return }
            diaries = diaries?.filter("date == %@", date).sorted(byKeyPath: "writeDate", ascending: false)

            diaryTableView.reloadData()
        }
        
    }
    
    @objc func viewAll() {
        diaries = realm.objects(Diary.self).sorted(byKeyPath: "date", ascending: false)
        
        diaryTableView.reloadData()
    }
    

    
    // MARK: - Constraints
    
    
    private func calendarViewConstraints() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
        calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        let height = view.frame.width * 0.73
        calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant: height)
        calendarHeightConstraint?.isActive = true
    }
    
    private func scopeButtonConstraints() {
        scopeButton.translatesAutoresizingMaskIntoConstraints = false
        scopeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        scopeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
        scopeButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor).isActive = true
        scopeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func diaryTableViewConstraints() {
        diaryTableView.translatesAutoresizingMaskIntoConstraints = false
        diaryTableView.topAnchor.constraint(equalTo: scopeButton.bottomAnchor, constant: 5).isActive = true
        diaryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        diaryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        diaryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func headerViewConstraints() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
    }
}

    // MARK: - FSCalendarDelegate, FSCalendarDataSource

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        let dateString = dateFormatter.string(from: date)
        loadDiaries(date: dateString)
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        loadDiaries()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        diaries = realm.objects(Diary.self).sorted(byKeyPath: "date", ascending: false)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        let dateString = dateFormatter.string(from: date)
        
        return diaries?.filter("date = %@", dateString).count ?? 0

    }
    
    
}

    // MARK: - FSCalendarDelegateAppearance

extension CalendarViewController: FSCalendarDelegateAppearance {

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        self.calendarHeightConstraint?.constant = bounds.height
        self.view.layoutIfNeeded()

    }
}

    // MARK: - TableViewDelegate, TableViewDataSource

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diaries?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier, for: indexPath) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        
        let rateLabel = cell.rateLabel as UILabel
        
        if let diaryRate = diaries?[indexPath.row].rate {
            switch diaryRate {
            case 0:
                rateLabel.text = "☆☆☆☆☆"
            case 1:
                rateLabel.text = "★☆☆☆☆"
            case 2:
                rateLabel.text = "★★☆☆☆"
            case 3:
                rateLabel.text = "★★★☆☆"
            case 4:
                rateLabel.text = "★★★★☆"
            case 5:
                rateLabel.text = "★★★★★"
            default :
                break
                
            }
        }
        
        let titleLabel = cell.titleLabel as UILabel
        titleLabel.text = diaries?[indexPath.row].title
        
        let dateLabel = cell.dateLabel as UILabel
        dateLabel.text = diaries?[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard =  UIStoryboard(name: "Diary", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailDiaryView") as! DetailDiaryViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.diaryInfo = diaries?[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

