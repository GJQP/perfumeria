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
                            '<td id="porcentaje"> <div class="row arreglar"> <input type="number" min=1 max=100  value="1"  id="p_ubic" class="form-control porcentaje" name="p_ubic" onblur="evaluacionPorcentaje()" onload="evaluacionPorcentaje()" required /> '+
                                '<span class="input-group-addon">%</span></div> '+
                            '</td>'+
                            '<td><div><a onclick="eliminar(event)">Remover</a></div></td>'+
                         '</tr>' ;
                         codigo.id ='ubicacionGeografica';
                                break;
        case "alternativaEnvio":
                codigo.innerHTML='<tr id="alternativaEnvio">'+
                                '<td>Alternativa de Envío</td>'+
                                '<td id="porcentaje"> <div class="row arreglar"> <input type="number" min=1 max=100 id="p_alen" class="form-control porcentaje" name="p_alen" onblur="evaluacionPorcentaje()" onload="evaluacionPorcentaje()"  value="1" required />'+
                                    '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Remover</a></div></td>'+
                            '</tr>';
                            codigo.id ='alternativaEnvio'
                                break;
        case "alternativaPago":
                codigo.innerHTML='<tr id="alternativaPago">'+
                                '<td>Métodos de Pago</td>'+
                                '<td id="porcentaje"> <div class="row arreglar"> <input type="number" min=1 max=100 id="p_pag" class="form-control porcentaje" name="p_pag" onblur="evaluacionPorcentaje()" onload="evaluacionPorcentaje()"  value="1"  required /> '+
                                    '<span class="input-group-addon">%</span></div>'+
                                '</td>'+
                                '<td><div><a onclick="eliminar(event)">Remover</a></div></td>'+
                            '</tr>';
                codigo.id ='alternativaPago';
                                break;
        //Opciones cuando es de Renovacion
        case "cumplimientoEnvio":
        codigo.innerHTML='<tr id="cumplimientoEnvio">'+
                        '<td>Cumplimiento de Envíos sin retraso</td>'+
                        '<td id="porcentaje"> <div class="row arreglar"> <input type="number" min=1 max=100 id="p_cen" class="form-control porcentaje" name="p_cen" onblur="evaluacionPorcentaje()" value="100" readonly required /> '+
                        '<span class="input-group-addon">%</span></div> '+
                        '</td>'+
                        '<td><div><a onclick="eliminar(event)">Remover</a></div></td>'+
                    '</tr>';
        codigo.id ='cumplimientoEnvio';
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
    //console.log('Hola bb');
    var porcentaje = 0;
    //Porcentaje de Inicio
    if ($('#p_ubic').length){
        porcentaje += parseInt($('#p_ubic').val());
    }

    if ($('#p_alen').length){
        porcentaje += parseInt($('#p_alen').val());
    }

    if ($('#p_pag').length){
        porcentaje += parseInt($('#p_pag').val());
    }
    if ($('#p_cen').length){
        porcentaje += parseInt($('#p_cen').val());
    }
    console.log(porcentaje);

    $('#porcentajeTotal').text(porcentaje +'%');
}

function guardarId(id, prov, prod){
    contRenovar = id;
    idprov = prov;
    idprod = prod;
    console.log(idprod);
    console.log(idprov);
    console.log(contRenovar);
}

function renovar()
{
    window.location = '/gestion-contratos/evaluacion_ren/' + idprod + '/' + idprov + '/' + contRenovar;
}


function preguntar(){
    console.log('hola');
    let cuerpo = '¿Qué acción desea realizar?'
    let boton = '<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>'+
                '<button type="button" class="btn btn-success"><a onclick="cancelarContrato()" >Crear Nuevo Contrato</a></button>'+
                '<button type="button" class="btn btn-primary" onclick="renovar()">Renovar actual</button>';
    $('#cuerpo').text(cuerpo);
    $('#botones').html(boton);
}


function cancelarContrato(){
    console.log('Paso');
    window.location = 'gestion-contratos/cancelar/' + idprod + '/' + idprov + '/' + contRenovar;
}

