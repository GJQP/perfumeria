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
        <form method="POST" autocomplete="off" action="{{route('evaluacion.renregistrar', ['id_prod' => $id_prod, 'id_prov' => $id_prov, 'id' => $id_ctra])}}">
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
			 <br>
        </form>
    </div>
<div>
@endsection