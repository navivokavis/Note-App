//
//  MainNoteView.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

class MainNoteView: UIView {
    
    var deleteCell: ((String) -> Void)?
    var sectionIsOpen: ((Int) -> Void)?
    
    var contentView = UIView()
    var headerLabel = UILabel()
    var line = UIView()
    var notesLabel = UILabel()
    var arrowButton = UIButton()
    var deleteButton = UIButton()
    var isDeleteButtonShow = false
    var deleteButtonTrailingConstraint: NSLayoutConstraint!
    var timeLabel = UILabel()
    var time = 5 {
        didSet {
            timeLabel.text = "\(time)"
        }
    }
    var timer = Timer()
    var isTimeLabelShow = false
    var timeButtonTrailingConstraint: NSLayoutConstraint!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutConstraint()
    }
    
    func buildHierarchy() {
        setupViews(contentView)
        contentView.setupViews(headerLabel)
        contentView.setupViews(line)
        contentView.setupViews(notesLabel)
        contentView.setupViews(arrowButton)
        contentView.setupViews(deleteButton)
        contentView.setupViews(timeLabel)
    }
    
    func configureSubviews() {
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        contentView.backgroundColor = .white
        
        headerLabel.font = Resources.Fonts.RalewaySemiBold(with: 14)
        headerLabel.adjustsFontSizeToFitWidth = true
        
        line.backgroundColor = .black
        
        notesLabel.font = Resources.Fonts.RalewayLight(with: 8)
        
        arrowButton.setImage(Resources.Images.downArrow?.withRenderingMode(.alwaysTemplate), for: .normal)
        arrowButton.imageView?.contentMode = .scaleAspectFit
        
        arrowButton.tintColor = .black
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(sectionSwipeLeft))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sectionDidTap)))
        
        deleteButton.backgroundColor = Resources.Colors.redDeleteColor
        deleteButton.layer.cornerRadius = 5
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.titleLabel?.font = Resources.Fonts.RalewaySemiBold(with: 14)
        deleteButton.addTarget(self, action: #selector(deteteButtonTapped), for: .touchUpInside)
        
        timeLabel.backgroundColor = Resources.Colors.redDeleteColor
        timeLabel.textAlignment = .center
        timeLabel.textColor = .white
        timeLabel.text = "\(time)"
        timeLabel.layer.cornerRadius = 5
        timeLabel.layer.masksToBounds = true
        
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 37),
            
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17.36),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerLabel.widthAnchor.constraint(equalToConstant: 68.34),
            
            line.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 6.51),
            line.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            line.widthAnchor.constraint(equalToConstant: 0.5),
            line.heightAnchor.constraint(equalToConstant: 15),
            
            notesLabel.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: 8.68),
            notesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            notesLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -5),
            
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17.36),
            arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowButton.widthAnchor.constraint(equalToConstant: 10),
            arrowButton.heightAnchor.constraint(equalToConstant: 10),
            
            deleteButton.widthAnchor.constraint(equalToConstant: 95),
            deleteButton.heightAnchor.constraint(equalToConstant: 37),
            deleteButton.topAnchor.constraint(equalTo: topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            timeLabel.widthAnchor.constraint(equalToConstant: 45),
            timeLabel.heightAnchor.constraint(equalToConstant: 37),
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
        deleteButtonTrailingConstraint = self.deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 95)
        deleteButtonTrailingConstraint.isActive = true
        
        timeButtonTrailingConstraint = self.timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 45)
        timeButtonTrailingConstraint.isActive = true
        
    }
    
    // delete button
    func hideDeleteButton() {
            self.deleteButtonTrailingConstraint.constant = 95
        isDeleteButtonShow = false
    }
    
    func showDeleteButton() {
            self.deleteButtonTrailingConstraint.constant = 0
        isDeleteButtonShow = true
    }
    
    @objc func sectionSwipeLeft() {
        if !isDeleteButtonShow && !isTimeLabelShow {
            showDeleteButton()
        }
    }
    
    @objc func sectionDidTap() {
        if isDeleteButtonShow && !isTimeLabelShow {
            isDeleteButtonShow = false
            isTimeLabelShow = false
            hideDeleteButton()
            
        } else if isTimeLabelShow && !isDeleteButtonShow {
            isDeleteButtonShow = false
            isTimeLabelShow = false
            timer.invalidate()
            time = 5
            hideTimer()
        } else {
            sectionIsOpen?(tag)
        }
    }
    
    func hideTimer() {
        self.timeButtonTrailingConstraint.constant = 45
        isDeleteButtonShow = false
    }
    
    func showTimer() {
        self.deleteButtonTrailingConstraint.constant = 95
        self.timeButtonTrailingConstraint.constant = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerGo), userInfo: nil, repeats: true)
        isDeleteButtonShow = false
        isTimeLabelShow = true
    }
    
    @objc func deteteButtonTapped() {
        showTimer()
    }

    //timer
    
    @objc func timerGo() {
        time -= 1
        
        if time == 0 {
            deleteCell?(headerLabel.text ?? "")
            timer.invalidate()
        }
    }
    
}