function descuento(){
    camposDesc = '<div class="input-group mgb-1 ">'+
                    '<label>Ingrese el porcentaje del Descuento:</label>'+
                    '<input type="text" class="desc mgl-1" aria-label="porcentajeDesc" aria-describedby="basic-addon2" name="porcentajeDesc">'+
                    '<div class="input-group-append">'+
                    '<span class="input-group-text" id="basic-addon2">%</span>'+
                    '</div>'+
                '</div>'+
                '<div class="input-group">'+
                    '<label>Ingrese el porcentaje del Descuento:</label>'+
                    '<input type="date" class="form-control mgl-1" name="fechaDesc" aria-label="Fecha Culminacion" aria-describedby="basic-addon1">'+
                '</div>';
    botones ='<button type="button" class="btn btn-primary" data-dismiss="modal">Cancelar</button>'+
              '<button type="submit" class="btn btn-success">Aplicar</button>'+
              '</form>';
    $('.modal-body').html(camposDesc);
    $('#botones').html(botones);
}


function modificarFormula() {
    let form = document.getElementById('formula');
    let tabla = document.getElementById("total")
    let selc = document.getElementById('criterios');
    let titulo = document.getElementById('titulo');
    console.log(form.value);
    if(document.getElementById('ubicacionGeografica'))
        document.getElementById('ubicacionGeografica').remove();
    if(document.getElementById('alternativaEnvio'))
        document.getElementById('alternativaEnvio').remove();
    if(document.getElementById('costoProductos'))
        document.getElementById('costoProductos').remove();
    if(document.getElementById('cumplimientoEnvio'))
        document.getElementById('cumplimientoEnvio').remove();
    if(document.getElementById('alternativaPago'))
        document.getElementById('alternativaPago').remove();
    while (titulo.firstChild)
        titulo.removeChild(titulo.firstChild);
    while (selc.firstChild)
        selc.removeChild(selc.firstChild);
    switch(form.value){
        case '0':
            $('#formula').val('0');
            break;
        case 'inicial':
            selc.innerHTML = '<option disabled selected value="0"> -- Seleccione un Criterio -- </option>'+
            '<option value="ubicacionGeografica">Ubicacion Geografica</option>' +
            '<option value="alternativaEnvio">Alternativas de Envío</option>' +
            '<option value="alternativaPago">Alternativas de Pago</option>';
            titulo.innerHTML = '<strong>Creando Fórmula Inicial</strong>';
            $('#formula').val('inicial');
            break;
        case 'renovacion':
            selc.innerHTML = '<option disabled selected value="0"> -- Seleccione un Criterio -- </option>' +
            '<option value="cumplimientoEnvio">Cumplimiento de Envíos</option> ';
            titulo.innerHTML = '<strong>Creando Fórmula de Renovación</strong>';
            $('#formula').val('renovacion');
            break;
    }

}

function cambiarProveedorForm() {
    let idprod = document.getElementById('formis').value;
    console.log(idprod);
    axios.get('/gestion-formula/' + idprod ).then(() => window.location.reload());
}


function modalaPre(id_prov, id_ing) 
{
    if(id_prov == null)
        id_prov = -1;
    let modal = document.getElementById('mio');
    while (modal.firstChild)
        modal.removeChild(modal.firstChild); // medida unidad y precio
    modal.innerHTML = '<tr> <th>Medida</th> <th>Unidad</th> <th>Precio</th> </tr>';
    axios.get('/gestion-contratos/getProvedores/' + id_prov + '/' + id_ing).then(function (res){
        a = res.data.presentaciones;
        if(id_prov != -1)
        a.forEach(e => {
                modal.innerHTML += '<tr> <td>' + e.medida + '</td> <td>'+ e.unidad +'</td> <td>' + e.precio + '$</td></tr>';
             });
        else
            a.forEach(e => {
                modal.innerHTML += '<tr> <td>' + e.volumen + '</td> <td>'+ e.unidad +'</td> <td>' + e.precio + '$</td></tr>';
            });
    });   
}
