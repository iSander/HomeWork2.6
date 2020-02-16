//
//  MainViewController.swift
//  HomeWork2.7
//
//  Created by Alex Sander on 15.02.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.mainColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor?) {
        view.backgroundColor = color
    }
}
