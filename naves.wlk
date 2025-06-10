class Nave {
  var  velocidad=100
  var  direccion =10

  method acelerar(numero){velocidad=(velocidad+numero).min(100000)} 
  method desacelerar(numero){velocidad=(velocidad-numero).max(0)} 
  method irHaciaElSol(){direccion=10}
  method escaparDelSol(){direccion=-10}
  method ponerseParaleloAlSol(){direccion=0}
  method acercarseUnPocoAlSol(){direccion=(direccion+1).min(10)}
  method alejarseUnPocoDelSol(){direccion=(direccion-1).max(-10)}
  //combustuble 
  var  combustible =0
  method cargarCombustible(litros){combustible+=litros}
  method descargarCombustible(litros){combustible=(combustible-litros).min(0)}
  //trankilidad
  method estaTranquila()=(combustible>=4000 and velocidad<=12000)
  //amenazas 
  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }
  method escapar(){}
  method avisar(){}
  //relajo
  method estaDeRelajo(){
    self.estaTranquila()
    self.tienePocaActividad()
  }
    //pocaActividad
  method tienePocaActividad()=true

}

class Baliza inherits Nave{
//color
var  color =null
method cambiarColorDeBaliza(colorNuevo){
  self.cambioAlgunaVezDeColor(colorNuevo)
  color=colorNuevo}

//cambio de bandera alguna vez 
var cambioColor=false
method cambioAlgunaVezDeColor(colorNuevo){if (colorNuevo!=color){cambioColor=true}}


//PREPARAR VIAJE
method prepararViaje(){
  self.cambiarColorDeBaliza("verde")
  self.ponerseParaleloAlSol()
  self.cargarCombustible(30000)
  self.acelerar(5000)
}
 //trankilidad
  override method estaTranquila()=super()   and color!="rojo"

//AMENAZAS

  //escapar
  override method escapar(){self.irHaciaElSol()}
  //avisar
  override method avisar(){ self.cambiarColorDeBaliza("rojo")}

//pocaActividad

override method tienePocaActividad() = cambioColor

}

class Pasajeros inherits Nave{

var property cantidadPasajeros =0
var  racionesComida =0
var  racionesBebida =0
var cantidadDeRacionesDeComidaServida=0
method cargarComida(cantidadRaciones){racionesComida=(racionesComida+cantidadRaciones)}
method descargarComida(cantidadRaciones){racionesComida=(racionesComida-cantidadRaciones).min(0)
//cantidad de comida servida
cantidadDeRacionesDeComidaServida+=cantidadRaciones.min(racionesComida)
}
method cargarBebida(cantidadRaciones){racionesBebida=(racionesBebida+cantidadRaciones)}
method descargarBebida(cantidadRaciones){racionesBebida=(racionesBebida-cantidadRaciones).min(0)}
//PREPARAR VIAJE
method prepararViaje(){
  self.cargarComida(self.cantidadPasajeros()*4)
  self.cargarBebida(self.cantidadPasajeros()*6)
  self.acercarseUnPocoAlSol()
  self.cargarCombustible(30000)
  self.acelerar(5000)
}

//AMENAZAS

//escapar
override method escapar(){self.acelerar(velocidad)}
//avisar
override method avisar(){
   self.descargarComida(cantidadPasajeros)
   self.descargarBebida(cantidadPasajeros*2)
}

//pocaActividad

override method tienePocaActividad() = cantidadDeRacionesDeComidaServida<50

  //raciones de comida (menos de 50)

}

class Combate inherits Nave{
//visible
var visible = true
method ponerseVisible(){visible=true}
method ponerseInvisible(){visible=false}
method estaInvisible()=!visible
//misiles
var desplegados = true
method desplegarMisiles(){desplegados=true}
method replegarMisiles(){desplegados=false}
method misilesDesplegados()=desplegados
//mensaje
const property mensajes =[] 
method emitirMensaje(unMensaje){mensajes.add(unMensaje)}
method mensajesEmitidos()=mensajes
method primerMensajeEmitido()=mensajes.first()
method ultimoMensajeEmitido()=mensajes.last()
method esEscueta()=mensajes.all({x=>x.size()<=30})
method emitioMensaje(unMensaje)=mensajes.count(unMensaje)
//PREPARAR VIAJE
method prepararViaje(){
  self.ponerseInvisible()
  self.replegarMisiles()
  self.acelerar(15000)
  self.emitirMensaje("Saliendo en misión")
  self.cargarCombustible(30000)
  self.acelerar(5000)
}
//trankilidad
  override method estaTranquila()=super()   and not self.misilesDesplegados()
//AMENAZAS

//escapar
override method escapar(){self.acelerar(velocidad)}
//avisar
override method avisar(){
   self.acercarseUnPocoAlSol()
   self.acercarseUnPocoAlSol()
   self.emitirMensaje( "Amenaza recibida")
}


}


class Hospital inherits Pasajeros{
//QUIROFANOS
var quirofano=true
method quirofanoPreparado()=quirofano
method prepararQuirofano(){quirofano=true}
//trankilidad
  override method estaTranquila()=super()   and  not self.quirofanoPreparado()

//AMENAZAS

//escapar
override method escapar(){
  super()
  self.prepararQuirofano()}


}




class Sigilosa inherits Combate{
//trankilidad

  override method estaTranquila()=super()   and self.estaInvisible()

  //AMENAZAS

//escapar
override method escapar(){
  super()
  self.desplegarMisiles()
  self.ponerseInvisible()
  }


}