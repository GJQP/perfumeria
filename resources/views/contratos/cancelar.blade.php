@extends('layout.master')

@section('titulo','Gestion de Contratos')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
		<h2 class="mb-3 text-center display-5">Cancelar contrato<span class="strong verde">
		<div aling="center">
            <form class="form-group pdb-2" action="{{route('contrato.fin', $contrato->id)}}" method="POST">
            @method('POST')
            @csrf
            <div class="blocktext">
                <label class="mgt-1 cancelLabel" for="sel1">Empresa Cancelante:</label>
                <select class="form-control mgl-1 mgt-1 cancelante" name="cancelante">
                    <option value="{{$contrato->nombre_prod}}">{{$contrato->nombre_prod}}</option>
					<option value="{{$contrato->nombre_prov}}">{{$contrato->nombre_prov}}</option>
                </select>
            </div>
			<div class="form-group form-inline blocktext">
   				<label for="desc" class="cancelDescLabel mgr-1">Motivo de la cancelación:</label>
    			<textarea class="form-control descCancel mgt-2" name="desc" rows="3"></textarea>
 			</div>
				<button type="submit" class="btn btn-danger ">Cancelar</button>
            </form>
        </div>
    </div>
</div>
@endsection