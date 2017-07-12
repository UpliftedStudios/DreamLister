//
//  ItemCell.swift
//  DreamLister
//
//  Created by marcus hidalgo on 7/5/17.
//  Copyright © 2017 Uplifted Studios. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var storeLbl: UILabel!
    
    
    func configureCell(item: Item) {
        
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
        storeLbl.text = item.toStore?.name
        typeLbl.text = item.toItemType?.type

    }
}
