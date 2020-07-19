@extends('layout.master')

@section('titulo','Gestion de Contratos')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
		<h3 class="mb-3 text-center display-5">Cancelar contrato<span class="strong verde">
		<div aling="center">
            <form class="form-inline form-group" action="{{route('contrato.fin')}}" method="POST">
            @method('POST')
            @csrf
                <label for="sel1">Cancelante</label>
                <select class="form-control" name="cancelante">
                    <option value="{{$contrato->nombre_prod}}">{{$contrato->nombre_prod}}</option>
					<option value="{{$contrato->nombre_prov}}">{{$contrato->nombre_prov}}</option>
                </select>
				<div class="form-group">
   					<label for="exampleFormControlTextarea1">Motivo de la cancelación</label>
    				<textarea class="form-control" name="desc" rows="3"></textarea>
 				</div>
				<button type="submit" class="btn btn-danger">Cancelar</button>
            </form>
        </div>
    </div>
</div>
@endsection