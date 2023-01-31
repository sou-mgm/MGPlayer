//
//  MPViewModel.swift
//  MGPlayer
//
//  Created by Matheus Matias on 27/01/23.
//

import UIKit
import AVKit


class MPViewModel: UIViewController {
    
    //MARK: Variables
    
    // Instancia estatica da classe
    static let shared = MPViewModel()
    // Array de musicas
    var musics = Music.getMusic()
    // Musica sendo tocada
    var songPlaying: Music?
    // Player
    var player = AVAudioPlayer()
    //Timer para acompanhar progresso da musica
    var timer: Timer?
    // Index
    var playingIndex = 0
    // Barra de progresso
    var progressBar: Float = 0.0
    // Cor de fundo
    var backgroundColor: UIColor?
    // Cor do texto
    var textColorAVG: UIColor?
    // Tempo maximo na musica
    var remainingTime: String = ""
    // Tempo minimo na musica
    var elapsedTime: String = ""
    // Musica finalizada
    var songDidFinish: Bool = false
    
    // Imagem dos estados do botao
    let playStyle = "play.fill"
    let pauseStyle = "pause.fill"
    let backwardStyle = "backward.fill"
    let forwardStyle = "forward.fill"
    
    //Método para Setup da musica
    func setupPlayer(music: Music) {
        //Desembulha musica
        guard let url = Bundle.main.url(forResource: music.file, withExtension: ".mp3") else {
            return
        }
        
        //Inicializa um timer
        if timer == nil {
            timer = Timer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
        
        // Setup da instancia
        songPlaying = Music(name: music.name, image: music.image, artist: music.artist, genre: music.genre, file: music.file)
       
        // Inicializa a musica
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Método para Setup da view de player
    func setupView() {
        //Verifica se há musica
        guard let songPlaying = songPlaying else {
            return
        }
        // Set da imagem
        let artworkSong =  UIImage(named:songPlaying.image)
        // Utiliza a extensao para achar a cor média
        backgroundColor = artworkSong?.averageColor
        //Verifica o background para definir cor do label
        textColorAVG = checkColor(color: backgroundColor!)
    }
    
    //Método para verificar a cor da imagem para definir o a cor do label
    func checkColor (color: UIColor) -> UIColor {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        // recebe as cores do backgorund e add nas variaveis
        color.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        // verifica se a cor é menor que 128/255 (Cores escuras)
        let verificationColor = r1 < 0.50 && g1 < 0.50 && b1 < 0.50
        //chama o metedo para trocar cor do label
        let color = changeLabelColor(with: verificationColor)
        return color
    }
    
    //Método para verificar a cor do label.
    func changeLabelColor(with darkBackground: Bool) -> UIColor {
        var color: UIColor = .clear
        // se o backgorund for escuro
        if darkBackground {
            //textColor será branco
            color = .white
        } else {
            //Se nao é preto
            color = .black
        }
        return color
    }
    
    // Método para verificar icone do botao
    func setPlayPauseIcon(isPlaying: Bool) -> String {
        var icon: String = "play.fill"
        if isPlaying {
            icon = pauseStyle
        } else {
            icon = playStyle
        }
        return icon
    }
    
    // Método para inicializar musica, onde possui uma closure para ser utilizad no PlayerViewController
    func play(_: ()->Void){
        player.play()
        setupView()
        updateProgress()
    }
    
    // Método para atualizar barra de progresso
    @objc func updateProgress() {
        // atualizar o valor da barra de progresso conforme decorrer da musica
        progressBar = Float(player.currentTime)
        //Faz setup do valor decorrido, que muda conforme toca
        elapsedTime = getFormattedTime(timeInterval: player.currentTime)
        //Faz setup do valor que falta a ser decorrido
        let remainingTimeToStr = player.duration - player.currentTime
        remainingTime = getFormattedTime(timeInterval: remainingTimeToStr)
    }
    
    //Faz formatacao dos valores de progresso de tempo
    func getFormattedTime(timeInterval: TimeInterval) -> String {
        //tranforma o valor recebido de tempo em minutos
        let mins = timeInterval / 60
        //Tranforma o tempo restante em segundo
        //truncatingRemainder - Retorna o restante desse valor dividido pelo valor fornecido usando a divisão truncada.
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        //inicializa um formatador de numeros
        let timeFormatter = NumberFormatter()
        //defini como tendo 2 casas depois da "virgula"
        timeFormatter.minimumIntegerDigits = 2
        //Defini que nao tera nenhum outro separador apos a "virgula"
        timeFormatter.minimumFractionDigits = 0
        //O modo de arredondamento usado pelo receptor = Arredondar para zero. Logo evita mais casas no numero alem de 00:00
        timeFormatter.roundingMode = .down
        //Realiza o setup do valor
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        return "\(minsString):\(secStr)"
    }
    
}

extension MPViewModel: AVAudioPlayerDelegate {
    // Informa quando a musica foi finalizada
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Musica finalizada")
        if flag {
            songDidFinish = true
        }
        
    }
}



