//
//  MainViewController.swift
//  Colors
//
//  Created by Дмитрий Мирошников on 31.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSettingsVC = segue.destination as? ColorSettingsViewController else { return }
        guard let backgroundColor = view.backgroundColor else { return }
        colorSettingsVC.color = CIColor(color: backgroundColor)
        colorSettingsVC.delegate = self
    }
    
}

protocol ColorSettingsViewControllerDelegate {
    func setNewColor(for color: UIColor)
}

extension MainViewController: ColorSettingsViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }
}
