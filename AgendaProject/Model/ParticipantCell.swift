//
//  groupCell.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 04/12/20.
//

import Foundation
import UIKit

class ParticipantCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCellWithTitle(_ name: String?, _ role: String?){
        nameLabel.text = name
        roleLabel.text = role
    }
    
}
