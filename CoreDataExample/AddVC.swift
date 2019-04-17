//
//  ViewController.swift
//  CoreDataExample
//

import UIKit
import CoreData


class AddVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    let appDelegateObj : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var editRecNo = Int()
    var dataArray = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editRecNo != -1 {
            txtName.text = self.dataArray[editRecNo].value(forKey: kNameStr) as? String
            txtPhone.text = self.dataArray[editRecNo].value(forKey: kPhoneStr) as? String
        }
    }
    
    @IBAction func btnDoneTapped(sender: AnyObject) {
        
        if editRecNo != -1 {
            self.dataArray[editRecNo].setValue(txtName.text!, forKey: kNameStr)
            self.dataArray[editRecNo].setValue(txtPhone.text!, forKey: kPhoneStr)
            
            do {
                try self.dataArray[editRecNo].managedObjectContext?.save()
            } catch {
                print("Error occured during updating entity")
            }
        } else {
            let entityDescription = NSEntityDescription.entity(forEntityName: kEntityStr, in: appDelegateObj.managedObjectContext)
            let newPerson = NSManagedObject(entity: entityDescription!, insertInto: appDelegateObj.managedObjectContext)
            newPerson.setValue(txtName.text!, forKey: kNameStr)
            newPerson.setValue(txtPhone.text!, forKey: kPhoneStr)
            
            do {
                try newPerson.managedObjectContext?.save()
            } catch {
                print("Error occured during save entity")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelTappe(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}

