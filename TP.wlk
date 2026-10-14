class Guerrero {
    const property potencial 
    const property energiaOriginal 
    var energiaActual = energiaOriginal
    var experiencia = 0
    const porcentajeDanio = 0.1
    var property traje = new TrajeComun(proteccion = 0)


    method energiaActual() { return energiaActual }
    method experiencia() { return experiencia }

    method estaMuerto(){
        return energiaActual == 0
    }

    method recibirAtaque(potencialAtacante){
        const danio = (potencialAtacante * porcentajeDanio - traje.absorcionDeDanio(potencialAtacante)).max(0)
        energiaActual = (energiaActual - danio).max(0)
        experiencia += traje.experienciaGanada()
    }
    method atacar(otroGuerrero){
        otroGuerrero.recibirAtaque(potencial)
    }

    method semilla(){
        energiaActual = energiaOriginal
    }

}

class TrajeComun{
    const proteccion

    method absorcionDeDanio(potencialAtacante){
        return potencialAtacante * proteccion 
    }

    method experienciaGanada(){
        return 1
    }
}

class TrajeEntrenamiento{

    method absorcionDeDanio(potencialAtacante){
        return 0
    }

    method experienciaGanada(){
        return 1 * multiplicadorExp.multiplicadorActual()
    }
}

object multiplicadorExp {
    var property multiplicadorActual = 2
// Como el enunciado dice q puede ser modificado a futuro, lo dejo como un unico objeto que puede ser modificado por fuer (prperty)
}