//
//  ActivityIndicatorViewController.swift
//  VK_A
//
//  Created by Aurelica Apps iOS Dev - 1 on 13/04/22.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {


    var emptyString = String()

    @IBOutlet weak var plLabel: UILabel!

    func showActivityIndicatory() {
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // Set X and Y whatever you want
        container.backgroundColor = .clear

        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center

        container.addSubview(activityView)
        self.view.addSubview(container)
        activityView.startAnimating()

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        showActivityIndicatory()
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        UILabel.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 2.0, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.plLabel.alpha = 0
        }) { _ in
            self.plLabel.removeFromSuperview()
        }

    }

    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "goToMainUI", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "goToMainUI") {

            let dest = segue.destination as! NewsTableViewController // viewTwo is your destination ViewController
            dest.emptyString = emptyString
            print("Segue Performed")

        }

    }
}
