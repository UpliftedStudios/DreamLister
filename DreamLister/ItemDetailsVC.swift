//
//  ItemDetailsVCViewController.swift
//  DreamLister
//
//  Created by marcus hidalgo on 7/6/17.
//  Copyright © 2017 Uplifted Studios. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVCViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
////        let store1 = Store(context: context)
////        store1.name = "Best Buy"
////        
////        let store2 = Store(context: context)
////        store2.name = "Frys Electronics"
////        
////        let store3 = Store(context: context)
////        store3.name = "Tesla Dealership"
////        
////        let store4 = Store(context: context)
////        store4.name = "Amazon"
////        
////        let store5 = Store(context: context)
////        store5.name = "K Mart"
////        
////        let store6 = Store(context: context)
////        store6.name = "Target"
//        
//        ad.saveContext()
        
        getStores()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        } catch {
            
            //handle the error
        }
        
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
        let item = Item(context: context)
        
        if let title = titleField.text {
            
            item.title = title
        }
        
        if let price = priceField.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    

}
