//
//  PassViewController.swift
//  regForm
//
//  Created by Vitaliy Plaschenkov on 06.10.2022.
//

import UIKit

class PassViewController: UIViewController {
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 200)
    }

    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
//        scrollView.frame = view.bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private func setupView(){
        view.addSubview(scrollView)
    }
    
    private func setupConstraintLabel() {
      var constraints = [NSLayoutConstraint]()
        
        constraints.append(scrollView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        setupView()
        setupConstraintLabel()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
