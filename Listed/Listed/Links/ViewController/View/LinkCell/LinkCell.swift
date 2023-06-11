//
//  LinkCell.swift
//  Listed
//
//  Created by Axita Dholariya on 10/06/23.
//

import UIKit
protocol DashboardLinkCellDelegate: AnyObject {
    func clickOnLinkButton(Link:String)
}

class LinkCell: UITableViewCell {
    
    @IBOutlet weak var lblLinkName: UILabel!{
        didSet{
            lblLinkName.font = .figtreeRegular(ofSize: 14)
        }
    }
    @IBOutlet weak var lblLinkDate: UILabel!{
        didSet{
            lblLinkDate.font = .figtreeRegular(ofSize: 12)
        }
    }
    @IBOutlet weak var lblClick: UILabel!{
        didSet{
            lblClick.font = .figtreeSemiBold(ofSize: 14)
        }
    }
    @IBOutlet weak var lblClickTitle: UILabel!{
        didSet{
            lblClickTitle.font = .figtreeRegular(ofSize: 12)
        }
    }
    @IBOutlet weak var lblLink: UILabel!{
        didSet{
            lblLink.font = .figtreeRegular(ofSize: 14)
        }
    }
    @IBOutlet weak var btnLink: UIButton!
    
    weak var delegate: DashboardLinkCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(linkData: Link){
        self.lblLink.text = linkData.webLink
        self.lblClick.text = "\(linkData.totalClicks)"
        self.lblLinkName.text = linkData.title
        let formattedDate = Date.dateFromZoneFormatString(dateString: linkData.createdAt) ?? Date()
        self.lblLinkDate.text = formattedDate.dateStringFromDate(toFormat: "dd MMM yyyy")
        
    }
    
    @IBAction func btnLinkClick(sender: UIButton){
        delegate?.clickOnLinkButton(Link: lblLink.text ?? "")
    }
}
