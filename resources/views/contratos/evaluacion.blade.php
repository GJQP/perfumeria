@extends('layout.master')

@section('scripts')
<script type="text/javascript" src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Gestion de Contratos')

@section('contenido')
@php
	$i=0; 
	$j=0; 
	$w=0; 
	$k=0
@endphp
<!--{{$id_prov}}-->
<div class="container mgt-2 mgrb-1">
	<div class="stage tarjeta muli">
    <div class="blockquote text-center">
    <br>
    @if(!empty($escala))
    <h3> Escala actual</h3>
    <div class="row blocktext">
            <table>   
            <div class="blocktext">
                <tr>
                    <th id="criterio">Fecha de registro</th>
                    <th id="escala">Valor minimo</th>
                    <th id="porcentaje">Valor máximo</th>
                </tr> 
                <tr>
                    <td>{{$escala[0]->fcha_reg}}</td>
                    <td id="escala">{{$escala[0]->rgo_ini}}</td>
                    <td>{{$escala[0]->rgo_fin}}</td>
                </tr>
            </div>
        </table>
    </div>
    <br><br>
    @endif
    <div class="blockquote text-center">
        <h3> Fórmula </h3>
        <form  method="POST" autocomplete="off" action="{{route('evaluacion.registrar', ['id_prod' => $id_prod, 'id_prov' => $id_prov])}}">
            @csrf
            <div class="blocktext mgln-4">            
                <table id="tabla" class="mgl-3">              
                    <tr>
                        <th id="">Criterio de Evaluacion</th>
                        <th id="porcentaje">Resultado obtenido</th>
                    </tr>       
                    @foreach($variables as $var)  
                        <tr>
                            <td>{{$var->nombre}}</td>
                            <td id="total"><input class="form-control form-control-sm" name="variables[{{$var->nombre}}]" type="number" placeholder="Valoración"> </td>
                        </tr>
                    @endforeach   
                </table>              
              </div>
              <br>
              <div>
                <button type="submit" class="btn btn-primary">Evaluar proveedor</button>
             </div>
        </form>
    </div>
	<div class="blockquote text-center">
	<h3 aling="centered">Información del proveedor</h3>
	</div>
	<div class="accordion" id="accordionExample">
    @if(!empty($ingredientes))
	<div class="card">
		<div class="card-header" id="headingOne">
		<h2 class="mb-0">
			<button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			Ingredientes del proveedor
			</button>
		</h2>
		</div>
		<div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
		<div class="card-body pdl-card">	
			<table>
				<tr>
					<th>Presantaciones</th>
					<th>CAS</th>
					<th>Nombre</th>
				</tr>
				@foreach($ingredientes as $ingrediente)
				<div class="form-check">
					<tr>
                        <td><a href="#">Ver</a></td>
						<td>{{$ingrediente->cas}}</td>
						<td>{{$ingrediente->nombre}}</td>
					</tr>
				</div>	
				@endforeach	
			</table>	
		</div>
		</div>
	</div>
    @endif
    @if(!empty($otros_ingredientes))
	<div class="card">
		<div class="card-header" id="headingTwo">
		<h2 class="mb-0">
			<button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			Otros ingredientes
			</button>
		</h2>
		</div>
		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
		<div class="card-body">
		@foreach($otros_ingredientes as $ingrediente)
		<div class="form-check">
  			<input class="form-check-input" type="checkbox" value="{{$ingrediente->cas}}" name="otros_ingredientes[{{$j++}}]" id="for{{$ingrediente->cas}}">
  			<label class="form-check-label" for="for{{$ingrediente->cas}}">
			  {{$ingrediente->cas}} {{$ingrediente->nombre}}
  			</label>
		</div>	
		@endforeach	
		</div>
		</div>
	</div>
    @endif
    @if(!empty($condicionesEnvio))
	<div class="card">
		<div class="card-header" id="headingThree">
		<h2 class="mb-0">
			<button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
			Condiciones de envio
			</button>
		</h2>
		</div>
		<div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
		<div class="card-body pdl-card">
		<table>
			<tr>
				<th>Servicio</th>
				<th>Recargo</th>
				<th>Medio</th>
				<th>Pais de Envio</th>
			</tr>
			@foreach($condicionesEnvio as $condicion)
			<div class="form-check">
				<tr>
					<td>{{$condicion->nombre}}</td>
					<td>{{$condicion->porce_serv}}</td>
					<td>{{$condicion->medio}}</td>
					<td>{{$condicion->pais}}</td>
				</tr>
			</div>	
			@endforeach	
		</table>
		</div>
		</div>
	</div>
    @endif
    @if(!empty($condicionesPago))
	<div class="card">
		<div class="card-header" id="headingThree">
		<h2 class="mb-0">
			<button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
			Condiciones de pago
			</button>
		</h2>
		</div>
		<div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionExample">
		<div class="card-body pdl-card">
			<table>
				<tr>
					<th>Tipo</th>
					<th>Número de Cuotas</th>
					<th>Plazo del Pago</th>
				</tr>
			@foreach($condicionesPago as $condicion)
			<div class="form-check">
				<tr>
					<td>{{$condicion->tipo}}</td>
					<td>{{$condicion->coutas}}</td>
					<td>{{$condicion->cant_meses}}</td>
				</tr>
			</div>	
			@endforeach	
		</table>
		</div>
		</div>
	</div>
    @endif
	</div>
	</div>	
</div>
<div class="modal fade" id="descuento" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
            	<div class="modal-body" >
				<h3 class="modal-title">¿El proveedor acepta?</h3>
				<div class="modal-footer" id="botones">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn btn-success">Aceptar</button>
				</div>
			</div>
			</div>	
        </div>
	</div>
<!-- Popup para agregar descuento-->
<!--div class="modal fade" id="descuento" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Agregar un Descuento</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" >
				<div class="input-group mgb-1 ">
                    <label>Ingrese el porcentaje del Descuento(opcional):</label>
                    <input type="text" class="desc mgl-1" aria-label="porcentajeDesc" aria-describedby="basic-addon2" name="porcentajeDesc">
                    <div class="input-group-append">
                    <span class="input-group-text" id="basic-addon2">%</span>
                    </div>
                </div>
                <div class="input-group">
                    <label>Ingrese el porcentaje del Descuento(opcional):</label>
                    <input type="date" class="form-control mgl-1" name="fechaDesc" aria-label="Fecha Culminacion" aria-describedby="basic-addon1">
                </div>
            </div>
            <div class="modal-footer" id="botones">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
				<button type="submit" class="btn btn-success">Aplicar</button>
			</form>
			</div>
			</div>	
        </div>
	</div-->
@endsection
