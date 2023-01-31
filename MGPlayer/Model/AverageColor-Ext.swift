//
//  averageColor-Ext.swift
//  MGPlayer
//
//  Created by Matheus Matias on 23/01/23.
//

import UIKit

// Cria uma extensao para UIImage
extension UIImage {
    // Variavel computada de cor
    var averageColor: UIColor? {
        // recebe e desembrulha a imagem
        guard let inputImage = CIImage(image: self) else {return nil}
        // cria uma array de 4 itens (que será usado de parametro de cor), onde todos iniciam com o valor 0.
        var bitmap = [UInt8](repeating: 0, count: 4)
        // Cria uma variavel de avaliação de contexto para renderizar resultados de processamento de imagem e realizar análise de imagem. Neste caso analisando a cor.
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        //realiza um render do contexto de cor analisado, usando os limite (bounds) passados como parametros
        //add os valores red,green,blue e alpha em Bitmap
        context.render(inputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil);
        //retorna uma cor, usando como parametro os valores add em bitmap
        return UIColor(red: CGFloat(bitmap[0])/255, green: CGFloat(bitmap[1])/255, blue: CGFloat(bitmap[2])/255, alpha: CGFloat(bitmap[3])/255)
    }
}
