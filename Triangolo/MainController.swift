//
//  ViewController.swift
//  Triangolo
//
//  Created by Alex Contursi on 28/03/17.
//  Copyright © 2017 Alex Contursi. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    var threetouches = [CGPoint]()

    @IBOutlet weak var Quelloli: UIButton!
    
    @IBAction func thirdButtonPassed(_ sender: Any) {
        print("looot")
    }
    // Mark : le palle
    class Triangolo{
        enum TipoTriangolo{
            case isoscele, scaleno, equilatero, generico
        }

        var lato1 : Int
        var lato2 : Int
        var lato3 : Int
        var tipo: TipoTriangolo?

        init(_ lato1: Int, _ lato2: Int, _ lato3: Int){
            self.lato1 = lato1
            self.lato2 = lato2
            self.lato3 = lato3
            self.tipo = getTriangoloTipo(lato1, lato2, lato3)
        }
        
        func getTriangoloTipo(_ lato1: Int, _ lato2: Int, _ lat3: Int)-> TipoTriangolo{
            
            let delta = 20
            
            if (lato1 == lato2 && lato1 != lato3 && lato2 != lato3) || (lato1 != lato2 && lato1 == lato3 && lato2 != lato3) || (lato1 != lato2 && lato1 != lato3 && lato2 == lato3){
                return TipoTriangolo.isoscele
            }
            else if abs(lato1-lato2) <= delta && abs(lato1-lato3) <= delta{
                return TipoTriangolo.equilatero
            }
            else if lato1 != lato2 && lato2 != lato3 && lato1 != lato3{
                return TipoTriangolo.scaleno
            }
            return TipoTriangolo.generico
        }
        
    }

    // Mark: override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view caricata")
        
        
        self.view.backgroundColor = UIColor.magenta
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print("sto apparendo")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //stampiamo le coordinate di 3 tocchi per calcolare le distanze tra le coordinate
        for touch in touches{
            let coordinates = touch.location(in: self.view)
            if threetouches.count < 3{
                self.threetouches.append(coordinates)
            }
            
        }
        if self.threetouches.count >= 3 {
            print(self.threetouches)
            
            let d1 = distance(a: self.threetouches[0], b: self.threetouches[1])
            let d2 = distance(a: self.threetouches[1], b: self.threetouches[2])
            let d3 = distance(a: self.threetouches[0], b: self.threetouches[2])
            
            print(d1,d2,d3)
            
            self.threetouches.removeAll()
            let triangolo = Triangolo(d1, d2, d3)
            if let safeTr = triangolo.tipo {
                print(safeTr)
                switch safeTr {
                case .equilatero:
                  self.view.backgroundColor = UIColor.red
                case .isoscele:
                    self.view.backgroundColor = UIColor.blue
                case .scaleno:
                    self.view.backgroundColor = UIColor.green
                default:
                    self.view.backgroundColor = UIColor.yellow
                }
            }
        }
    }
    // MArk: func
    func distance(a: CGPoint, b: CGPoint) -> Int {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return Int(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var color = true
        
        if segue.identifier == "BiancoNero"{
            
            color = false
        }
        
        if let destinationViewController = segue.destination as? QuadroController{
            
            destinationViewController.colors = color
        }
    }
}




