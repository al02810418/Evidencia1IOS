
import Foundation

struct JuegoAhorcado {
    var palabraObjetivo: String
    var intentosRestantes: Int
    var letrasAdivinadas: [Character]
    
    var palabraSecreta: String {
        return palabraObjetivo.map { letrasAdivinadas.contains($0) ? String($0) : "_" }.joined()
    }
    
    mutating func adivinar(letra: Character) {
        letrasAdivinadas.append(letra)
        if !palabraObjetivo.contains(letra) {
            intentosRestantes -= 1
        }
    }
}
