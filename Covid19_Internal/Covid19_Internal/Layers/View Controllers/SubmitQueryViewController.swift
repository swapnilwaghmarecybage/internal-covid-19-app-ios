//
//  SubmitQueryViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/27/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class SubmitQueryViewController: UIViewController
{
    
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var lebelHeadLine: UILabel!
    @IBOutlet weak var textFieldEmployeeName: UITextField!
    @IBOutlet weak var textFieldEmployeeId: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var labelErrorMessage: UILabel!
    @IBOutlet weak var scrolView: UIScrollView!
   
    @IBOutlet weak var buttonAddPhoto: UIButton!
    @IBOutlet weak var addAttachmentView: UIView!
    @IBOutlet weak var photoImageView: UIView!
    @IBOutlet weak var buttonDeleteImage: UIButton!
    @IBOutlet weak var imageViewThumbnail: UIImageView!
    @IBOutlet weak var textFieldQuery: UITextField!
    @IBOutlet weak var attachmentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var checkboxAttachment: UIButton!
    private var attachmentName: String?
    private var attachmentURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let titleAtributes = [NSAttributedString.Key.foregroundColor: Theme.tabselectedColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.paragraphStyle: style ]
        let subtitleAtributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular), NSAttributedString.Key.paragraphStyle: style ]
        
//        if UIScreen.main.bounds.width > 350 {
//            self.scrolView.isScrollEnabled = false
//        }

        let title = NSMutableAttributedString(string: "Drop us a query\n", attributes: titleAtributes)
        let subtitle = NSMutableAttributedString(string: "Fill the below details and we will\nhelp you in next 24 hours", attributes: subtitleAtributes)
        let combination = NSMutableAttributedString()
        
        combination.append(title)
        combination.append(subtitle)
        
        self.lebelHeadLine.numberOfLines = 0
        self.lebelHeadLine.attributedText = combination
         if let _username = UserDefaults.standard.value(forKey: USERNAME),
        let _phone = UserDefaults.standard.value(forKey: PHONENUMBER),
            let _employeeid = UserDefaults.standard.value(forKey: EMPLOYEEID){
            
            self.textFieldEmployeeName.text = "\(_username)"
            self.textFieldPhoneNumber.text = "\(_phone)"
            self.textFieldEmployeeId.text = "\(_employeeid)"
        }
        self.textFieldQuery.delegate = self
        self.labelErrorMessage.text = ""
        self.attachmentViewHeight.constant = 0
        self.addAttachmentView.isHidden = true
        self.photoImageView.isHidden = true
        
        checkboxAttachment.backgroundColor = .clear
        checkboxAttachment.layer.cornerRadius = 5
        checkboxAttachment.layer.borderWidth = 1
        checkboxAttachment.layer.borderColor = UIColor.black.cgColor
        checkboxAttachment.isSelected = false
        checkboxAttachment.setImage(nil, for: .normal)
        
        updateNavigationBar()
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -=  keyboardSize.height
        }
    }
}
    
@objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
        self.view.frame.origin.y = 0
    }
}
    @IBAction func onClickSubmit(_ sender: Any) {
        if (checkboxAttachment.isSelected && imageViewThumbnail.image == nil){
            self.labelErrorMessage.text = "Please add attachment"
            return
        }
        uploadDataToFirebase()
    }

    func Validate() -> EmployeeDetails? {
        if let query = self.textFieldQuery.text, !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
        let username = self.textFieldEmployeeName.text,!username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let phone = self.textFieldPhoneNumber.text ,!phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let _phone = Int(phone),
            let employeeid = self.textFieldEmployeeId.text, !employeeid.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let _employeeid = Int(employeeid),
            let email =  UserDefaults.standard.value(forKey: EMAILID) as? String {
            
            return (username, _employeeid, _phone, email, query )
        }
        return nil
    }
    
    func uploadDataToFirebase() {
        if let employeeAndQuery = self.Validate() {
            if imageViewThumbnail.image != nil {
                self.uploadPhoto { [weak self] (result) in
                    guard let strongSelf = self else {return}
                    switch result {
                    case .success(let filePath):
                        FirebaseManager.submitQuery(employeeaDetails: employeeAndQuery, filePath: filePath)
                        strongSelf.goBack()
                    case .failure( _):
                        FirebaseManager.submitQuery(employeeaDetails: employeeAndQuery, filePath: "")
                        strongSelf.goBack()
                    }
                }
            } else {
                FirebaseManager.submitQuery(employeeaDetails: employeeAndQuery, filePath: "")
                goBack()
            }
        } else {
            self.labelErrorMessage.text = "All fields are mandatory"
        }
    }
    
    func uploadPhoto(completion: @escaping (Result<String, Error>) -> Void) {
        if let fileURL = self.attachmentURL, let fileName = self.attachmentName{
            AWSS3Manager.shared.uploadfile(fileUrl: fileURL, fileName: fileName, contenType: "image/jpeg") {[weak self] (uploadedFileUrl, error) in
                guard let _ = self else { return }
                if let finalPath = uploadedFileUrl as? String {
                    completion(.success(finalPath))
                } else {
                    if let error = error {
                        print("\(String(describing: error.localizedDescription))") // 4
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func updateNavigationBar() {
        self.navigationItem.title = "Query"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
   

   
    @IBAction func onClickDeletePhoto(_ sender: Any) {
        DeleteImagePopup.instance.delegate = self
        DeleteImagePopup.instance.showAlert()
    }
    
    
    @IBAction func onClickAddPhoto(_ sender: Any) {
        AddImageAlertPopup.instance.delegate = self
        AddImageAlertPopup.instance.showAlert()
        
    }
    
    @IBAction func onClickCheckBoxAttachment(_ sender: Any) {
        if self.checkboxAttachment.isSelected {
            self.checkboxAttachment.isSelected = false
            self.checkboxAttachment.setImage(nil, for: .normal)
            deleteImage()
        } else {
            self.checkboxAttachment.isSelected = true
            self.checkboxAttachment.setImage(UIImage(named: "checkmark"), for: .normal)
        }
        self.addAttachmentView.isHidden = !self.checkboxAttachment.isSelected
        self.attachmentViewHeight.constant  = self.addAttachmentView.isHidden ? 0 : 60
    }
}

extension SubmitQueryViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            self.labelErrorMessage.text = ""
        }
        return true
    }
}


extension SubmitQueryViewController : AddImageAlert , UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func addFromCamera() {
          imagePicker = UIImagePickerController()
          imagePicker.delegate = self
         self.imagePicker.sourceType = .camera
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func addFromAlbum() {
           imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if let  pickedImage = info[.originalImage] as? UIImage, let imageData = pickedImage.pngData() {
            AWSS3Manager.shared.SaveImageInDocumentsDirectory(image: pickedImage) { (fileName, fileURL) -> (Void) in
                DispatchQueue.main.async {
                    if let receivedFileName = fileName, let receivedFileURL = fileURL {
                        self.attachmentURL = receivedFileURL
                        self.attachmentName = receivedFileName
                        let options = [
                            kCGImageSourceCreateThumbnailWithTransform: true,
                            kCGImageSourceCreateThumbnailFromImageAlways: true,
                            kCGImageSourceThumbnailMaxPixelSize: 100] as CFDictionary
                        
                        imageData.withUnsafeBytes { ptr in
                            guard let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                                return }
                            
                            if let cfData = CFDataCreate(kCFAllocatorDefault, bytes, imageData.count){
                                self.photoImageView.isHidden = false
                                let source = CGImageSourceCreateWithData(cfData, nil)!
                                let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
                                let thumbnail = UIImage(cgImage: imageReference)
                                self.imageViewThumbnail.image = thumbnail
                                self.imageViewThumbnail.layer.cornerRadius = 10
                                self.buttonAddPhoto.isUserInteractionEnabled = false
                                self.buttonAddPhoto.alpha = 0.5
                            }
                        }
                    }
                }
            }
        }
    }
}

extension SubmitQueryViewController : DeleteImageAlert
{
    func deleteImage() {
        imageViewThumbnail.image = nil
        photoImageView.isHidden = true
        buttonAddPhoto.isUserInteractionEnabled = true
        buttonAddPhoto.alpha = 1.0
        self.attachmentURL = nil
        self.attachmentName = nil
    }
    
    
}




