@extends('layout.master')

@section('scripts')
<script type="text/javascript" src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Gestion de Formula')

@section('contenido')  
<div class="container mgt-2">
<div class="stage tarjeta muli">
	<form class="form form-group" action="{{route('escala.registrar', ['id_prod' => $id_prod])}}" method="POST">
	@csrf
	@method('POST')
        <div class="row blocktext">
            <h3 class="modal-title">Registra una nueva escala</h3>
        </div>
        <div class="row blocktext">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label for="min">Valor mínimo</label>
                    <input type="number" class="form-control" id="min" name="min" placeholder="Valor mínimo">
            	</div>
                <div class="form-group col-md-4">
                    <label for="max">Valor maximo</label>
                    <input type="number" class="form-control" id="max" name="max" placeholder="Valor máximo">
                </div>
                <div class="form-group col-md-4">
                    <div class="form-row">
                      <button type="submit" class="btn btn-primary mgl-1 mgt-2">Registrar nueva escala</button>
                    </div>
                </div>
            </div>
        </div>
        @if(!empty($escala))
        <p class="mgt-1 blocktext" for="empresas"><strong>Escala actual</strong><p>   
       <div class="blocktext pdb-2">
        <table> 
                <tr>
                    <th id="criterio">Fecha de registro</th>
                    <th id="escala">Valor minimo</th>
                    <th id="porcentaje">Valor máximo</th>
                </tr> 
                <tr>
                    <td>{{$escala[0]->fcha_reg}}</td>
                    <td id="escala"> {{$escala[0]->rgo_ini}}</td>
                    <td> {{$escala[0]->rgo_fin}}</td>
                </tr>
			
            </table>
       </div>
        </div> 	
        <div class="blocktext mgt-2 pdb-2 ">  
            <div class="blocktext mgt-2 pdb-2 ">
                <div class="blocktext mgt-2 pdb-2 row">
                    <a href="{{route('formula.index')}}" class="btn btn-danger" role="button" aria-pressed="true">Cancelar</a>
                    <button type="submit" class="btn btn-primary mgl-1" >Crear nueva escala</button>
                </div>
            </div>
        </div> 
        @else
        <div class="blocktext mgt-2 pdb-2 center">
            <h4>El productor consultado no tiene escalas definidas</h4>
        </div>
        @endif
	</form>
</div>	
</div>		
@endsection