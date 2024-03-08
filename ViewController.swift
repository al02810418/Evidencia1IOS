import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageViewArbol: UIImageView!
    @IBOutlet weak var labelPalabraCorrecta: UILabel!
    @IBOutlet weak var labelPuntuacion: UILabel!
    
    @IBOutlet var botonesLetras: [UIButton]!
    @IBAction func botonPresionado(_ sender: UIButton) {
        sender.isEnabled = false
        let letraString = sender.title(for: .normal)!
        let letra = Character(letraString.lowercased())
        juegoActual.adivinar(letra: letra)
        actualizarEstadoJuego()
    }
    
    var listaPalabras = ["tenis", "futbol", "basketbol"]
    var intentosPermitidos = 7
    var totalGanados = 0 {
        didSet {
            nuevaRonda()
        }
    }
    var totalPerdidos = 0 {
        didSet {
            nuevaRonda()
        }
    }
    var juegoActual: JuegoAhorcado!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nuevaRonda()
    }
    
    func nuevaRonda() {
        if !listaPalabras.isEmpty {
            let nuevaPalabra = listaPalabras.removeFirst()
            juegoActual = JuegoAhorcado(palabraObjetivo: nuevaPalabra, intentosRestantes: intentosPermitidos, letrasAdivinadas: [])
            habilitarBotonesLetras(true)
            actualizarInterfazUsuario()
        } else {
            habilitarBotonesLetras(false)
        }
    }
    
    func actualizarInterfazUsuario() {
        let letras = juegoActual.palabraSecreta.map { String($0) }
        let palabraConEspacios = letras.joined(separator: " ")
        labelPalabraCorrecta.text = palabraConEspacios
        
        labelPuntuacion.text = "Ganados: \(totalGanados), Perdidos: \(totalPerdidos)"
        imageViewArbol.image = UIImage(named: "Árbol \(juegoActual.intentosRestantes)")
    }
    
    func actualizarEstadoJuego() {
        if juegoActual.intentosRestantes == 0 {
            totalPerdidos += 1
        } else if juegoActual.palabraSecreta == juegoActual.palabraSecreta {
            totalGanados += 1
        } else {
            actualizarInterfazUsuario()
        }
    }
    
    func habilitarBotonesLetras(_ habilitar: Bool) {
        for boton in botonesLetras {
            boton.isEnabled = habilitar
        }
    }
}
