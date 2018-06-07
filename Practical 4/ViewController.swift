//
//  ViewController.swift
//  Practical 4
//
//  Created by Avi Perera on 7/6/18.
//  Copyright © 2018 Avishka Perera. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

   
    @IBOutlet weak var singerImg: UIImageView!
    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    @IBOutlet weak var songProgress: UIProgressView!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var filterBySinger = "All"
    var musicPlayer : MusicPlayer = MusicPlayer( PlayList())
    var isPlaying : Bool = false
    var timer : Timer!
    var playOrResume : Bool = false
    
    //var musicPlayer = MusicPlayer(<#PlayList#>)
    @IBAction func play(_ sender: UIButton) {
        if playOrResume == true {
            musicPlayer.resume()
        }
        else{
            musicPlayer.play(filterBy: filterBySinger)
        }
    
        updateUI()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRealtimeUI), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: UIButton) {
        musicPlayer.pause()
        playOrResume = true
    }
    
    @IBAction func stop(_ sender: UIButton) {
        musicPlayer.stop()
        playOrResume = false
        updateUI()
    }
    
    @IBAction func rewind(_ sender: UIButton) {
        musicPlayer.previous(filterBy: filterBySinger)
        updateUI()
    }
    
    @IBAction func fastForward(_ sender: Any) {
        musicPlayer.next(filterBy: filterBySinger)
        updateUI()
    }
    
    func updateUI()
    {
        let currentSong = musicPlayer.currentSong
        singerImg.image = UIImage(named: currentSong.singer)
        nowPlayingLabel.text = currentSong.title
    }
    
    @objc func updateRealtimeUI(){
        let currentSong = musicPlayer.getCurrentSong()
        let progress = Float(currentSong.timeElapsed / currentSong.duration)
        songProgress.setProgress((progress), animated: true)
        let elapsedTime = Int(currentSong.timeElapsed.nextUp)
        let remainingTime = Int(currentSong.duration.nextUp) - elapsedTime
        elapsedTimeLabel.text = "\(elapsedTime)"
        remainingTimeLabel.text = "\(remainingTime)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

