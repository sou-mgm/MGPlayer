//
//  IntroViewController.swift
//  TryingViewCodec
//
//  Created by Matheus Matias on 19/01/23.
//

import UIKit
import AVKit

final class PlayerViewController: UIViewController {
    
    //MARK: Elements
    private lazy var ivArtwork: UIImageView = {
        //Cria o objeto
        let newObject = UIImageView(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var lbSongName: UILabel = {
        //Cria o objeto
        let newObject = UILabel(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var lbArtist: UILabel = {
        //Cria o objeto
        let newObject = UILabel(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var slTimeMusic: UISlider = {
        //Cria o objeto
        let newObject = UISlider(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var stackviewBt: UIStackView = {
        //Cria o objeto
        let newObject = UIStackView(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var lbElapsedTime: UILabel = {
        //Cria o objeto
        let newObject = UILabel(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var lbRemainingTime: UILabel = {
        //Cria o objeto
        let newObject = UILabel(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var btBackward: UIButton = {
        //Cria o objeto
        let newObject = UIButton(type: .system)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var btPlayPause: UIButton = {
        //Cria o objeto
        let newObject = UIButton(type: .system)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var btForward: UIButton = {
        //Cria o objeto
        let newObject = UIButton(type: .system)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var btClose: UIButton = {
        //Cria o objeto
        let newObj = UIButton(type: .system)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObj.translatesAutoresizingMaskIntoConstraints = false
        return newObj
    }()
    
    
    // Defini tamanho padrao do botao
    let configButton = UIImage.SymbolConfiguration(pointSize: 30)
    let configButton1 = UIImage.SymbolConfiguration(pointSize: 40)
    
    
    //MARK: Super funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = MPShared.backgroundColor
        addFeaturesObjects()
        observeProgressbar()
        
    }
    
    //MARK: Functions
    
    //Observa progresso da musica
    
    func observeProgressbar(){
        slTimeMusic.maximumValue = Float(MPShared.player.duration)
        DispatchQueue.global(qos: .default).async {
            while(true){
                if self.MPShared.player.isPlaying {
                    self.MPShared.updateProgress()
                    DispatchQueue.main.async {
                        //Atualiza conforme progresso
                        self.slTimeMusic.value = self.MPShared.progressBar
                        self.lbElapsedTime.text = self.MPShared.elapsedTime
                        self.lbRemainingTime.text = self.MPShared.remainingTime
                        if self.MPShared.songDidFinish {
                            //self.nextMusic()  //implementacao da funcao em teste
                            self.MPShared.songDidFinish = false
                        }
                    }
                   
                } else {
                    self.MPShared.updateProgress()
                    DispatchQueue.main.async {
                        self.slTimeMusic.value = self.MPShared.progressBar
                        self.lbElapsedTime.text = self.MPShared.elapsedTime
                        self.lbRemainingTime.text = self.MPShared.remainingTime
                    }
                    break
                }
            }
        }
    }
    
    // Avanca entre as musicas
    func nextMusic(){
        MPShared.playingIndex += 1
        if MPShared.playingIndex >= MPShared.musics.count {
            MPShared.playingIndex = 0
        }
        MPShared.setupPlayer(music: MPShared.musics[MPShared.playingIndex])
        MPShared.play {
            slTimeMusic.value = 0.0
            slTimeMusic.maximumValue = Float(MPShared.player.duration)
        }
        slTimeMusic.value =  MPShared.progressBar
        addFeaturesObjects()
        observeProgressbar()
    }
    
    //MARK: Func - Features
    private func addFeaturesObjects(){
        view.backgroundColor = MPShared.backgroundColor
        
        // Features - btClose
        btClose.setTitle("", for: .normal)
        btClose.setImage(UIImage(systemName: "xmark"), for:.normal)
        btClose.backgroundColor = .clear
        btClose.tintColor = MPShared.textColorAVG
        btClose.addTarget(self, action: #selector(closeMediaPlayer(_:)), for: .touchUpInside)
        
        // Features - ivArtwork
        ivArtwork.image = UIImage(named: MPShared.songPlaying?.image ?? "")
        ivArtwork.contentMode = .scaleToFill
        ivArtwork.layer.cornerRadius = CGFloat(9)
        ivArtwork.layer.masksToBounds = true
        
        // Features - lbSongName
        lbSongName.textColor = MPShared.textColorAVG
        lbSongName.textAlignment = .left
        lbSongName.font = .boldSystemFont(ofSize: 25)
        lbSongName.adjustsFontSizeToFitWidth = true
        lbSongName.minimumScaleFactor = 0.5
        lbSongName.text = MPShared.songPlaying?.name
        
        // Features - lbArtist
        lbArtist.textColor = MPShared.textColorAVG
        lbArtist.textAlignment = .left
        lbArtist.font = .systemFont(ofSize: 22)
        lbArtist.adjustsFontSizeToFitWidth = true
        lbArtist.minimumScaleFactor = 0.5
        lbArtist.text = MPShared.songPlaying?.artist
        
        //Features - StackView
        stackviewBt.axis = .horizontal
        stackviewBt.distribution = .fillEqually
        stackviewBt.spacing = 10
        stackviewBt.tintColor = MPShared.textColorAVG
        addButtonsToStackView()
        
        //Features - SltimeMusic
        slTimeMusic.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
        slTimeMusic.tintColor = MPShared.textColorAVG
        slTimeMusic.thumbTintColor = MPShared.textColorAVG
        
        //Features - lbElapsedTime
        lbElapsedTime.textColor = MPShared.textColorAVG
        lbElapsedTime.font = .systemFont(ofSize: 10)
        lbRemainingTime.textAlignment = .left
       
        //Features - lbElapsedTime
        lbRemainingTime.textColor = MPShared.textColorAVG
        lbRemainingTime.font = .systemFont(ofSize: 10)
        lbRemainingTime.textAlignment = .right
        lbRemainingTime.text = MPShared.remainingTime

    }
    
    func addButtonsToStackView(){
        
        //Features - btBackward
        btBackward.setTitle("", for: .normal)
        btBackward.setImage(UIImage(systemName: MPShared.backwardStyle, withConfiguration: configButton), for: .normal)
        btBackward.backgroundColor = .clear
        btBackward.setTitleColor(.black, for: .normal)
        btBackward.layer.cornerRadius = 9
        btBackward.layer.masksToBounds = true
        btBackward.addTarget(self, action: #selector(didTapBackward(_:)), for: .touchUpInside)
        
        //Features - btPlayPause
        btPlayPause.setTitle("", for: .normal)
        let setButton = MPShared.setPlayPauseIcon(isPlaying: MPShared.player.isPlaying)
        btPlayPause.setImage(UIImage(systemName: setButton, withConfiguration: configButton1), for: .normal)
        btPlayPause.backgroundColor = .clear
        btPlayPause.setTitleColor(.black, for: .normal)
        btPlayPause.layer.cornerRadius = 9
        btPlayPause.layer.masksToBounds = true
        btPlayPause.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
        
        //Features - btForward
        btForward.setTitle("", for: .normal)
        btForward.setImage(UIImage(systemName: MPShared.forwardStyle, withConfiguration: configButton), for: .normal)
        btForward.backgroundColor = .clear
        btForward.setTitleColor(.black, for: .normal)
        btForward.layer.cornerRadius = 9
        btForward.layer.masksToBounds = true
        btForward.addTarget(self, action: #selector(didTapForward(_:)), for: .touchUpInside)
        
        
    }
    
    
    //MARK: Func - Actions
    

    @objc private func progressScrubbed(_ sender: UISlider){
        MPShared.player.currentTime = TimeInterval(Float(sender.value))
        slTimeMusic.maximumValue = Float(MPShared.player.duration)
        observeProgressbar()
        addFeaturesObjects()
    }
    @objc private func didTapBackward(_ sender: UIButton){
        MPShared.playingIndex -= 1
        if MPShared.playingIndex < 0 {
            MPShared.playingIndex = MPShared.musics.count - 1
        }
        MPShared.setupPlayer(music: MPShared.musics[MPShared.playingIndex])
        MPShared.play {
            slTimeMusic.value = 0.0
            slTimeMusic.maximumValue = Float(MPShared.player.duration)
            
        }
        observeProgressbar()
        addFeaturesObjects()
        
    }
    @objc private func didTapPlayPause(_ sender: UIButton){
        if MPShared.player.isPlaying {
            MPShared.player.pause()
        } else {
            MPShared.player.play()
        }
        observeProgressbar()
        addFeaturesObjects()
       
    }
    @objc private func didTapForward(_ sender: UIButton){
        nextMusic()
    }
    
    @objc private func closeMediaPlayer(_ sender: UIButton) {
        print("close")
        self.dismiss(animated: true,completion: nil)
    }
    
    
    //MARK: Func - Subviews
    
    
    private func addSubviews(){
        stackviewBt.addArrangedSubview(btBackward)
        stackviewBt.addArrangedSubview(btPlayPause)
        stackviewBt.addArrangedSubview(btForward)
        
        view.addSubview(btClose)
        view.addSubview(ivArtwork)
        view.addSubview(lbSongName)
        view.addSubview(lbArtist)
        view.addSubview(slTimeMusic)
        view.addSubview(stackviewBt)
        view.addSubview(lbElapsedTime)
        view.addSubview(lbRemainingTime)
    }
    
    
    
    //MARK: Func - Constrains
    
    private func addConstrains(){
        
        //Constrains - btClose
        btClose.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        btClose.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 10).isActive = true
        btClose.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10).isActive = true
        
        //Constrains - ivArtwork
        //AspectRadio (1:1)
        ivArtwork.heightAnchor.constraint(equalTo: ivArtwork.widthAnchor, multiplier: 1.0/1.0).isActive = true
        //trailing
        ivArtwork.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
        //leading
        ivArtwork.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22).isActive = true
        //top
        ivArtwork.topAnchor.constraint(equalTo: btClose.lastBaselineAnchor,constant: 10).isActive = true
        
        
        //Constrains - lbSongName
        //leading
        lbSongName.leadingAnchor.constraint(equalTo: ivArtwork.leadingAnchor).isActive = true
        //trailing
        lbSongName.trailingAnchor.constraint(equalTo: ivArtwork.trailingAnchor).isActive = true
        //top
        lbSongName.topAnchor.constraint(equalTo: ivArtwork.lastBaselineAnchor, constant: 12).isActive = true
        
        //Constrains - lbArtist
        //leading
        lbArtist.leadingAnchor.constraint(equalTo: ivArtwork.leadingAnchor).isActive = true
        //trailing
        lbArtist.trailingAnchor.constraint(equalTo: ivArtwork.trailingAnchor).isActive = true
        //top
        lbArtist.topAnchor.constraint(equalTo: lbSongName.lastBaselineAnchor, constant: 8).isActive = true
        
        //Constrains - slTimeMusic
        // Hugging Priority
        slTimeMusic.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        //leading
        slTimeMusic.leadingAnchor.constraint(equalTo: ivArtwork.leadingAnchor).isActive = true
        //trailing
        slTimeMusic.trailingAnchor.constraint(equalTo: ivArtwork.trailingAnchor).isActive = true
        //top
        slTimeMusic.topAnchor.constraint(equalTo: lbArtist.lastBaselineAnchor, constant: 50).isActive = true
    
        //Constrains - lbElapsedTime
        lbElapsedTime.leadingAnchor.constraint(equalTo: slTimeMusic.leadingAnchor).isActive = true
        lbElapsedTime.topAnchor.constraint(equalTo: slTimeMusic.bottomAnchor,constant: 5).isActive = true
        
        //Constrains - lbRemainingTime
        lbRemainingTime.trailingAnchor.constraint(equalTo: slTimeMusic.trailingAnchor).isActive = true
        lbRemainingTime.topAnchor.constraint(equalTo: lbElapsedTime.topAnchor).isActive = true
        
        //Constrains - StackView
        //Altura fixa
        stackviewBt.heightAnchor.constraint(equalToConstant: CGFloat(65)).isActive = true
        //leading
        stackviewBt.leadingAnchor.constraint(equalTo: ivArtwork.leadingAnchor).isActive = true
        //trailing
        stackviewBt.trailingAnchor.constraint(equalTo: ivArtwork.trailingAnchor).isActive = true
        //top
        stackviewBt.topAnchor.constraint(greaterThanOrEqualTo: slTimeMusic.lastBaselineAnchor, constant: 50).isActive = true
        //Botton
        let stBottomConstrain = stackviewBt.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        stBottomConstrain.isActive = true
        stBottomConstrain.priority = UILayoutPriority(rawValue: 250)
        
    }
    
    
}
