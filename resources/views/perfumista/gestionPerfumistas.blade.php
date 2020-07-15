@extends('layout.master')

@section('scripts')

<script src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('nombre pagina','IFRA Administracion')
@section('titulo','Gestion Perfumistas')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <div class=" blocktext mgt-2 tablaDatos">
            <table>
                <tr>
                    <th class="nombre">Nombre del Perfumista</th>
                    <th class="expiracion">Genero</th>
                    <th class="">Fecha de Nacimiento</th>
                    <th class="accion">Acción</th>
                </tr>
                
                <!--
                @foreach($perfumistas as $perfumista)
                    <td>{{ $perfumista->nombre}}</td>
                    <td>{{ $perfumista->genero }}</td>
                    <td>{{ $perfumista->fecha_nacimiento}}</td>
                    <td>
                        <div><a href="/gestion-perfumista/{{$perfumista->id}}" >Modificar</a></div>
                        <div><a href="#" data-toggle="modal"  data-target="#eliminar" id="1" onclick="cambio(event)">Eliminar</a></div>
                    </td>
                @endforeach
                -->

                <tr>
                    <td>Andres Garcia</td>
                    <td>Masculino</td>
                    <td>20/10/1999</td>
                    <td>
                        <div><a href="#" >Modificar</a></div>
                        <div><a href="#" data-toggle="modal"  data-target="#eliminar" id="1" onclick="cambio(event)">Eliminar</a></div>
                    </td>
                </tr>
                <tr>
                    <td>Marina Martinez</td>
                    <td>Femenino</td>
                    <td>20/10/1999</td>
                    <td>
                        <div><a href="">Modificar</a></div>
                        <div><a href="">Eliminar</a></div>
                    </td>
                </tr>
                <tr>
                    <td>Gustavo Quintana</td>
                    <td>Masculino</td>
                    <td>20/10/1976</td>
                    <td>
                        <div><a href="">Modificar</a></div>
                        <div><a href="">Eliminar</a></div>
                    </td>
                </tr>
            </table>    
        </div>
        <!--Botones-->
        <div class="blocktext mgt-2 pdb-2 row">
            <button type="button" class="btn btn-primary mgl-1" disabled><a href="/gestion-perfumista/crear" disabled>Crear Perfumista</a></button>
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
                    <button type="button" class="btn btn-danger"><a href="/gestion-prefumista/#">Eliminar</a></button>
                </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection