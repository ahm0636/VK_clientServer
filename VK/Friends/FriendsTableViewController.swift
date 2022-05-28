//
//  FirstItemTableViewController.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 24/03/22.
//

import UIKit
import CoreGraphics

class FriendsTableViewController: UITableViewController {


    @IBOutlet weak var searchBar: UISearchBar!

    enum ForceState {
        case reset, activated, confirmed
    }

    private let resetForce: CGFloat = 0.4
    private let activationForce: CGFloat = 0.5
    private let confirmationForce: CGFloat = 0.49
    private let activationFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private let confirmationFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    @IBOutlet weak var zoomedPhoto: UIImageView!


    // MARK: - ATTRIBUTES

    let allFriends = User.allMates

    var friends = [String]()
    // contains section title
    var sectionTitle = [String]()

    var namesListModified: [String] = []
    var namesListFixed: [String] = []
    var lettersOfNames: [String] = []
    //contains key and friend array
    var friendDict = [String:[String]]()


    // array of usernames
    func makeNamesList() {
        namesListFixed.removeAll()
        for item in 0...(allFriends.count - 1) {
            namesListFixed.append(allFriends[item].name)
        }
        namesListModified = namesListFixed
    }

    // creating an array of initial letters of usernames in alphabetical order
    func sortCharacterOfNamesAlphabet() {
        var lettersSet = Set<Character>()
        lettersOfNames = []

        for name in namesListModified {
            lettersSet.insert(name[name.startIndex])
        }

        for letter in lettersSet.sorted() {
            lettersOfNames.append(String(letter))
        }
    }

    func getFriendNameForCell(_ indexPath: IndexPath) -> String {
        var namesRows = [String]()
        for name in namesListModified.sorted() {
            if lettersOfNames[indexPath.section].contains(name.first!) {
                namesRows.append(name)
            }
        }
        return namesRows[indexPath.row]
    }

    func getAvatarFriendForCell(_ indexPath: IndexPath) -> String? {
        for friend in allFriends {
            let nameRows = getFriendNameForCell(indexPath)
            if friend.name.contains(nameRows) {
                return friend.avatar
            }
        }
        return ""
    }

    func getPhotosFriend(_ indexPath: IndexPath) -> [String?] {
        var photos = [String?]()
        for friend in allFriends {
            let namesRows = getFriendNameForCell(indexPath)
            if friend.name.contains(namesRows) {
                return [""]
//                photos.append(contentsOf: friend.photos)
            }
        }
        return photos
    }

    func getFriendID(_ indexPath: IndexPath) -> String {
        var userID = ""
        for friend in allFriends {
            let namesRows = getFriendNameForCell(indexPath)
            if friend.name.contains(namesRows) {
                userID = friend.id

            }
        }
        return userID
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        makeNamesList()
        sortCharacterOfNamesAlphabet()

        // Вывод json в консоль
        DataFromVK().loadData(.usernamesAndAvatars)
    }

    // MARK: - SYSTEM FUNCTIONS

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countRows = 0

        for name in namesListModified {
            if lettersOfNames[section].contains(name.first!) {
                countRows += 1
            }
        }
        return countRows
    }

    var currentIndex: Int = 0

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: "showDetails", sender: self)
        
    }

    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListUsersPhoto"{
            // ссылка объект на контроллер с которого переход
            guard let friend = segue.destination as? PhotosCollectionViewController else { return }

            // индекс нажатой ячейки
            if let indexPath = tableView.indexPathForSelectedRow {
                friend.title = getPhotosFriend(indexPath) as! String //screen title (username)

//                friend.userID = getFriendID(indexPath)
//                friend.collectionPhotos = getPhotosFriend(indexPath) // все фотки пользователя
            }
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard
//            let cell = sender as? UITableViewCell,
//            let indexPath = tableView.indexPath(for: cell),
//            let photosViewController = segue.destination as? PhotosCollectionViewController
//
//        else {
//            return
//        }
//        let friend = allFriends[indexPath.row]
//        photosViewController.title = friend.name
//        photosViewController.friendIndex = indexPath.row
//
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FirstCellTableViewCell

        cell?.textLabel?.textColor = .white
        cell?.userName.text = getFriendNameForCell(indexPath)
//        cell?.userName.text = getFriendNameForCell(indexPath)
        if let userImgURL = getAvatarFriendForCell(indexPath) {
            cell?.userImage.image = UIImage(named: userImgURL)
//            cell?.userImage.load(url: userImgURL)
        }
//        cell?.userImage.image = UIImage(named: getAvatarFriendForCell(indexPath))


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
        lettersOfNames.count

    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        let letter: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        letter.textColor = UIColor.black.withAlphaComponent(0.5)
        letter.text = lettersOfNames[section]
        letter.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        header.addSubview(letter)

        return header
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return lettersOfNames
    }


}

extension FriendsTableViewController: UIViewControllerAnimatedTransitioning {

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


extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        namesListModified = searchText.isEmpty ? namesListFixed : namesListFixed.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        sortCharacterOfNamesAlphabet()
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        makeNamesList()
        makeNamesList()
        sortCharacterOfNamesAlphabet()
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }

}
