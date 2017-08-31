//
//  TranlsateVC.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 28.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit
import CoreData

class TranlsateVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var lblSourceLang: UILabel!
    @IBOutlet weak var lblTargetLang: UILabel!
    @IBOutlet weak var tfTranslateText: UITextField!
    @IBOutlet weak var tvResult: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lcWarningTitleHeight: NSLayoutConstraint!
    var isEnToUa = true
    var controller: NSFetchedResultsController<Translate>!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfTranslateText.delegate = self
        attempFetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeListeners()
    }
    //MARK: - IBActions
    
    @IBAction func onBtnChangeLanguagePressed(_ sender: Any) {
        isEnToUa = !isEnToUa
        
        lblSourceLang.text = isEnToUa ? "EN" : "UK"
        lblTargetLang.text = isEnToUa ? "UK" : "EN"
    }
    
    @IBAction func onBtnTranslatePressed(_ sender: Any) {
        
        let text = tfTranslateText.text
        
        if text!.isEmpty {
            lblWarning.text = "WARNING: Please enter text for translate!!!"
            lcWarningTitleHeight.constant = 30
            return
        }
        
        var params: [String: String] = [
            "target" :  isEnToUa ? "uk" : "en",
            "source" :  isEnToUa ? "en" : "uk",
            "text"   :  text!]
        
        SelectoTranslateApi.sharedInstance.reguestTranslate(params: params, success: { response in
            print("Response: \(response)")
            self.tvResult.text = response
            
            //save translate to DB
            params["translation"] = response
            self.updateDB(params: params)
        }) { error in
            print(error.localizedDescription)
            self.lblWarning.text = "WARNING: \(error.localizedDescription)"
            self.lcWarningTitleHeight.constant = 30
        }
    }

    @IBAction func textChanged(_ sender: Any) {
        lblWarning.isHidden = true
        lcWarningTitleHeight.constant = 0
    }
    
    //MARK: - Private
    
    func addListener() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeListeners() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    func attempFetch() {
        let fetchRequest: NSFetchRequest<Translate> = Translate.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: contex, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch  {
            let error = error as NSError
            print("\(error)")
            lblWarning.text = "WARNING: \(error.localizedDescription)"
            lcWarningTitleHeight.constant = 0
        }
    }
    
    func updateDB(params: [String: String]) {
        let item = Translate(context: contex)
        item.from = params["text"]
        item.to = params["translation"]
        item.direction = String(format: "%@ - %@", params["source"]!, params["target"]!).uppercased()
        APP_DELEGATE.saveContext()
    }
}

extension TranlsateVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerWillChangeContent")
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerDidChangeContent")
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("didChange")
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! DictCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            
        }
    }
}

extension TranlsateVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DictCell.identifier, for: indexPath) as? DictCell {
            configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            return cell
        } else {
            return DictCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func configureCell(cell: DictCell, indexPath: NSIndexPath) {
        //update Cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
}

extension TranlsateVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TranlsateVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

