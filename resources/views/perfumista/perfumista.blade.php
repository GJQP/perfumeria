@extends('layout.master')

@section('nombre pagina','IFRA Administracion')
@section('titulo','Perfumista')

@section('contenido')  
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli pdb-2">
        <div class="blocktext unna"> Creacion de Perfumista</div>
        <form method="POST" autocomplete="off" action="{{empty($perfumista)? '/gestion-perfumista/crear':'/gestion-perfumista/' . $perfumista->id}}">
            
            @if(!empty($perfumista))
            @method('PUT');
            @endif

            @csrf
            <div id="perfumistaInfo" >
                <div>
                    <label> Introduzca el nombre del Perfumista:
                    <input class="form-control" type="text" name="nombre" id="nombre" value="{{$perfumista->nombre ?? ''}}"></label>
                </div>
                <div>
                    <label> Introduzca el genero del Perfumista:
                        <select class="form-control" name="genero" id="tipo">
                            <option disabled selected value="0"> -- Seleccione un Genero -- </option>
                            <option value="M" {{!empty($perfumista) && $perfumista->genero === "M"? 'selected':''}}>Masculino</option>
                            <option value="F" {{!empty($perfumista) && $perfumista->genero === "F"? 'selected':''}}>Femenino</option>
                        </select>
                    </label>
                </div>
                <div>
                    <label for="fecha-nacimiento" class="col-form-label">Introduzca el año de Nacimiento(Opcional):
                    <input class="form-control" type="date" name="fecha-nacimiento" value="{{$perfumista->fcha_nac ?? ''}}" id="fecha-nacimiento"></label>
                </div>
                <button class="btn btn-danger"><a href="/gestion-perfumista">Cancelar</a></button>
                @if(empty($perfumista))
                <button type="submit" class="btn btn-primary">Crear</button>
                @else
                <button type="submit" class="btn btn-primary">Editar</button>
                @endif
            </div>
        </form>
    </div>
</div>
@endsection