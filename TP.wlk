class Guerrero {
    const property potencial 
    const property energiaOriginal 
    var energiaActual = energiaOriginal
    var experiencia = 0
    const porcentajeDanio = 0.1

    method energiaActual() { return energiaActual }
    method experiencia() { return experiencia }

    method estaMuerto(){
        return energiaActual == 0
    }

    method recibirAtaque(potencialAtacante){
        energiaActual =  (energiaActual - potencialAtacante * porcentajeDanio).max(0)
        experiencia += 1
    }
    method atacar(otroGuerrero){
        otroGuerrero.recibirAtaque(potencial)
    }

    method semilla(){
        energiaActual = energiaOriginal
    }

}
