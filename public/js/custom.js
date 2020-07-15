const { holdReady } = require("jquery");

//Funcion para eliminar
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
                            '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaubi" placeholder="Rango Maximo"></div> </td>'+
                            '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajeubi" class="form-control porcentaje" name="email" required /> '+
                                '<span class="input-group-addon">%</span></div> '+
                            '</td>'+
                            '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                         '</tr>' ;
                         codigo.id ='ubicacionGeografica';
                                break;
        case "alternativaEnvio": 
                codigo.innerHTML='<tr id="alternativaEnvio">'+
                                '<td>Alternativa de Envío</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaenv" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajeenv" class="form-control porcentaje" name="email" required />'+ 
                                    '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                            '</tr>';
                            codigo.id ='alternativaEnvio'
                                break;
        case "costoEnvio": 
                codigo.innerHTML='<tr id="costoEnvio">'+
                                '<td>Costo de Envío</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalacostenv" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajecostenv" class="form-control porcentaje" name="email" required />'+
                                    '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                            '</tr>';
                            codigo.id ='costoEnvio';
                                break;
        case "cumplimientoEnvio": 
                codigo.innerHTML='<tr id="cumplimientoEnvio">'+
                                '<td>Cumplimiento de Envíos sin retraso</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalacumpli" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajecumpli" class="form-control porcentaje" name="email" required /> '+
                                    '<span class="input-group-addon">%</span></div> '+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                            '</tr>';
                codigo.id ='cumplimientoEnvio';
                                break;
        case "alternativaPago":  
                codigo.innerHTML='<tr id="alternativaPago">'+
                                '<td>Alternativas de Pago</td>'+
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaaltpago" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajealtpago" class="form-control porcentaje" name="email" required /> '+
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
                                '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaaltpago" placeholder="Rango Maximo"></div> </td>'+
                                '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajealtpago" class="form-control porcentaje" name="email" required /> '+
                                        '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                                '</tr>';
                codigo.id ='pedidosSatis';
                                break;
        case "pedidosRetras":  
        codigo.innerHTML='<tr id="pedidosRetras">'+
                        '<td>Pedidos Enviados con Retraso</td>'+
                        '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaaltpago" placeholder="Rango Maximo"></div> </td>'+
                        '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajealtpago" class="form-control porcentaje" name="email" required /> '+
                                '<span class="input-group-addon">%</span></div>'+
                        '</td>'+
                        '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                        '</tr>';
        codigo.id ='pedidosRetras';
                        break;  
        case "pedidosRecha":  
        codigo.innerHTML='<tr id="pedidosRecha">'+
                        '<td>Pedidos Rechazados</td>'+
                        '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaaltpago" placeholder="Rango Maximo"></div> </td>'+
                        '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajealtpago" class="form-control porcentaje" name="email" required /> '+
                                '<span class="input-group-addon">%</span></div>'+
                        '</td>'+
                        '<td><div><a onclick="eliminar(event)">Eliminar</a></div></td>'+
                        '</tr>';
        codigo.id ='pedidosRecha';
        case "pedidosCance":  
        codigo.innerHTML='<tr id="pedidosCance">'+
                       '<td>Pedidos Cancelados</td>'+
                       '<td id="escala"> <div> <input type="text" class="form-control escala" id="escalaaltpago" placeholder="Rango Maximo"></div> </td>'+
                       '<td id="porcentaje"> <div class="row"> <input type="text" id="porcentajealtpago" class="form-control porcentaje" name="email" required /> '+
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