@extends('layout.master')

@section('nombre pagina','IFRA Administracion')
@section('titulo','Perfumista')

@section('contenido')  
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli pdb-2">
        <div class="blocktext unna"> Creacion de Perfumista</div>
        <form method="POST" autocomplete="off">
            @csrf
            <div id="perfumistaInfo" >
                <div>
                    <label> Introduzca el nombre del Perfumista:
                    <input class="form-control" type="text" id="nombre"></label>
                </div>
                <div>
                    <label> Introduzca el genero del Perfumista:
                        <select class="form-control" id="tipo">
                            <option disabled selected value="0"> -- Seleccione un Genero -- </option>
                            <option value="masculino">Masculino</option>
                            <option value="femenino">Femenino</option>
                        </select>
                    </label>
                </div>
                <div>
                    <label for="fecha-nacimiento" class="col-form-label">Introduzca el año de Nacimiento(Opcional):
                    <input class="form-control" type="date" value="aaaa-mm-dd" id="fecha-nacimiento"></label>
                </div>
                <button class="btn btn-danger"><a href="/gestion-perfumista">Cancelar</a></button>
                <button type="submit" class="btn btn-primary">Crear</button>
            </div>
        </form>
    </div>
</div>
@endsection