//
//  NotesTableViewCell.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    static let identifier = "NotesTableViewCell"
    var dateLabel = UILabel()
    var fullDescriptionLabel = UILabel()
    var line = UIView()
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        contentView.setupViews(dateLabel)
        contentView.setupViews(fullDescriptionLabel)
        contentView.setupViews(line)
    }
    
    func configureSubviews() {
        
        selectionStyle = .none
        
//        dateLabel.text = notesArray.description.maxLength(length: 1)
        dateLabel.textColor = Resources.Colors.dateTextColor
        dateLabel.font = Resources.Fonts.RalewayLight(with: 8)
        
//        fullDescriptionLabel.text = notesArray.description
        fullDescriptionLabel.numberOfLines = 0
        fullDescriptionLabel.lineBreakMode = .byWordWrapping
        fullDescriptionLabel.font = Resources.Fonts.RalewayLight(with: 10)
        
        line.backgroundColor = Resources.Colors.separate
                
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: line.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            
            fullDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            fullDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            fullDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            fullDescriptionLabel.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -27),
            
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)

        ])
    }
    
}


    
