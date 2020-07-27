@extends('layout.master')

@section('scripts')
<script src="{{ asset('js/rueda.js') }}"></script>
@endsection

@section('titulo','Recomendador de Perfumes')

@section('contenido')  
<div class="container mgt-2 mgrb-1">
    <!--Filtros-->
    <form>
        <!--
        <div>
            <Filtros id="app"></Filtros>
        </div>
    -->
<div id="filtrosComp">
  <div class="stage tarjeta muli pdb-2" >
            <div class="mgl-2 pdtp-1 mgb-1">
                <h4><u><strong>Filtros</strong></u></h4>
            </div>
            <div class="mgtp-1 pdb-1">
                <!--Contenedor de los Filtros Superiores-->
                <div class="row">
                    <!--Genero-->
                    <div class="mglp-3 row generoDiv">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Género:</h6>
                        <select class="form-control" id="genero" name="genero">
                            <option selected disabled>--Genero--</option>
                            <option v-for="genero in generos" v-bind:value="genero.value">@{{genero.texto}}</option>
                        </select>
                    </div>
                    <!--Rango de edad-->
                    <div class="row rangoDiv">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Rango de Edad:</h6>
                        <input type="text" class="form-control rango mgr-1" placeholder="Min" name="rgo-min">
                        <div class="separador mgt-1"></div>
                        <input type="text" class="form-control rango mglp-1" placeholder="Max" name="rgo-max">
                    </div>
                    <!--Intensidad-->
                    <div class="row intesidadDiv mgl-1">
                        <h6 class="pdtp-1 mgr-2 nombreFiltro">Intensidad:</h6>
                        <select class="form-control intensidad mglp-1" id="intensidad" name="intensidad">
                            <option selected disabled>--Intensidad--</option>
                            <option v-for="intensidad in intensidades" v-bind:value="intensidad.value">@{{intensidad.texto}}</option>
                        </select>
                    </div>
                    <!--Caracter-->
                    <div class="row caracterDiv mglp-3">
                        <h6 class="pdtp-1 mgr-2 nombreFiltro">Caracter:</h6>
                        <div class="caracterSubDiv" id="">
                                <div class="row agregar" id="contenedorCarac">
                                    <select class="form-control caracter mglp-1" id="caracter" name="caracter">
                                        <option selected disabled>--Caracter--</option>
                                        <option v-for="caracter in caracteres" v-bind:value="caracter.value">@{{caracter.texto}}</option>
                                    </select>
                                    <button v-on:click="agregar" id="agregar" class="circle plus"></button>
                                    <button class="circle minus"></button>
                                </div>
                        </div>
                    </div>
                </div>
                <!--Contenedor de los Filtros Inferior-->
                <div class="row mgt-1">
                    <!--Aroma Prevalenciente-->
                    <div class="mglp-3 row aromaPDiv">
                        <h6 class="pdtp-1 cuadrar mgr-1 nombreFiltro">Aroma Prevaleciente:</h6>
                        <select class="form-control aromaP" name="aromaP">
                            <option selected disabled value="0">--Aromas--</option>
                            <option v-for="aroma in aromas" v-bind:value="aroma.value">@{{aroma.texto}}</option>
                        </select>
                        <button class="circle plus"></button>
                        <button class="circle minus"></button>
                    </div>
                    <!--Preferencia de Uso-->
                    <div class="mglp-2 row usoDiv" id="uso">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Preferencia de Uso:</h6>
                        <select class="form-control uso" name="uso">
                            <option selected disabled value="0">Preferencia</option>
                            <option v-for="uso in usos" v-bind:value="uso.value">@{{uso.texto}}</option>
                        </select>
                    </div>
                    <!--Aspecto Personalidad-->
                    <div class="mglp-2 row aspectoPerDiv" id="aspectoPer">
                        <h6 class="pdtp-1 cuadrar mgr-1 nombreFiltro">Aspecto de Personalidad:</h6>
                        <select class="form-control aspectoPer" name="aspectoPer">
                            <option selected disabled value="0">--Aspecto--</option>
                            <option v-for="aspecto in aspectos" v-bind:value="aspecto.value">@{{aspecto.texto}}</option>
                        </select>
                        <button class="circle plus"></button>
                        <button class="circle minus"></button>
                    </div>
                    <!--Familia Olfativa-->
                    <div class="mgl-1 row familiaOlfDiv" id="familiaOlf">
                        <h6 class="pdtp-1 cuadrar mgr-1 nombreFiltro">Aspecto de Personalidad:</h6>
                        <select class="form-control familiaOlf" name="familiaOlf">
                            <option selected disabled value="0">--Familias--</option>
                            <option v-for="familia in familias" v-bind:value="familia.value">@{{familia.texto}}</option>
                        </select>
                        <button class="circle plus"></button>
                        <button class="circle minus"></button>
                    </div>
                </div>
                <div class="mgr-5 mgt-1" style="text-align: right;">
                    <button type="submit" class="btn btn-primary">Aplicar</button>
                </div>
            </div>
        </div>
</div>
    </form>
    <!--Rueda con la informacion-->
    <div class="stage tarjeta muli mgt-1 pdb-2">
        <div class=" mgl-2 row">
            <!--Lado izquierdo para la Rueda-->
            <div class="rueda">
                    
            </div>
            <!--Lado derecho para mostrar perfumes-->
            <div class="perfumes">
                <div>
                    <img class="blocktext" src="" alt="#">
                    <h4 class="mgt-1 blocktext"><u>Nombre del Perfume</u></h4>
                </div>
                <div>
                    <div>
                        <h5 class="blocktext">Distribuido por:</h5>
                        <h5 class="blocktext">Creado por:</h5>
                        <a href="#" class="mgt-1 ficha blocktext"><u>Ficha del Perfume</u></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection