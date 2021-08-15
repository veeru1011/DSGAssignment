//
//  DetailViewController.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import UIKit

protocol DetailViewControllerDelegate:class {
    func favourateButtonTapped()
}
class DetailViewController: UIViewController {
    
    ///class function to get DetailViewController object from main Storyboard
    
    class func laodViewController() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        return vc as! DetailViewController
    }
    
    weak var delegate:DetailViewControllerDelegate?
    
    //MARK: IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var favoritedButton: UIButton!
    
    /// Set event model for display data in this detailview controlelr
    var event: Event?
    
    var isFavorites:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        setupUI()
    }
    
    //Called just before the view controller is added or removed from a container view controller.
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if(parent == nil) {
            if (isFavorites != favoritedButton.isSelected) {
                delegate?.favourateButtonTapped()
            }
        }
    }
    
    /** set up UI and display data for event*/
    func setupUI() {
        if let event = event {
            self.titleLabel.text = event.title
            self.venueLabel.text = event.venue?.displayLocation
            timeLabel.text = event.getDateTime()
            self.eventImageView.sd_setImage(with: URL(string: event.getImageURLString()), placeholderImage: #imageLiteral(resourceName: "placeholder"))
            isFavorites = event.isFavorites()
            self.favoritedButton.isSelected =  event.isFavorites()
        }
    }
    
    /// This method called when favourited tapped .
    /// - Parameter sender: UIButton.
    
    @IBAction func favouritedButtontapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard let event = self.event, let eventID = event.id else { return }
        sender.isSelected ? UserDefaultManager.shared().addToFavorited(eventId: eventID) : UserDefaultManager.shared().removeFromFavorited(eventId: eventID)
    }
}
