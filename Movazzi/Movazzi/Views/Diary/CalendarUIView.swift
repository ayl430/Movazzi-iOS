//
//  CalendarUIView.swift
//  Movazzi
//
//  Created by yeri on 2022/04/29.
//

import Foundation
import UIKit
import FSCalendar

class CalendarUIView: UIView {
    
    // MARK: - Properties
    
    var calendarView = FSCalendar()
    
    let scopeButton: UIButton = {
        let button = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(weight: .light)
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .black
        
//        button.addTarget(self, action: #selector(scopeButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let headerView = DiaryTableHeaderUIView()
    
    let diaryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        tableView.register(UINib(nibName: "DiaryTableHeaderViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DiaryTableHeaderViewCell")
        return tableView
    }()
    
    var calendarHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        addViews()
        setConstraints()
        
        customCalendar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    func setUp() {
        
        diaryTableView.separatorStyle = .none
        diaryTableView.tableHeaderView = headerView
    }
    
    func addViews() {
        addSubview(calendarView)
        addSubview(scopeButton)
        addSubview(diaryTableView)
    }
    
    func setConstraints() {
        calendarViewConstraint()
        scopeButtonConstraint()
        diaryTableViewConstraint()
        headerViewConstraint()
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
    
    func customCalendar() {
        
//        view.locale = Locale(identifier: "eng")
        
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        calendarView.headerHeight = 45
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendarView.appearance.headerTitleColor = UIColor(red: 211/255, green: 143/255, blue: 90/255, alpha: 1)
//        view.appearance.weekdayTextColor = UIColor(red: 107/255, green: 107/255, blue: 107/255, alpha: 1)
        calendarView.appearance.weekdayTextColor = UIColor(red: 211/255, green: 143/255, blue: 90/255, alpha: 1)
        calendarView.appearance.titleDefaultColor = .black
        calendarView.appearance.todayColor = UIColor(red: 211/255, green: 143/255, blue: 90/255, alpha: 1)
        calendarView.appearance.selectionColor = UIColor(red: 197/255, green: 185/255, blue: 200/255, alpha: 1)
        calendarView.appearance.titlePlaceholderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        calendarView.appearance.eventDefaultColor = UIColor(red: 211/255, green: 143/255, blue: 90/255, alpha: 1)
        
        
        calendarView.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .semibold)
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 18, weight: .semibold)
        calendarView.appearance.titleFont = .systemFont(ofSize: 18, weight: .regular)
    }
    
    // MARK: - Constraints
    
    private func calendarViewConstraint() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        
        let height = self.frame.width * 0.73
        calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant: height)
        calendarHeightConstraint?.isActive = true
    }

    private func scopeButtonConstraint() {
        scopeButton.translatesAutoresizingMaskIntoConstraints = false
        scopeButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor).isActive = true
        scopeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        scopeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        scopeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func diaryTableViewConstraint() {
        diaryTableView.translatesAutoresizingMaskIntoConstraints = false
        diaryTableView.topAnchor.constraint(equalTo: scopeButton.bottomAnchor, constant: 5).isActive = true
        diaryTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        diaryTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        diaryTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func headerViewConstraint() {
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 60)
    }
    
}
