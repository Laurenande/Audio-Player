//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Егор Куракин on 28.03.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageSong1: UIImageView!
    @IBOutlet weak var imageSong2: UIImageView!
    
    @IBOutlet weak var timeSong1: UILabel!
    @IBOutlet weak var timeSong2: UILabel!
    
    @IBOutlet weak var nameSong1: UIButton!
    @IBOutlet weak var nameSong2: UIButton!
    
    @IBOutlet weak var nameSigner1: UIButton!
    @IBOutlet weak var nameSigner2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageSong1.image = UIImage(named: "fly")
        imageSong2.image = UIImage(named: "alone")
        timeSong1.text = "3:12"
        timeSong2.text = "4:32"

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showView",
        let destination = segue.destination as? SevondViewController {
            destination.imageSong11 = imageSong1.image!
            destination.signerName = nameSigner1.titleLabel?.text! ?? "Nil"
            destination.songName = nameSong1.titleLabel?.text! ?? "Nil"
            
            do {
                if let audioPath = Bundle.main.path(forResource: "song1", ofType: "mp3"){
                    try destination.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                }
            } catch  {
                print("Error")
            }
            destination.player.play()
        }
        
        if segue.identifier == "showView2",
        let destination = segue.destination as? SevondViewController {
            destination.imageSong11 = imageSong2.image!
            destination.signerName = nameSigner2.titleLabel?.text! ?? "Nil"
            destination.songName = nameSong2.titleLabel?.text! ?? "Nil"
            
            do {
                if let audioPath = Bundle.main.path(forResource: "song2", ofType: "mp3"){
                    try destination.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                }
            } catch  {
                print("Error")
            }
            destination.player.play()
        }
        
    }

}

