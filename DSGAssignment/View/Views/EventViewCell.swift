//
//  EventViewCell.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import UIKit
import SDWebImage

/**
 EventViewCell
 
 This tableview cell use to display event data in tablevbiew cell
*/

class EventViewCell: UITableViewCell {
    
    /**
     mainContainer view added over contenview for shadow
     
     this is used to display rounded corner
    */
    let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    /**
     image view for an event
     
     this imageview 70*70 with with rounded corner
    */
    let eventImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        return img
    }()
    
    /**
     Like heart imageview
     
     this imageview visible when event stored in Favorites
    */
    let likeImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 1
        img.clipsToBounds = true
        return img
    }()
    
    /**
     Event tifleLabel
     
     this label shows full event title with dynamic height
    */
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /**
     Event venue Label
     
     this label shows event venue display location
    */
    
    let venueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor =  #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /**
     Event time Label
     
     this label shows event timing in
    */
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor =  #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
     /// Set event model for this cell to display data in UI

    var event: Event? {
        didSet {
            self.titleLabel.text  = ""
            self.venueLabel.text  = ""
            self.timeLabel.text  = ""
            self.eventImageView.image = nil
            self.likeImage.image = nil
            guard let e = event else { return }
            if let title = e.title {
                titleLabel.text = title
                venueLabel.text = e.venue?.displayLocation
                timeLabel.text = e.getDateTime()
                self.likeImage.image = e.isFavorites() ? #imageLiteral(resourceName: "liked") : nil
                self.eventImageView.sd_setImage(with: URL(string: e.getImageURLString()), placeholderImage: #imageLiteral(resourceName: "placeholder"))
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Override init method for cell UI
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // add shadow on cell
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.23
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowColor = UIColor.black.cgColor
        
        // View Added
        self.contentView.addSubview(mainContainer)
        self.mainContainer.addSubview(eventImageView)
        self.mainContainer.addSubview(likeImage)
        self.mainContainer.addSubview(titleLabel)
        self.mainContainer.addSubview(venueLabel)
        self.mainContainer.addSubview(timeLabel)
        
        //Adding constraint for maiContainer
        mainContainer.topAnchor.constraint(equalTo: contentView.topAnchor,constant:10).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:-10).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:12).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:-12).isActive = true
        
        //Adding constraint for event imageview
        eventImageView.topAnchor.constraint(equalTo:mainContainer.topAnchor,constant:15).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo:mainContainer.leadingAnchor, constant:20).isActive = true
        eventImageView.bottomAnchor.constraint(lessThanOrEqualTo: mainContainer.bottomAnchor, constant: -15).isActive = true
        eventImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        //Adding constraint for like image
        likeImage.centerXAnchor.constraint(equalTo:eventImageView.leadingAnchor).isActive = true
        likeImage.centerYAnchor.constraint(equalTo:eventImageView.topAnchor, constant:2).isActive = true
        likeImage.widthAnchor.constraint(equalToConstant:28).isActive = true
        likeImage.heightAnchor.constraint(equalToConstant:28).isActive = true
        
        //Adding constraint for titleLabel
        titleLabel.topAnchor.constraint(equalTo:eventImageView.topAnchor,constant:2).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.eventImageView.trailingAnchor, constant:10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.mainContainer.trailingAnchor,constant:-10).isActive = true
        
        //Adding constraint for venueLabel
        venueLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant:5).isActive = true
        venueLabel.leadingAnchor.constraint(equalTo:self.titleLabel.leadingAnchor).isActive = true
        venueLabel.trailingAnchor.constraint(equalTo:titleLabel.trailingAnchor).isActive = true
        
        //Adding constraint for timeLabel
        timeLabel.topAnchor.constraint(equalTo:self.venueLabel.bottomAnchor,constant:5).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo:self.titleLabel.leadingAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo:titleLabel.trailingAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo:mainContainer.bottomAnchor,constant: -15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(CellCoderFatalError)
    }

}
