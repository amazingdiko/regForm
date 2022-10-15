//
//  ViewController.swift
//  regForm
//
//  Created by Vitaliy Plaschenkov on 19.09.2022.
//

import UIKit

struct Person {
    var namePerson: String?
    var bornDate: String?
    var eMail: String?
    var sexPerson: String?
}

extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    let screenWidth = UIScreen.main.bounds.width
    var person = Person()
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }

    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
//        scrollView.frame = view.bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var firstNameText: UILabel = {
        let firstNameText = UILabel()
        firstNameText.text = "Enter ur first and last name:"
        firstNameText.translatesAutoresizingMaskIntoConstraints = false
        return firstNameText
    } ()

    lazy var firstName: UITextField = {
//        let firstName = UITextField(frame: CGRect(x: 20, y: 50, width: 300, height: 40))
        let firstName = UITextField()
        firstName.font = UIFont.systemFont(ofSize: 15)
        firstName.keyboardType = UIKeyboardType.default
        firstName.borderStyle = UITextField.BorderStyle.roundedRect
        firstName.placeholder = "for example: Alexandra Pushnova"
        firstName.translatesAutoresizingMaskIntoConstraints = false
        return firstName
    }()

    lazy var dateText : UILabel = {
//        let dateText = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let dateText = UILabel()
        dateText.text = "Enter ur birthday date:"
        dateText.translatesAutoresizingMaskIntoConstraints = false
        return dateText
    }()

    lazy var bornDate : UITextField = {
        let bornDate = UITextField()
        bornDate.font = UIFont.systemFont(ofSize: 15)
        bornDate.keyboardType = UIKeyboardType.default
        bornDate.borderStyle = UITextField.BorderStyle.roundedRect
        bornDate.placeholder = "yyyy-MM-dd"
        bornDate.datePicker(target: self,
                            doneAction: #selector(doneAction),
                            cancelAction: #selector(cancelAction),
                            datePickerMode: .date)
        bornDate.translatesAutoresizingMaskIntoConstraints = false
        return bornDate
    }()
    
    @objc func cancelAction(){
        bornDate.resignFirstResponder()
    }
    
    @objc func doneAction(){
        if let datePickerView = self.bornDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            bornDate.text = dateString
            person.bornDate = bornDate.text
            bornDate.resignFirstResponder()
        }
    }
    
    lazy var eMailText: UILabel = {
       let eMailText = UILabel()
        eMailText.text = "Enter ur e-mail address:"
        eMailText.translatesAutoresizingMaskIntoConstraints = false
        return eMailText
    }()
    
    lazy var eMail: UITextField = {
       let eMail = UITextField()
        eMail.font = UIFont.systemFont(ofSize: 15)
        eMail.placeholder = "example@gmail.com"
        eMail.borderStyle = UITextField.BorderStyle.roundedRect
        eMail.keyboardType = UIKeyboardType.emailAddress
        eMail.translatesAutoresizingMaskIntoConstraints = false
        return eMail
    }()
    
    @objc func sexSelection(_ sex: UISegmentedControl){
        switch (sex.selectedSegmentIndex){
//        case 0:
//            sexType = "male"
        case 1:
            person.sexPerson = "female"
        default:
            person.sexPerson = "male"
        }
//        print (sexType)
    }

    lazy var sexType: UISegmentedControl = {
       let sex = UISegmentedControl(items: ["Male", "Female"])
        sex.translatesAutoresizingMaskIntoConstraints = false
        sex.addTarget(self, action: #selector(sexSelection(_:)), for: .allEvents)
        return sex
    }()
    
//    lazy var passText: UILabel = {
//       let passText = UILabel()
//        passText.text = "Enter ur password:"
//        passText.translatesAutoresizingMaskIntoConstraints = false
//        return passText
//    }()
//
//    lazy var passWord: UITextField = {
//        let passWord = UITextField()
//        passWord.placeholder = "Enter ur password"
//        passWord.keyboardType = .numberPad
//        passWord.isSecureTextEntry = true
//        passWord.borderStyle = UITextField.BorderStyle.roundedRect
//        passWord.translatesAutoresizingMaskIntoConstraints = false
//        return passWord
//    } ()
    
    lazy var registrationButton: UIButton = {
        let registrationButton = UIButton()
        registrationButton.setTitle("REGISTRATION", for: .normal)
        registrationButton.setTitleColor(.white , for: .normal)
        registrationButton.backgroundColor = .blue
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.layer.cornerRadius = 15
        registrationButton.addTarget(self, action: #selector(registrationButtonCheck(_:)), for: .touchUpInside)
        return registrationButton
    }()
    
    @objc func registrationButtonCheck(_ registrationButton: UIButton){
        if firstName.text?.isEmpty == true {
            animateError(view: firstName)
            } else {
                person.namePerson = firstName.text
            }

            if bornDate.text?.isEmpty == true {
                animateError(view: bornDate)
            } else {
                person.bornDate = bornDate.text
            }

            if eMail.text?.isEmpty == true {
                animateError(view: eMail)
            } else {
                if eMail.text!.contains("@") == true {
                person.eMail = eMail.text
                } else {
                    animateError(view: eMail)
                }
            }
        print (person)
        let vc2 = PassViewController()
        vc2.modalPresentationStyle = .fullScreen
        if firstName.text?.isEmpty != true && bornDate.text?.isEmpty != true
            && eMail.text?.isEmpty != true{
            self.present(vc2, animated: true)
        }
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    private func animateError(view: UITextField) {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
            view.backgroundColor = .systemRed
        }, completion: {(finish : Bool) in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
                view.backgroundColor = .white })})
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [CGPoint(x: view.frame.midX - 10, y: view.frame.midY), CGPoint(x: view.frame.midX + 10, y: view.frame.midY), CGPoint(x: view.frame.midX, y: view.frame.midY)]
        animation.autoreverses = true
        animation.duration = 0.2
        view.layer.add(animation, forKey: "position")
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupView(){
        view.addSubview(scrollView)
        scrollView.addSubview(firstNameText)
        scrollView.addSubview(bornDate)
        scrollView.addSubview(dateText)
        scrollView.addSubview(firstName)
        scrollView.addSubview(eMailText)
        scrollView.addSubview(eMail)
//        scrollView.addSubview(passText)
        scrollView.addSubview(sexType)
//        scrollView.addSubview(passWord)
        scrollView.addSubview(registrationButton)
        setupKeyboardHiding()
    }
    
    private func setupConstraintLabel() {
      var constraints = [NSLayoutConstraint]()
        
        constraints.append(scrollView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor))

        constraints.append(firstNameText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40))
