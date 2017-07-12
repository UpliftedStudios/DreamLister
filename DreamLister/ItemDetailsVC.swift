//
//  ItemDetailsVCViewController.swift
//  DreamLister
//
//  Created by marcus hidalgo on 7/6/17.
//  Copyright © 2017 Uplifted Studios. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVCViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImg: UIImageView!
    
    var stores = [Store]()
    var types = [ItemType]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getStores()
        getTypes()
        
        if itemToEdit != nil {
            
            loadItemData()
            
        }
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        let type = types[row]
        
        if component == 0 {
            
            return store.name
        } else {
            
            return type.type
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return stores.count - 6
        } else {
            
            return types.count - 6
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
        
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
    
    func getTypes() {
        
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do {
            
            self.types = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
//            let type1 = ItemType(context: context)
//            type1.type = "Auto"
//            
//            let type2 = ItemType(context: context)
//            type2.type = "Home Goods"
//            
//            let type3 = ItemType(context: context)
//            type3.type = "Toys"
//            
//            let type4 = ItemType(context: context)
//            type4.type = "Clothing"
//            
//            let type5 = ItemType(context: context)
//            type5.type = "Food"
//            
//            let type6 = ItemType(context: context)
//            type6.type = "Electronics"
//            
//            ad.saveContext()
            
        } catch {
            
            //handle the error
        }
        
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImg.image
        

        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
            
        }
        
        item.toImage = picture
        
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
        item.toItemType = types[storePicker.selectedRow(inComponent: 1)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumbImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
            
            if let typeType = item.toItemType {
                
                var index = 0
                repeat {
                    
                    let t = types[index]
                    if t.type == typeType.type {
                        
                        storePicker.selectRow(index, inComponent: 1, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < types.count)
            }
            
        }
        
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            
            context.delete(itemToEdit!)
            ad.saveContext()
            
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImg.image = img
            
            imagePicker.dismiss(animated: true, completion: nil)
            
        }
        
    }
    

}
