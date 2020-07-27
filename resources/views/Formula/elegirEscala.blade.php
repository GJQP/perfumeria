@extends('layout.master')

@section('scripts')
<script type="text/javascript" src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Gestion de Formula')

@section('contenido')  
    <div class="container mgt-2">
        <div class="stage tarjeta muli">
            <!--Seleccionar la Empresa-->
			<div class="row blocktext">
				<h3 class="modal-title">Registra una nueva escala</h3>
			</div>
            <div class="row blocktext">
			<form action="{{route('escala.registrar',['id_prod' => $id_prod])}}" method="POST">
			@csrf
			@method("POST")
			<div class="form-row">
				<div class="form-group col-md-4">
					<label for="min">Valor mínimo</label>
					<input type="text" class="form-control" id="min" name="min" placeholder="Valor mínimo">
				</div>
				<div class="form-group col-md-4">
					<label for="max">Valor maximo</label>
					<input type="text" class="form-control" id="max" name="max" placeholder="Valor máximo">
				</div>
				<div class="form-group col-md-4">
					<div class="form-row">
						<button type="submit" class="btn btn-primary mgl-1">Registra una nueva escala</button>
					<div>
				</div>
			</div>
			</form>
        </div>
            <!--Tipo de Formula-->
            @if(!empty($escala))
			<table class="mgl-3 consulta"> 
            <p class="mgt-1 text-center" for="empresas"><strong>Escala actual</strong><p>   
			<div class="blocktext mgln-4">
            <table class="mgl-3 consulta">                
				<tr>
                    <th id="criterio">Fecho de registro</th>
                    <th id="escala">Valor minimo</th>
                    <th id="porcentaje">Valor máximo</th>
                </tr> 
                <tr>
                    <td>{{$escala[0]->fcha_reg}}</td>
                    <td id="escala"> <div class="escala"> <p>{{$escala[0]->rgo_ini}}</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">{{$escala[0]->rgo_fin}}</p> </div> </td>
                </tr>
			</table>
			</div>
			</div> 	
				<div class="blocktext mgt-2 pdb-2 row">
				<a href="{{route('formula.index', ['id_prod' => $id_prod])}}" class="btn btn-danger" role="button" aria-pressed="true">Cancelar</a>
					<button type="button" class="btn btn-success mgl-1"><a href="{{route('formula.crear',['id_prod' => $id_prod,'fcha_for' =>  $escala[0]->fcha_reg])}}">Continuar</a></button>
            	</div>
			</div> 
			@else
			<div class="blocktext mgt-2 pdb-2 row">
				<h4>El productor consultado no tiene escalas definidas</h4>
			</div>
			<div class="blocktext mgt-2 pdb-2 row">
                  <a href="{{route('formula.index', ['id_prod' => $id_prod])}}" class="btn btn-danger" role="button" aria-pressed="true">Cancelar</a>
            </div>
			@endif			
        </div>
    </div>
</div>
@endsection