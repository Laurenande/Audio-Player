//
//  SevondViewController.swift
//  AudioPlayer
//
//  Created by Егор Куракин on 28.03.2022.
//

import UIKit
import AVFoundation
class SevondViewController: UIViewController {

    @IBOutlet weak var nameSongTittle: UILabel!
    
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var nameArtist: UILabel!
    @IBOutlet weak var imageSong: UIImageView!
    
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var timeStart: UILabel!
    
    @IBOutlet weak var timeEnd: UILabel!
    var player = AVAudioPlayer()
    var songName = ""
    var signerName = ""
    var imageSong11 = UIImage()
    var timer:Timer?
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageSong.layer.cornerRadius = 10
        imageSong.image = imageSong11
        
        nameSongTittle.text = songName
        nameSong.text = songName
        nameArtist.text = signerName
        
        //Set slider song
        
        sliderTime.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        sliderTime.tintColor = .systemGreen
        sliderTime.maximumValue = Float(player.duration)
        sliderTime.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
        
        // timer in slider
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        //label start and end song
        
        timeStart.text = ""
        timeStart.textColor = .lightGray
        timeStart.font = .systemFont(ofSize: 16)
        timeEnd.text = ""
        timeEnd.textColor = .lightGray
        timeEnd.font = .systemFont(ofSize: 16)
        
        
    }
    //stop song at close view
    override func viewDidDisappear(_ animated: Bool) {
        player.stop()
    }
    
    //Update slide value song lenght
    @objc func updateTime() {
        
        // Timer count from start
        
        let timePlayed = player.currentTime
            let minutes = Int(timePlayed / 60)
            let seconds = Int(timePlayed.truncatingRemainder(dividingBy: 60))
            timeStart.text = NSString(format:"%02d:%02d", minutes, seconds) as String
        // Timer coun from end
        
        let difftime = player.currentTime -  player.duration
            let minutes1 = Int(difftime / 60)
            let seconds1 = Int(-difftime.truncatingRemainder(dividingBy: 60))
            timeEnd.text = NSString(format:"%02d:%02d", minutes1, seconds1) as String
        
        // Action thumb song along the way song
        
        sliderTime.setValue(Float(self.player.currentTime), animated: true)
        
    }
    
    //Slider time in song
    @objc func sliderValue (sender: UISlider) {
        
        if sender == sliderTime {
            self.player.currentTime = TimeInterval(sender.value)
            sliderTime.setValue(Float(self.player.currentTime), animated: true)
        }
    }

    //MARK: - IBAction
    //Close view
    @IBAction func hideButton(_ sender: UIButton) {
        player.stop()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextSong(_ sender: UIButton) {
        if self.count < 2 {
            self.count += 1
        } else {
            self.count = 1
        }
        
        do {
            if let audioPath = Bundle.main.path(forResource: "song\(self.count)", ofType: "mp3"){
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                
                if audioPath == Bundle.main.path(forResource: "song1", ofType: "mp3") {
                    nameSong.text = "Fly (feat. Leah Culver)"
                    nameSongTittle.text = "Fly (feat. Leah Culver)"
                    nameArtist.text = "Marshmello"
                    imageSong.image = UIImage(named: "fly")
                }
                
                if audioPath == Bundle.main.path(forResource: "song2", ofType: "mp3") {
                    nameSong.text = "Alone"
                    nameSongTittle.text = "Alone"
                    nameArtist.text = "Marshmello"
                    imageSong.image = UIImage(named: "alone")

                }
            }
        } catch  {
            print("Error")
        }
        
        
        self.player.play()
        
    }

    @IBAction func shareButton(_ sender: UIButton) {
        // Constants with sonf file
        let activityItem = URL.init(fileURLWithPath: Bundle.main.path(forResource: "song1", ofType: "mp3")!)
        let activityItem2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "song2", ofType: "mp3")!)

        // Constants is plaining song
        let audioPath = Bundle.main.path(forResource: "Song\(self.count)", ofType: "mp3")
        
        // Set condition for share the right song
        if audioPath == Bundle.main.path(forResource: "song1", ofType: "mp3") {
            let activityVC = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC,animated: true, completion: nil)
            
        } else {
            
            let activityVC = UIActivityViewController(activityItems: [activityItem2], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC,animated: true, completion: nil)
            
        }
    }
    //Button play and pause
    @IBAction func playPause(_ sender: UIButton) {
        if player.isPlaying {
            
            player.pause()
            sender.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            sender.tintColor = .darkGray
            
        } else {
            player.play()
            sender.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            sender.tintColor = .darkGray
        }
    }
}
