@extends('layout.master')

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
	<h1 aling="centered">Creación del contrato</h1>
	</div>
	<form class="form-group" action="{{route('contrato.generar', [$id_prod, $id_prov])}}" method="POST">
	@csrf
	<div class="accordion" id="accordionExample">
	<div class="card">
		<div class="card-header" id="headingCero">
		<h2 class="mb-0">
			<button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseCero" aria-expanded="true" aria-controls="collapseOne">
			Exclusividad
			</button>
		</h2>
		</div>
		<div id="collapseCero" class="collapse" aria-labelledby="headingCero" data-parent="#accordionExample">
		<div class="card-body pdl-card2">		
			<input class="form-check-input" type="checkbox" value="True" name="exclusivo" id="forE">
  			<label class="form-check-label" for="forE">
			  Exclusivo
  			</label>		
		</div>
		</div>
	</div>
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
					<th>Eleccion</th>
					<th>CAS</th>
					<th>Nombre</th>
				</tr>
				@foreach($ingredientes as $ingrediente)
				<div class="form-check">
					<tr>
						<td><input  type="checkbox" value="{{$ingrediente->cas}}" name="ingredientes[{{$i++}}]" id="for{{$ingrediente->cas}}"></td>
						<td>{{$ingrediente->cas}}</td>
						<td>{{$ingrediente->nombre}}</td>
					</tr>
					<!--
						<input class="form-check-input" type="checkbox" value="{{$ingrediente->cas}}" name="ingredientes[{{$i++}}]" id="for{{$ingrediente->cas}}">
						<label class="form-check-label" for="for{{$ingrediente->cas}}">
						{{$ingrediente->cas}} {{$ingrediente->nombre}}
						</label>
					-->
				</div>	
				@endforeach	
			</table>	
		</div>
		</div>
	</div>
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
				<th>Eleccion</th>
				<th>Servicio</th>
				<th>Recargo</th>
				<th>Medio</th>
				<th>Pais de Envio</th>
			</tr>
			@foreach($condicionesEnvio as $condicion)
			<div class="form-check">
				<tr>
					<td><input  type="checkbox" value="{{$condicion->id_ubic}}" name="condicionesEnvio[{{$w++}}]" id="for{{$condicion->id_ubic}}"></td>
					<td>{{$condicion->nombre}}</td>
					<td>{{$condicion->porce_serv}}</td>
					<td>{{$condicion->medio}}</td>
					<td>{{$condicion->pais}}</td>

				</tr>
				<!--
				<input class="form-check-input" type="checkbox" value="{{$condicion->id_ubic}}" name="condicionesEnvio[{{$w++}}]" id="for{{$condicion->id_ubic}}">
				<label class="form-check-label" for="for{{$condicion->id_ubic}}">
				{{$condicion->nombre}} Recargo: {{$condicion->porce_serv}} Medio: {{$condicion->medio}} Para: {{$condicion->pais}}
				</label>-->
			</div>	
			@endforeach	
		</table>
		</div>
		</div>
	</div>
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
					<th>Eleccion</th>
					<th>Tipo</th>
					<th>Número de Cuotas</th>
					<th>Plazo del Pago</th>
				</tr>
			@foreach($condicionesPago as $condicion)
			<div class="form-check">
				<tr>
				<td><input  type="checkbox" value="{{$condicion->id}}" name="condicionesPago[{{$k++}}]" id="for{{$condicion->id}}"></td>
					<td>{{$condicion->tipo}}</td>
					<td>{{$condicion->coutas}}</td>
					<td>{{$condicion->cant_meses}}</td>
				</tr>
				<!--
				<input class="form-check-input" type="checkbox" value="{{$condicion->id}}" name="condicionesPago[{{$k++}}]" id="for{{$condicion->id}}">
				<label class="form-check-label" for="for{{$condicion->id}}">
				{{$condicion->tipo}} Número de cuotas: {{$condicion->coutas}} a pagar en {{$condicion->cant_meses}} meses
				</label>
			-->
			</div>	
			@endforeach	
		</table>
		</div>
		</div>
	</div>
	</div>
	</div>
	<div class="blocktext">
		<button type="submit" class="btn btn-primary">Generar contrato</button>
	</div>
	</form>
</div>
@endsection