//        constraints.append(firstName.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(firstNameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(firstNameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(firstName.topAnchor.constraint(equalTo: firstNameText.topAnchor, constant: 30))
//        constraints.append(firstName.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(firstName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(firstName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))

        constraints.append(dateText.topAnchor.constraint(equalTo: firstName.topAnchor, constant: 60))
//        constraints.append(dateText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20))
        constraints.append(dateText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(dateText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))

        constraints.append(bornDate.topAnchor.constraint(equalTo: dateText.topAnchor, constant: 30))
//        constraints.append(bornDate.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500))
        constraints.append(bornDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(bornDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(eMailText.topAnchor.constraint(equalTo: bornDate.topAnchor, constant: 60))
//        constraints.append(firstName.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(eMailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(eMailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(eMail.topAnchor.constraint(equalTo: eMailText.topAnchor, constant: 30))
//        constraints.append(firstName.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(eMail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(eMail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(sexType.topAnchor.constraint(equalTo: eMail.topAnchor, constant: 60))
//        constraints.append(firstName.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(sexType.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(sexType.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
////
//        constraints.append(passText.topAnchor.constraint(equalTo: sex.topAnchor, constant: 60))
////        constraints.append(firstName.bottomAnchor.constraint(equalTo: view.bottomAnchor))
//        constraints.append(passText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
//        constraints.append(passText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
//
//        constraints.append(passWord.topAnchor.constraint(equalTo: passText.topAnchor, constant: 30))
////        constraints.append(firstName.bottomAnchor.constraint(equalTo: view.bottomAnchor))
//        constraints.append(passWord.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
//        constraints.append(passWord.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
//        constraints.append(passWord.topAnchor.constraint(equalTo: passText.topAnchor, constant: 30))
        constraints.append(registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20))
        constraints.append(registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        

      NSLayoutConstraint.activate(constraints)
     }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        eMail.delegate = self
        bornDate.delegate = self
//        passWord.delegate = self
        setupView()
        setupConstraintLabel()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
}

/// KEYBOARD

extension ViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    @objc private func _trap() {
        Static.responder = self
    }
}
