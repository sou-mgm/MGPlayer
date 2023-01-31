//
//  LibraryViewController.swift
//  MGPlayer
//
//  Created by Matheus Matias on 23/01/23.
//

import UIKit

class LibraryViewController: UIViewController{
    

    //MARK: Elements
    private lazy var musicTableView: UITableView = {
        //Cria o objeto
        let newObject = UITableView(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
  
    private lazy var viPlayer: UIView = {
        //Cria o objeto
        let newObject = UIView(frame: .zero)
        // Desabilita o AutoResizing, para eu definir manualmente as constrains dele.
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
   
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
     
    private lazy var stackviewBt: UIStackView = {
        //Cria o objeto
        let newObject = UIStackView(frame: .zero)
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
    
    // Array de musica
    var musics: [Music]?
    // Instancia da PlayerViewController
    let playerVC = PlayerViewController()
        
    
    //MARK: Super func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstrains()
        //Add gestos de abertura da PlayerViewController
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(openPlayerTap(_:)))
        let gestureLongPress = UILongPressGestureRecognizer(target: self, action: #selector(openPlayerLongPress(_:)))
        viPlayer.isHidden = true
        viPlayer.addGestureRecognizer(gestureTap)
        viPlayer.addGestureRecognizer(gestureLongPress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addFeaturesObjects()
        prepareStackViewBt()
        observeProgressSong()
    }
    
    init(){
        //Inicializa a classe realizando a implementacao do array de musicas
        super.init(nibName: nil, bundle: nil)
        musics = MPShared.musics
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Observa o progresso da musica
    func observeProgressSong(){
        DispatchQueue.global(qos: .default).async {
            while(true){
                if self.MPShared.player.isPlaying {
                    if self.MPShared.songDidFinish {
                        DispatchQueue.main.async {
                            //Se finalizada, realiza um novo set das informacoes
                            self.addFeaturesObjects()
                            self.prepareStackViewBt()
                            self.MPShared.songDidFinish = false
                            
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: Func - Actions
    // Gestos para abrir view controler
    @objc private func openPlayerTap(_ gesture:UITapGestureRecognizer){
        playerVC.modalPresentationStyle = .fullScreen
        present(playerVC, animated: true,completion: nil)
    }
    
    @objc private func openPlayerLongPress(_ gesture: UILongPressGestureRecognizer){
        playerVC.modalPresentationStyle = .fullScreen
        present(playerVC, animated: true,completion: nil)
    }
    
    // Gestos dos botoes
    @objc private func didTapBackward(_ sender: UIButton){
        MPShared.playingIndex -= 1
        if MPShared.playingIndex < 0 {
            MPShared.playingIndex = MPShared.musics.count - 1
        }
        MPShared.setupPlayer(music: MPShared.musics[MPShared.playingIndex])
        MPShared.play {}
        addFeaturesObjects()
        
    }
    @objc private func didTapPlayPause(_ sender: UIButton){
        if MPShared.player.isPlaying {
            MPShared.player.pause()
        } else {
            MPShared.player.play()
        }
        prepareStackViewBt()
    }
    
    @objc private func didTapForward(_ sender: UIButton){
        MPShared.playingIndex += 1
        if MPShared.playingIndex >= MPShared.musics.count {
            MPShared.playingIndex = 0
        }
        MPShared.setupPlayer(music: MPShared.musics[MPShared.playingIndex])
        MPShared.play {}
        addFeaturesObjects()
    }
    

    
    
    //MARK: Func - Features
    private func addFeaturesObjects(){
        // Features - TableView
        musicTableView.delegate = self
        musicTableView.dataSource = self
        //Defini como celula padrao a MusicCell
        musicTableView.register(MusicCell.self, forCellReuseIdentifier: "cell")
        musicTableView.estimatedRowHeight = 75
        musicTableView.tableFooterView = UIView()
        
        // Features - View Player
        viPlayer.backgroundColor = MPShared.backgroundColor ?? .systemGray3
        viPlayer.layer.cornerRadius = 10
        viPlayer.layer.masksToBounds = true
        
        // Features - ivArtwork
        ivArtwork.image = UIImage(named: MPShared.songPlaying?.image ?? "nctHello")
        ivArtwork.contentMode = .scaleToFill
        ivArtwork.layer.cornerRadius = CGFloat(9)
        ivArtwork.layer.masksToBounds = true
        
        // Features - lbSongName
        lbSongName.textColor = MPShared.textColorAVG
        lbSongName.textAlignment = .left
        lbSongName.font = .boldSystemFont(ofSize: 20)
        lbSongName.adjustsFontSizeToFitWidth = true
        lbSongName.minimumScaleFactor = 0.7
        lbSongName.lineBreakMode = .byTruncatingTail
        lbSongName.text = MPShared.songPlaying?.name ?? ""
        
        
        // Features - lbArtist
        lbArtist.textColor = MPShared.textColorAVG
        lbArtist.textAlignment = .left
        lbArtist.font = .systemFont(ofSize: 19)
        lbArtist.adjustsFontSizeToFitWidth = true
        lbArtist.minimumScaleFactor = 0.7
        lbArtist.lineBreakMode = .byTruncatingTail
        lbArtist.text = MPShared.songPlaying?.artist ?? ""
        
        //Features - StackView
        stackviewBt.axis = .horizontal
        stackviewBt.distribution = .fillEqually
        stackviewBt.spacing = 10
        stackviewBt.tintColor = MPShared.textColorAVG
        
    }
    
    private func prepareStackViewBt(){
        //Features - btBackward
        btBackward.setTitle("", for: .normal)
        btBackward.setImage(UIImage(systemName: MPShared.backwardStyle), for: .normal)
        btBackward.backgroundColor = .clear
        btBackward.setTitleColor(.black, for: .normal)
        btBackward.layer.cornerRadius = 1
        btBackward.layer.masksToBounds = true
        btBackward.addTarget(self, action: #selector(didTapBackward(_:)), for: .touchUpInside)
        
        //Features - btPlayPause
        btPlayPause.setTitle("", for: .normal)
        let setButton = MPShared.setPlayPauseIcon(isPlaying: MPShared.player.isPlaying)
        btPlayPause.setImage(UIImage(systemName: setButton), for: .normal)
        btPlayPause.backgroundColor = .clear
        btPlayPause.setTitleColor(.black, for: .normal)
        btPlayPause.layer.cornerRadius = 1
        btPlayPause.layer.masksToBounds = true
        btPlayPause.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
        
        //Features - btForward
        btForward.setTitle("", for: .normal)
        btForward.setImage(UIImage(systemName: MPShared.forwardStyle), for: .normal)
        btForward.backgroundColor = .clear
        btForward.setTitleColor(.black, for: .normal)
        btForward.layer.cornerRadius = 1
        btForward.layer.masksToBounds = true
        btForward.addTarget(self, action: #selector(didTapForward(_:)), for: .touchUpInside)

    }
    
    //MARK: Func - addSubviews
    
    private func prepareViPlayer(){
        stackviewBt.addArrangedSubview(btBackward)
        stackviewBt.addArrangedSubview(btPlayPause)
        stackviewBt.addArrangedSubview(btForward)
        
        viPlayer.addSubview(ivArtwork)
        viPlayer.addSubview(lbSongName)
        viPlayer.addSubview(lbArtist)
        viPlayer.addSubview(stackviewBt)
        prepareStackViewBt()
    }
    
    
    private func addSubviews(){
        view.addSubview(musicTableView)
        prepareViPlayer()
        view.addSubview(viPlayer)
    }
    
    
    
    //MARK: Func - Constrains
    
    private func addConstrains(){
        //Constrains - Tableview
        //top
        musicTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //bottom
        musicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //trailing
        musicTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        //leading
        musicTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        
        //Constrains - View Player
        viPlayer.heightAnchor.constraint(equalTo: view.heightAnchor.self, multiplier: 0.15).isActive = true
        //bottom
        viPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -35).isActive = true
        //leading
        viPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        //trailing
        viPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
      
        //Constrains - ivArtwork
        // Aspect Ratio (1:1)
        ivArtwork.widthAnchor.constraint(equalTo: ivArtwork.heightAnchor, multiplier: 1.0/1.0).isActive = true
        //leading
        ivArtwork.leadingAnchor.constraint(equalTo:viPlayer.leadingAnchor,constant: 16).isActive = true
        //top
        ivArtwork.topAnchor.constraint(equalTo: viPlayer.topAnchor, constant: 10).isActive = true
        //bottom
        ivArtwork.lastBaselineAnchor.constraint(equalTo: viPlayer.lastBaselineAnchor,constant: -10).isActive = true
        
       
        //Constrains - lbSongName
        //top
        lbSongName.topAnchor.constraint(equalTo: ivArtwork.topAnchor).isActive = true
        //leading
        lbSongName.leadingAnchor.constraint(equalTo: ivArtwork.trailingAnchor, constant: 10).isActive = true
        //trailing
        lbSongName.trailingAnchor.constraint(equalTo: viPlayer.trailingAnchor, constant: -8).isActive = true
        
        //Constrains - lbArtist
        lbArtist.topAnchor.constraint(equalTo: lbSongName.lastBaselineAnchor, constant: 3).isActive = true
        //leading
        lbArtist.leadingAnchor.constraint(equalTo: lbSongName.leadingAnchor).isActive = true
        //trailing
        lbArtist.trailingAnchor.constraint(equalTo: lbSongName.trailingAnchor).isActive = true
    
        
        //Constrains - Stackview
        //Height
        stackviewBt.heightAnchor.constraint(equalToConstant: CGFloat(43)).isActive = true
        //leading
        stackviewBt.leadingAnchor.constraint(equalTo: lbSongName.leadingAnchor).isActive = true
        //trailing
        stackviewBt.trailingAnchor.constraint(equalTo:lbSongName.trailingAnchor).isActive = true
        //top
        stackviewBt.topAnchor.constraint(greaterThanOrEqualTo: lbArtist.lastBaselineAnchor, constant: 5).isActive = true
        //bottom
        stackviewBt.bottomAnchor.constraint(equalTo: ivArtwork.lastBaselineAnchor).isActive = true
        
    }
    
    //MARK: Func - Animations
    
    private func viPlayerInit() {
        if viPlayer.isHidden {
            viPlayer.alpha = 0.0
            UIView.animate(withDuration: 0.90) {
                self.viPlayer.isHidden = false
                self.viPlayer.alpha = 1.0
            }
        }
    }
    
    
   

    
}

    //MARK: Extension UITableView

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? MusicCell else {
            return UITableViewCell()
        }
        
        cell.music = musics![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Seleciona a musica
        let music = musics![indexPath.row]
        //Da um set no player
        MPShared.setupPlayer(music: music)
        
        //Da um set na view
        MPShared.setupView()
        // Caso nenhuma musica tenha sido tocada ainda, inicializa "view player"
        addFeaturesObjects()
        viPlayerInit()
        MPShared.playingIndex = indexPath.row
        MPShared.setupPlayer(music: MPShared.musics[indexPath.row])
        MPShared.play{}
        prepareStackViewBt()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}


