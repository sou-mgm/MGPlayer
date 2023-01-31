//
//  MusicCellStructure.swift
//  MusicBeat
//
//  Created by Matheus Matias on 11/11/22.
//

import Foundation
import UIKit

final class MusicCell: UITableViewCell{
    
    //Realiza o set das informacoes
    var music: Music? {
        didSet {
            if let music = music {
                ivArtwork.image = UIImage(named: music.image)
                lbSongName.text = music.name
                lbArtist.text = music.artist
                lbGenre.text = music.genre
            }
        }
    }
    
    private lazy var ivArtwork: UIImageView = {
        let newObject = UIImageView(frame: .zero)
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    private lazy var lbSongName: UILabel = {
        let newObject = UILabel(frame: .zero)
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    private lazy var lbArtist: UILabel = {
        let newObject = UILabel(frame: .zero)
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    private lazy var lbGenre: UILabel = {
        let newObject = UILabel(frame: .zero)
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    private lazy var stackViewMusic: UIStackView = {
        let newObject = UIStackView(frame: .zero)
        newObject.translatesAutoresizingMaskIntoConstraints = false
        return newObject
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addFeaturesObjects()
        addSubviews()
        addConstrains()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addFeaturesObjects(){
        //Features - ivArtwork
        ivArtwork.contentMode = .scaleAspectFill
        ivArtwork.layer.cornerRadius = CGFloat(5)
        ivArtwork.layer.masksToBounds = true
        

        // Features - lbSongName
        lbSongName.textColor = .black
        lbSongName.textAlignment = .left
        lbSongName.font = .boldSystemFont(ofSize: 14)
        lbSongName.adjustsFontSizeToFitWidth = true
        lbSongName.minimumScaleFactor = 0.5
       
        // Features - lbArtist
        lbArtist.textColor = .black
        lbArtist.textAlignment = .left
        lbArtist.font = .systemFont(ofSize: CGFloat(12))
        lbArtist.adjustsFontSizeToFitWidth = true
        lbArtist.minimumScaleFactor = 0.5
        

        // Features - lbGenre
        lbGenre.textColor = .black
        lbGenre.textAlignment = .left
        lbGenre.font = .systemFont(ofSize: CGFloat(9))
        lbGenre.adjustsFontSizeToFitWidth = true
        lbGenre.minimumScaleFactor = 0.5
           
        
        stackViewMusic.axis = .vertical
        stackViewMusic.distribution = .fillEqually
        stackViewMusic.spacing = 1
        stackViewMusic.tintColor = .black
        
    }
    
    
    
    private func addSubviews(){
        contentView.addSubview(ivArtwork)
        contentView.addSubview(stackViewMusic)
        stackViewMusic.addArrangedSubview(lbSongName)
        stackViewMusic.addArrangedSubview(lbArtist)
        stackViewMusic.addArrangedSubview(lbGenre)
        contentView.addSubview(stackViewMusic)
        
    }
    
    private func addConstrains(){
        //Constrains - ivArtwork
        //Size
       ivArtwork.widthAnchor.constraint(equalToConstant: 50).isActive = true
       ivArtwork.heightAnchor.constraint(equalToConstant: 50).isActive = true
       //leading
        ivArtwork.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
       //top
        ivArtwork.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor,constant: 7).isActive = true
       //Center Y
        ivArtwork.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        //Constrains - Stackview
        //top
        stackViewMusic.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor, constant: 5).isActive = true
        //Leading
        stackViewMusic.leadingAnchor.constraint(equalTo: ivArtwork.trailingAnchor, constant: 10).isActive = true
        //Trailing
        stackViewMusic.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        //bottom
       // stackViewMusic.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 10).isActive = true
        

        //Leading
        lbSongName.leadingAnchor.constraint(equalTo: stackViewMusic.leadingAnchor).isActive = true
        //Trailing
        lbSongName.trailingAnchor.constraint(equalTo: stackViewMusic.trailingAnchor).isActive = true
        
        
        //Leading
        lbArtist.leadingAnchor.constraint(equalTo: lbSongName.leadingAnchor).isActive = true
        //Trailing
        lbArtist.trailingAnchor.constraint(equalTo: lbSongName.trailingAnchor).isActive = true
       


        //Constrains - lbGenre
        //Leading
        lbGenre.leadingAnchor.constraint(equalTo: lbSongName.leadingAnchor).isActive = true
        //Trailing
        lbGenre.trailingAnchor.constraint(equalTo: lbSongName.trailingAnchor).isActive = true
        lbGenre.bottomAnchor.constraint(equalTo: stackViewMusic.bottomAnchor, constant: 0).isActive = true

         
         }
}
