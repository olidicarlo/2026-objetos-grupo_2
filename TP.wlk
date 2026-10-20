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

        traje.usoDeTraje()
    }
    method atacar(otroGuerrero){
        otroGuerrero.recibirAtaque(potencial)
    }

    method semilla(){
        energiaActual = energiaOriginal
    }

}

class Traje {
    var desgaste = 0

    method usoDeTraje(){
        desgaste = (desgaste + 5).min(100)
    }

    method trajeSano() {
        return (100 - desgaste).min(1)
    }

    method estaGastado(){
    return desgaste >= 100
    }

    method absorcionDeDanio(potencialAtacante)
    method experienciaGanada()
}

class TrajeComun inherits Traje{
    const proteccion

    override method absorcionDeDanio(potencialAtacante){
        return (potencialAtacante * proteccion) * self.trajeSano() 
    }

    override method experienciaGanada(){
        return 1
    }
}

class TrajeEntrenamiento inherits Traje{

    override method absorcionDeDanio(potencialAtacante){
        return 0
    }

    override method experienciaGanada(){
        return 1 + (multiplicadorExp.multiplicadorActual() - 1) * self.trajeSano()
    }
}

object multiplicadorExp {
    var property multiplicadorActual = 2
// Como el enunciado dice q puede ser modificado a futuro, lo dejo como un unico objeto que puede ser modificado por fuer (prperty)
}

class TrajeModularizado inherits Traje {
    const property piezas = []

    method agregarPieza(_resistencia) {
        const pieza = new Pieza(porcentajeResistencia = _resistencia)
        piezas.add(pieza)
    }

    method piezasNoGastadas() {
        return piezas.filter({ pieza => not pieza.estaGastada() })
    }

    method totalResistencia() {
        return self.piezasNoGastadas().sum({ pieza => pieza.porcentajeResistencia() })
    }

    method porcentajeNoGastado() {
        return self.piezasNoGastadas().size() / piezas.size()
    }

    override method usoDeTraje() {
        piezas.forEach({ pieza => pieza.uso() })
        desgaste = ((piezas.size() - self.piezasNoGastadas().size()) * 100) / piezas.size()
    }

    override method estaGastado() = piezas.all({ pieza => pieza.estaGastada() }) || piezas.isEmpty()

    override method absorcionDeDanio(_danio) {
        return self.totalResistencia()
    }

    override method experienciaGanada() {
        return 1 + (1 * self.porcentajeNoGastado())
    }
}

class Pieza {
    const property porcentajeResistencia
    var property desgaste = 0

    method estaGastada() = self.desgaste() >= 20

    method uso() {
        desgaste = desgaste + 5
    }

    method porcentajeDesgaste() {
        return ((desgaste / 20).min(1)) * 100
    }
}

class Torneo {
    const participantesInscriptos = []

    method seleccionarParticipantes()
}

class TorneoPowerIsBest inherits Torneo {
    override method seleccionarParticipantes() {
        return participantesInscriptos
            .sortedBy({ g1, g2 => g1.potencial() > g2.potencial() })
            .take(16)
    }
}

class TorneoFunny inherits Torneo {
    override method seleccionarParticipantes() {
        return participantesInscriptos
            .sortedBy({ g1, g2 => g1.traje().cantidadDePiezas() > g2.traje().cantidadDePiezas() })
            .take(16)
    }
}

class TorneoSurprise inherits Torneo {
    override method seleccionarParticipantes() {
        return participantesInscriptos.shuffled().take(16)
    }
}

