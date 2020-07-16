@extends('layout.master')

@section('scripts')

<script src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('nombre pagina','IFRA Administracion')
@section('titulo','Gestion Perfumistas')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <div class=" blocktext pdt-1 tablaDatos">
            <table>
                <tr>
                    <th id="nombres">Nombre del Perfumista</th>
                    <th>Genero</th>
                    <th>Fecha de Nacimiento</th>
                    <th class="accion"> Acción</th>
                </tr>
                @forelse ($perfumistas as $perfumista)
                <tr>
                    <td>{{$perfumista->nombre}}</td>
                    <td>{{$perfumista->genero === 'M'? 'Masculino':'Femenino'}}</td>
                    <td>{{$perfumista->fcha_nac}}</td>
                    <td>
                        <div><a href="{{"gestion-perfumista/". $perfumista->id}}">Modificar</a></div>
                        <div><a href="#" data-toggle="modal"  data-target="#eliminar" onclick="cambiar({{$perfumista->id}})">Eliminar</a></div>
                    </td>
                </tr>
                @empty
                <!-- TODO -->
                <p> no hay datos</p>
                @endforelse
            </table>
        </div>
        <!--Botones-->
        <div class="blocktext mgt-2 pdb-2 row">
            <button type="button" class="btn btn-primary mgl-1" ><a href="/gestion-perfumista/crear">Crear Perfumista</a></button>
        </div>
         <!-- Popup para la eliminacion de una formula-->
        <div class="modal fade" id="eliminar" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Eliminar Perfumista</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="contenido-modal">
                <p>
                    ¿Esta seguro que desea eliminar a este Perfumista?
                </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" onclick="eliminarFila()">Eliminar</button>
                </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection