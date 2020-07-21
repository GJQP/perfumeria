//Funcion para eliminar
var idEliminar;
var contRenovar;
var idprod;
var idprov;

function cambiar(id){
    idEliminar = id;
}

function eliminarFila() { 
    if (idEliminar){
        axios.delete('/gestion-perfumista/' + idEliminar).then(() => window.location.reload());
        
    }
}  
function cambio(e){
    let elemento = e.srcElement.id;
    console.log(elemento);
}

//Funcion para agregar los campos de la creacion de formula
function agregar(){
    //Obtener el criterio seleccionado
    var criterio = document.getElementById('criterios').value;
    var codigo = document.createElement('tr');
    switch(criterio){
        //Opciones cuando es de Inicio
        case "ubicacionGeografica":
                codigo.innerHTML='<tr id="ubicacionGeografica" style="display: none;">'+
                            '<td>Ubicacion Geográfica</td>'+
                            '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaubi" name="ubi-esc" placeholder="Rango Maximo"></div> </td>'+
                            '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajeubi" class="form-control porcentaje" name="ubi-peso" onblur="evaluacionPorcentaje()" required /> '+
                                '<span class="input-group-addon">%</span></div> '+
                            '</td>'+
                            '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                         '</tr>' ;
                         codigo.id ='ubicacionGeografica';
                                break;
        case "alternativaEnvio": 
                codigo.innerHTML='<tr id="alternativaEnvio">'+
                                '<td>Alternativa de Envío</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" name="altenv-escala" id="escalaenv" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajeenv" class="form-control porcentaje" name="altenv-peso" onblur="evaluacionPorcentaje()" required />'+ 
                                    '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                            '</tr>';
                            codigo.id ='alternativaEnvio'
                                break;
        case "costoEnvio": 
                codigo.innerHTML='<tr id="costoEnvio">'+
                                '<td>Costo de Envío</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalacostenv" name="costenv-esc" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajecostenv" class="form-control porcentaje" name="costenv-peso" onblur="evaluacionPorcentaje()" required />'+
                                    '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                            '</tr>';
                            codigo.id ='costoEnvio';
                                break;
        case "cumplimientoEnvio": 
                codigo.innerHTML='<tr id="cumplimientoEnvio">'+
                                '<td>Cumplimiento de Envíos sin retraso</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalacumpli" name="cumpli-esc" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajecumpli" class="form-control porcentaje" name="cumpli-peso" onblur="evaluacionPorcentaje()" required /> '+
                                    '<span class="input-group-addon">%</span></div> '+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                            '</tr>';
                codigo.id ='cumplimientoEnvio';
                                break;
        case "alternativaPago":  
                codigo.innerHTML='<tr id="alternativaPago">'+
                                '<td>Alternativas de Pago</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaaltpago" name="altpago-esc" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajealtpago" class="form-control porcentaje" name="altpago-peso" onblur="evaluacionPorcentaje()" required /> '+
                                    '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                            '</tr>';
                codigo.id ='alternativaPago';
                                break;
        //Opciones cuando es de Renovacion
         case "pedidosSatis":  
                 codigo.innerHTML='<tr id="pedidosSatis">'+
                                '<td>Pedidos Enviados Satisfactoriamente</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalapedidosatis" name="pedsatis-esc" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajepedidosatis" class="form-control porcentaje" name="pedidossatis-peso" onblur="evaluacionPorcentaje()" required /> '+
                                        '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                                '</tr>';
                codigo.id ='pedidosSatis';
                                break;
        case "pedidosRetras":  
        codigo.innerHTML='<tr id="pedidosRetras">'+
                        '<td>Pedidos Enviados con Retraso</td>'+
                        '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalapedidoretra" name="pedidosretra-esc" placeholder="Rango Maximo"></div> </td>'+
                        '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajepedidoretra" class="form-control porcentaje" name="pedidosretra-peso" onblur="evaluacionPorcentaje()" required /> '+
                                '<span class="input-group-addon">%</span></div>'+
                        '</td>'+
                        '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                        '</tr>';
        codigo.id ='pedidosRetras';
                        break;  
        case "pedidosRecha":  
        codigo.innerHTML='<tr id="pedidosRecha">'+
                        '<td>Pedidos Rechazados</td>'+
                        '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalapedidorecha" name="pedidorecha-esc" placeholder="Rango Maximo"></div> </td>'+
                        '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajepedidorecha" class="form-control porcentaje" name="pedidorecha-peso" onblur="evaluacionPorcentaje()" required /> '+
                                '<span class="input-group-addon">%</span></div>'+
                        '</td>'+
                        '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                        '</tr>';
        codigo.id ='pedidosRecha';
        case "pedidosCance":  
        codigo.innerHTML='<tr id="pedidosCance">'+
                       '<td>Pedidos Cancelados</td>'+
                       '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalapedidocance" name="pedidoscance-esc" placeholder="Rango Maximo"></div> </td>'+
                       '<td id="porcentaje"> <div class="row arreglar"> <input type="text" id="porcentajepedidocance" class="form-control porcentaje" name="pedidoscance-peso" onblur="evaluacionPorcentaje()" required /> '+
                               '<span class="input-group-addon">%</span></div>'+
                       '</td>'+
                       '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                       '</tr>';
       codigo.id ='pedidosCance';
                       break;
                        break;                              
    }
    //Deshabilitar la opcion de agregar un criterio
    $("option[value='"+ codigo.id + "']")
    .attr('disabled', 'disabled');
    //Insertar el criterio
    document.getElementById("total").before(codigo);
    $('#criterios').val('0');
}

//Funcion para eliminar los campos cuando la formula es de Renovacion
function eliminar(e){
    let elemento = e.srcElement.parentElement.parentElement.parentElement.id;
    //Haibilitar las opciones para seleccionar el Criterio
    $("option[value='"+ elemento +"']")
    .removeAttr('disabled');
    document.getElementById(elemento).remove();
}

//Funcion para siempre actualizar el % de la formula
function evaluacionPorcentaje(){
    console.log('Hola bb')
    var porcentaje = 0;
    //Porcentaje de Inicio
    if ($('#porcentajeubi').length){
        porcentaje += parseInt($('#porcentajeubi').val());
    }

    if ($('#porcentajeenv').length){
        porcentaje += parseInt($('#porcentajeenv').val());
    }

    if ($('#porcentajecostenv').length){
        porcentaje += parseInt($('#porcentajecostenv').val());
    }

    if ($('#porcentajecumpli').length){
        porcentaje += parseInt($('#porcentajecumpli').val());
    }
    if ($('#porcentajealtpago').length){
        porcentaje += parseInt($('#porcentajealtpago').val());
    }
    //Porcentaje de Renovacion
    if ($('#porcentajepedidosatis').length){
        porcentaje += parseInt($('#porcentajepedidosatis').val());
    }
    if ($('#porcentajepedidoretra').length){
        porcentaje += parseInt($('#porcentajepedidoretra').val());
    }
    if ($('#porcentajepedidorecha').length){
        porcentaje += parseInt($('#porcentajepedidorecha').val());
    }
    if ($('#porcentajepedidocance').length){
        porcentaje += parseInt($('#porcentajepedidocance').val());
    }
    console.log(porcentaje);

    $('#porcentajeTotal').text(porcentaje +'%');
}

function guardarId(id, prov, prod){
    contRenovar = id;
    idprov = prov;
    idprod = prod;
    console.log(contRenovar);
    console.log(idprov);
}

function preguntar(){
    console.log('hola');
    let cuerpo = '¿Qué acción desea realizar?'
    let boton = '<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>'+
                '<button type="button" class="btn btn-warning"><a onclick="cancelarContrato()" href="/gestion-contratos/crear/'+idprod+'/'+ idprov +'">Crear Nuevo Contrato</a></button>'+
                '<button type="button" class="btn btn-primary" onclick="renovar()">Renovar</button>';
    $('#cuerpo').text(cuerpo);
    $('#botones').html(boton);
    //"/gestion-contratos/crear/'+idprod+'/'+ idprov +'"
    //gestion-contratos/cancelar/{id_cont}/{id_prov}
}

function renovar(){
    axios.get('/gestion-contratos/renovar/' + contRenovar).then(() => window.location.reload());
}

function cancelarContrato(){
    console.log('hola');
    axios.delete('gestion-contratos/cancelar/'+ contRenovar+'/'+ idprod);
}

