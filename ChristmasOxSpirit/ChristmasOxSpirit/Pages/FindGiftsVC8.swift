//
//  FindGiftsVC8.swift
//  ChristmasOxSpirit
//
//  Created by ChristmasOxSpirit on 2024/12/23.
//


import UIKit

class FindGiftsVC8: UIViewController {

    @IBOutlet weak var bg: UIImageView!
    @IBOutlet var findImg: [UIImageView]!
    @IBOutlet var giftTapBtn: [UIButton]!
    
    let giftImage = ["36", "37", "38", "39", "40"]
    var selectedGifts: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGifts()
        showHowToPlayAlert()
    }
    
    // Set up images for findImg and giftTapBtn
    func setupGifts() {
        for (index, imageView) in findImg.enumerated() {
            if index < giftImage.count {
                imageView.image = UIImage(named: giftImage[index])
            }
        }
        
        for (index, button) in giftTapBtn.enumerated() {
            if index < giftImage.count {
                button.setImage(UIImage(named: giftImage[index]), for: .normal)
                button.layer.borderWidth = 0 // No border initially
                button.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    @IBAction func giftTapped(_ sender: UIButton) {
        guard let index = giftTapBtn.firstIndex(of: sender) else { return }
        
        // Add a border to the tapped button
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.green.cgColor
        
        // Add a border to the corresponding findImg
        if index < findImg.count {
            findImg[index].layer.borderWidth = 2
            findImg[index].layer.borderColor = UIColor.green.cgColor
        }
        
        // Mark this gift as found
        selectedGifts.insert(index)
        
        // Check if all gifts are found
        if selectedGifts.count == giftTapBtn.count {
            showAllGiftsFoundAlert()
        }
    }
    
    func showAllGiftsFoundAlert() {
        let alert = UIAlertController(title: "Congratulations!", message: "You found all the gifts!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Navigate back to the previous view controller
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showHowToPlayAlert() {
            let alert = UIAlertController(
                title: "How to Play",
                message: "Find the hidden gifts in the christmas image! Tap on the matching images below to highlight them in the background. Once you find all the gifts, you win!",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "Got it!", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    
    @IBAction func backBtn(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}
