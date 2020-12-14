//
//  GroupCell.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 14/12/20.
//

import Foundation
import UIKit

class GroupCell: UITableViewCell{
        
    @IBOutlet weak var nameGroup: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCellWithTitle(_ name: String?){
        nameGroup.text = name
    }
    
}
