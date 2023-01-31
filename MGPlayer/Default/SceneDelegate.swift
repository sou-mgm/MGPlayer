//
//  SceneDelegate.swift
//  MGPlayer
//
//  Created by Matheus Matias on 23/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /*
     Anotações de estudo:
     
     A Window como se fosse um "Fichário", e as Views Controllers como páginas. Dentro de um Fichário, podemos utilizar diversas folhas, e transitar entre elas, sendo que ao abrir temos que ter a folha 1 (Root).
     
       Podemos pular entre paginas, mas através desta variável (Window) precisamos definir o que será exibido. Quando utilizamos o modo de ViewCode, pela falta de Storyboard, precisamos dizer ao SceneDelegate para quem "Apontar".
     
     ------------------------------------------------------------------------------------------------------
    UIWindow: A Windows trabalha com as Views Controllers para manipular eventos e executar muitas outras tarefas fundamentais para a operação do seu aplicativo. O UIKit lida com a maioria das interações relacionadas à janela, trabalhando com outros objetos conforme necessário para implementar muitos comportamentos de aplicativos.
     */
    

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //Desembrulha um objeto de cena
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // Usa o objeto para criar a UIWindow raiz
        let rootWindow = UIWindow(windowScene: windowScene)
        // Pega o tamanho total da tela(conforme o tamanho do iphone) e defini que a view terá o mesmo tamanho
        rootWindow.frame = UIScreen.main.bounds
        // Defini qual é a ViewController raiz
        rootWindow.rootViewController = LibraryViewController()
        // MakeKeyAndVisible - Responsavel por aprensentar nossa view controller
        rootWindow.makeKeyAndVisible()
        rootWindow.overrideUserInterfaceStyle = .light
        // Defini a "Janela Raiz" como sendo a IntroViewController
        window = rootWindow
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }


}


