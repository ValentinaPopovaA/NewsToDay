//
//  ViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 20.10.2024.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
    }

    override func viewDidAppear(_ animated: Bool) {
        showOnboarding()
    }
    
    private func showOnboarding() {
        let userDefaults = UserDefaults.standard
        let onBoardinngWasViewed = userDefaults.bool(forKey: "OnBoardingWasViewed")
        if onBoardinngWasViewed == false {
            let onboardingViewController = OnboardingViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: true)
        }
    }
}

