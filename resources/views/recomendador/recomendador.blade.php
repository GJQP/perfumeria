@extends('layout.master')

@section('scripts')
<script src="{{ asset('js/vueRecomendador.js') }}"></script>
@endsection

@section('titulo','Recomendador de Perfumes')

@section('contenido')  
<div class="container mgt-2 mgrb-1">
    <!--Filtros-->
    <form>
    <div class="stage tarjeta muli pdb-2">
        <div class="mgl-2 pdtp-1 mgb-1">
            <h4><u><strong>Filtros</strong></u></h4>
        </div>
        <!--Contenedor de los Filtros Superiores-->
        <div class="mgtp-1 pdb-2">
            <div class="row">
                <!--Genero-->
                <div class="mgl-5 row generoDiv">
                    <h6 class="pdtp-1 mgr-1 nombreFiltro">Género</h6>
                    <select class="form-control" id="genero" name="genero">
                        <option selected disabled>--Genero--</option>
                        <option value="masculino">Masculino></option>
                        <option value="femenino">Femenino</option>
                    </select>
                </div>
                <!--Rango de edad-->
                <div class="row rangoDiv">
                    <h6 class="pdtp-1 mgr-1 nombreFiltro">Rango de Edad</h6>
                    <input type="text" class="form-control rango mgr-1" placeholder="Min" name="rgo-min">
                    <div class="separador mgt-1div"></div>
                    <input type="text" class="form-control rango mglp-1" placeholder="Max" name="rgo-max">
                </div>
                <!--Intensidad-->
                <div class="row intesidadDiv mgl-1">
                    <h6 class="pdtp-1 mgr-2 nombreFiltro">Intensidad</h6>
                    <select class="form-control intensidad mglp-1" id="intensidad" name="intensidad">
                        <option selected disabled--Intensidad--option></option>
                        <option value="ligeroLigerooption"></option>
                        <option value="intermedioIntermediooption"></option>
                        <option value="intensoIntensooption"></option>
                    </select>
                </div>
                <!--Caracter-->
                <div class="row caracterDiv mglp-3">
                    <h6 class="pdtp-1 mgr-2 nombreFiltro">Caracterh6></h6>
                    <select class="form-control caracter mglp-1" id="caracter" name="caracter">
                        <option selected disabled--Caracter--option></option>
                        <option value="informalClásicooption"></option>
                        <option value="naturalInformaloption"></option>
                        <option value="clasicoModernooption"></option>
                        <option value="seductorNaturaloption"></option>
                        <option value="modernoSeductoroption"></option>
                    </select>
                </div>
            </div>
                            <!--Contenedor de los Filtros Inferiores-->
                                <div class="mgt-1">
                                <div class="row">
                                <!--Aroma Prevalenciente-->
                                    <div class="mgl-5 row aromaPDiv">
                                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Aroma Prevaleciente</h6>
                                        <div class="aromaP" id="aromaPrev">
                                            <v-select options="aromas" class="form-control" id="aromaP" name="aromaP">
                                        </div>
                                    </div>
                    <!---->
                    <div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <!--Rueda con la informacion-->
    <div class=stage tarjeta muli mgt-1 pdb-2>
        Hola
    </div>
    </div>
@endsection