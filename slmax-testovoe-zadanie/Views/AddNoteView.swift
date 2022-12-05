//
//  AddNoteView.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

class AddNoteView: UIView {
    
    var addNewNote: ((Note) -> Void)?
    
    var titleTextField = UITextField()
    var separateView = UIView()
    var descriptionTextField = UITextField()
    var arrowButton = UIButton()
    var currentDate = Date()
    var dateFormatter = DateFormatter()
    var notesTableView = NotesTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutConstraint()
    }
    
    func buildHierarchy() {
        setupViews(titleTextField)
        setupViews(separateView)
        setupViews(descriptionTextField)
        setupViews(arrowButton)
    }
    
    func configureSubviews() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.cornerRadius = 10
        
        titleTextField.placeholder = "Название"
        titleTextField.font = Resources.Fonts.RalewaySemiBold(with: 14)
        titleTextField.delegate = self
        
        separateView.backgroundColor = Resources.Colors.separate
        
        descriptionTextField.placeholder = "Текст описание"
        descriptionTextField.font = Resources.Fonts.RalewayLight(with: 10)
        
        arrowButton.setImage(Resources.Images.rightArrow?.withRenderingMode(.alwaysTemplate), for: .normal)
        arrowButton.imageView?.contentMode = .scaleAspectFill
        arrowButton.tintColor = .black
        arrowButton.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 82),
            
            titleTextField.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),

            separateView.centerYAnchor.constraint(equalTo: centerYAnchor),
            separateView.heightAnchor.constraint(equalToConstant: 1),
            separateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            separateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
            
//            descriptionTextField.topAnchor.constraint(equalTo: separateView.bottomAnchor, constant: 10),
            descriptionTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            descriptionTextField.trailingAnchor.constraint(equalTo: arrowButton.trailingAnchor, constant: -5),

            arrowButton.centerYAnchor.constraint(equalTo: descriptionTextField.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
            arrowButton.heightAnchor.constraint(equalToConstant: 9),
            arrowButton.widthAnchor.constraint(equalToConstant: 9)
        ])
    }
    
    @objc func arrowButtonTapped() {
        if titleTextField.text != "" {

            let note: Note = .init(isOpen: false,
                                   title: titleTextField.text ?? "empty",
                                   description:  descriptionTextField.text ?? "empty",
                                   time: dateFormatter.string(from: currentDate))
            
            addNewNote?(note)
        
        }
        
        titleTextField.text = ""
        descriptionTextField.text = ""
    }
    
}

extension AddNoteView: UITextFieldDelegate {
    
    //limit textField Characters
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: titleTextField.text!).replacingCharacters(in: range, with: string)
        if textField == titleTextField {
            let component = newString.components(separatedBy: NSCharacterSet.alphanumerics.inverted)
            let decimalString = component.joined(separator: "") as NSString
            let length = decimalString.length
            
            if length > 0 {
                let newLength = (titleTextField.text! as NSString).length + (string as NSString).length - range.length as Int
                return newLength > 25 ? false : true
            }
        }
        return true
    }
    
}
