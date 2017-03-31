//
//  QuadroController.swift
//  Triangolo
//
//  Created by Alex Contursi on 30/03/17.
//  Copyright © 2017 Alex Contursi. All rights reserved.
//

import UIKit
import AVFoundation

var lastScale = CGFloat()// ci serve per recuperare lo stato iniziale delle view che vogliamo zummare
var player: AVAudioPlayer? // è la varabilie che ci serve  per inserire un suono nella nostra app



//############################# CALCOLA COLORE RANDOM ##############################//
extension CGFloat{
    static func casaccio()->CGFloat{
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor{
    static func casaccioColor()->UIColor{
        
        return UIColor(red: .casaccio(),green: .casaccio(),blue: .casaccio(), alpha: 1.0)
    }
}
//############################# CALCOLA COLORE RANDOM FRA IL BIANCO E IL NERO ##############################//
extension UIColor{
    static func anni60()->UIColor{
        let mono = CGFloat.casaccio()
        return UIColor(red: mono,green: mono,blue: mono, alpha:1.0)
    }
}
//##################################### FINE ######################################//


//##################################### CONTROLLO VALORE COLORE PER NON METTERE COLORI UGUALI ######################################//
extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}
//##################################### FINE ######################################//

class QuadroController: UIViewController {

    //##################################### COLLEGAMENTI VIEW ######################################//
    @IBOutlet weak var primo: UIView!
    @IBOutlet weak var secondo: UIView!
    @IBOutlet weak var terzo: UIView!
    @IBOutlet weak var quarto: UIView!
    @IBOutlet weak var quinto: UIView!
    @IBOutlet weak var sesto: UIView!
    @IBOutlet weak var settimo: UIView!
    @IBOutlet weak var ottavo: UIView!
    //##################################### FINE ######################################//
    var arrayView = [UIView]()
    var arrayColor = [UIColor]()
    
    var colors = true// PER IMPOSTARE I COLORI INZIALI DELL APP
    
    //#####################################  ZOOM DELLA VIEW ######################################//
    @IBAction func zoomQuarto(_ sender: UIPinchGestureRecognizer) {
     
        let gesture = sender
        if(gesture.state == .began){
            lastScale = gesture.scale
        }
        if(gesture.state == .began || gesture.state == .changed){
            let currentScale = gesture.view!.layer.value(forKeyPath: "transform.scale")!
            as! CGFloat
            let kMaxScale: CGFloat = 2.0
            let kMinScale: CGFloat = 1.0
            var newScale = 1 - (lastScale - gesture.scale)
            newScale = min(newScale, kMaxScale / currentScale)
            newScale = max(newScale, kMinScale / currentScale)
            let transform = (gesture.view?.transform)!.scaledBy(x: newScale, y: newScale);
            gesture.view?.transform = transform
        }
        print("pinch")
    }
    
    //##################################### FINE ######################################//
    
   //##################################### CAMBIO I COLORI DEL QUADRO AD OGNI TASTO ######################################//
    @IBAction func Cambia(_ sender: Any) {
        print("siii")
        
        self.GeneraColore()
//        self.primo.backgroundColor   = .casaccioColor()
//        self.secondo.backgroundColor = .casaccioColor()
//        self.terzo.backgroundColor   = .casaccioColor()
//        self.quarto.backgroundColor  = .casaccioColor()
//        self.quinto.backgroundColor  = .casaccioColor()
//        self.sesto.backgroundColor   = .casaccioColor()
//        self.settimo.backgroundColor = .casaccioColor()
//        self.ottavo.backgroundColor  = .casaccioColor()
//   INVECE DI FARE TUTTE QUESTE RIGHE POSSIAMO FARE UN CICLO MODIFICANDO I TAG PER LE VARIE VIEW
    }
    //##################################### FINE ######################################//
    
    //################################## RIDIMENSIONIAMO LA VIEW CON IL DOPPIO CLICK #################################//
    
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        
        self.playSound()
        UIView.animate(withDuration: 0.5, animations: {
                sender.view!.transform = CGAffineTransform.identity
        }, completion:{ Bool in
        })
        
    }
    //##################################### FINE ######################################//
    
    //##################################### INSERIMENTO DI UN MP3 SU UN TASTO O VIEW IN UNA APP IOS ######################################//
    func playSound() {
        
        let url = Bundle.main.url(forResource: "fail-trombone-03", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    //##################################### FINE ######################################//
    //##################################### EVITA COLORE SIMILE  ######################################//
    
    func similitudine(colore: UIColor, arrayColori: [UIColor], delta: CGFloat )-> Bool{
        
        let red1 = colore.components.red
        let green1 = colore.components.green
        let blue1 = colore.components.blue
        
        for color in arrayColori{
            let red2 = color.components.red
            let green2 = color.components.green
            let blue2 = color.components.blue
            
            if abs(red1 - red2) <= delta && abs(green1 - green2) <= delta && abs(blue1 - blue2) <= delta{
                return true
            }
        }
        return false
    }
    
    //##################################### FINE ######################################//
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
           self.GeneraColore()
        
        //self.arrayView.append(contentesOf: [ primo(),secondo(),terzo(),quarto(),quinto(),sesto(),settimo(),ottavo()]
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation
     
     //In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //  Get the new view controller using segue.destinationViewController.
       //  Pass the selected object to the new view controller.
        
        
        
    //}
    //#####################################     ######################################//
    func GeneraColore(){
        self.arrayColor.removeAll()
        for i in self.view.subviews {
            
            if (i.tag == 1){
                
                var newColor = UIColor()
                var delta = CGFloat()
                
                if self.colors == true{
                    newColor = UIColor.casaccioColor()
                    delta = 0.2
                }else{
                    newColor = UIColor.anni60()
                    delta = 0.05
                }
                
                if  self.arrayColor.count != 0{
                    
                    while similitudine(colore: newColor, arrayColori: self.arrayColor, delta: delta){
                        
                        if self.colors == true{
                            newColor = UIColor.casaccioColor()
                            delta = 0.2
                        }else{
                            newColor = UIColor.anni60()
                            delta = 0.05
                        }
                    }
                    self.arrayColor.append(newColor)
                    
                }else{
                    self.arrayColor = [newColor]
                }
                i.backgroundColor = newColor
            }
        }

    }
    //##################################### FINE ######################################//
    

}
