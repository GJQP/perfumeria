@extends('layout.master')

@section('titulo','Gestion de Contratos')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <!--Seleccionar la Empresa-->
        <div class="row blocktext">
            <p class="mgt-1" for="empresas"><strong>Seleccione la Empresa a la que desee consultar sus Contratos:</strong><p>
             <div class="dropdown mgl-1">
                 <button class="btn btn-secondary dropdown-toggle" type="button" id="empresa" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                   Empresa
                 </button>
                 <div class="dropdown-menu muli" aria-labelledby="dropdownMenuButton">
                     <!--Elementos internos del dropdown-->
                     <a class="dropdown-item" onclick="">Action</a>
                     <a class="dropdown-item" onclick="">Another action</a>
                     <a class="dropdown-item" onclick="">Priv I Organics LTD</a>                               
                 </div>
             </div>
        </div>
        <div class=" blocktext mgt-2 tablaDatos">
            <table>
                <tr>
                    <th class="nombre">Nombre de la Empresa</th>
                    <th class="expiracion">Fecha de Culminacion</th>
                    <th class="accion">Acción</th>
                </tr>
                
                <!--Tr por default cuando no se pasen parametros-->
                <!--<tr class="default">
                    <td></td>
                    <td></td>
                    <td></td>
                </tr> -->
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><div id="acciones">
                            <a href="">Cancelar Contrato</a>
                        </div>
                        <div>
                            <a href="">Renovar Contrato</a>
                    </div>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
                <tr>
                    <td>Destileria Muñoz Galvez</td>
                    <td>10-10-2020</td>
                    <td><a href="">Cancelar Contrato</a>
                    </td>
                </tr>
            </table>    
        </div>
        <!--Botones-->
        <div class="blocktext mgt-2 pdb-2">
            <button type="button" class="btn btn-secondary mgl-1" disabled><a href="/gestion-contrato/crear" disabled>Crear Contrato</a></button>
        </div>
    </div>
</div>
@endsection