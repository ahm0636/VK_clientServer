//
//  FirstItemTableViewController.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 24/03/22.
//

import UIKit
import CoreGraphics

class FirstItemTableViewController: UITableViewController {

    enum ForceState {
        case reset, activated, confirmed
    }

    private let resetForce: CGFloat = 0.4
    private let activationForce: CGFloat = 0.5
    private let confirmationForce: CGFloat = 0.49
    private let activationFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private let confirmationFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    @IBOutlet weak var zoomedPhoto: UIImageView!
    //    let params = UISpringTimingParameters(dampingRatio: 0.4, initialVelocity: 0.2)
//    let animator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
    // MARK: - ATTRIBUTES

    let allFriends = User.allMates

    var friends = [String]()
    // contains section title
    var sectionTitle = [String]()
    //contains key and friend array
    var friendDict = [String:[String]]()


    override func viewDidLoad() {
        super.viewDidLoad()

        friends = allFriends.compactMap { $0.name }.sorted(by: <)

        sectionTitle = Array(Set(friends.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        sectionTitle.forEach({friendDict[$0] = [String]()})
        friends.forEach({friendDict[String($0.prefix(1))]?.append($0)})
        zoomedPhoto.alpha = 0

//
//        animator.addAnimations {
//        self.transform = CGAffineTransform(scaleX: 1, y: 1)
//        self.backgroundColor = self.isOn ? self.onColor : self.offColor
//        }
//        animator.startAnimation()


    }

    // MARK: - SYSTEM FUNCTIONS

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendDict[sectionTitle[section]]?.count ?? 0
    }

    var currentIndex: Int = 0

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetails", let receiver = segue.destination as? MyCollectionCollectionViewController {
//            let item = self.allFriends[self.currentIndex]
//            guard let cell = sender as? UITableViewCell,
//            let indexPath = tableView.indexPath(for: cell),
//            receiver.friend = item
//            receiver.title = item.name
//                    receiver.friendIndex = indexPath.row
        guard
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let photosViewController = segue.destination as? PhotosCollectionViewController

        else {
            return
        }
        let friend = allFriends[indexPath.row]
        photosViewController.title = friend.name
        photosViewController.friendIndex = indexPath.row

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FirstCellTableViewCell

        cell?.textLabel?.textColor = .white
        let friend = allFriends[indexPath.row]
        cell?.userName.text = friendDict[sectionTitle[indexPath.section]]?[indexPath.row]
//        cell?.userName.text = friend.name

        cell?.userImage.image = UIImage(named: friend.avatar)

//        if let DetailVC = self.storyboard?.instantiateViewController(withIdentifier: "") as? ViewController {
//            DetailVC.selectedImage
//        }
//        let frame = cell?.userImage.frame

        return cell ?? UITableViewCell()
    }

    func frameForCellAtIndexPath(_ indexPath: IndexPath) -> CGRect {
        let cell = self.tableView.cellForRow(at: indexPath) as! FirstCellTableViewCell

        let profileImageFrame = cell.userImage.frame

        return profileImageFrame
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath)
        return cell?.frame.height ?? 80
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitle
    }

}

extension FirstItemTableViewController: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        return
    }

//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesMoved(touches, with: event)
//        guard let touch = touches.first else { return }
//        let force = touch.force / touch.maximumPossibleForce
//        let scale = 1 + (CGFloat(maxWidth / minWidth) - 1) * force
//        let transform = CGAffineTransform(scaleX: scale, y: scale)
//    }

}


