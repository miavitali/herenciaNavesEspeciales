class Nave { // Clase abstracta sin instancias 

	var property velocidad = 0
	method propulsate(){
		self.acelerar(20000)
	}

	method preparateParaViajar() {
		self.acelerar(15000)
	}

	method acelerar(aumento) {
		velocidad = (velocidad + aumento).min(300000)
	}

	method encontrarseConEnemigo() {
		self.propulsate()
		self.recibirAmenaza()
	}
	method recibirAmenaza() //Abstracto
}

class NaveDeCarga inherits Nave{

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveDeResiduos inherits NaveDeCarga {
	var property sellada = false

	method sellate(){
		sellada = true
	} 

	override method recibirAmenaza(){
		velocidad = 0
	}

	override method preparateParaViajar(){
		super() //metodo para ejecutar lo que estoy sobreescribiendo
		self.sellate()
	}
}

class NaveDePasajeros inherits Nave{

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
		velocidad = 20000
	}

}


class NaveDeCombate inherits Nave{
	
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method preparateParaViajar(){
		super()
		modo.preparar(self)
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method preparar(nave) {
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method preparar(nave) {
		nave.emitirMensaje("Volviendo a la base")
	}

}

