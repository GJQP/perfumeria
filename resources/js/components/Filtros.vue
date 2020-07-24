<template>
  <div class="stage tarjeta muli pdb-2">
            <div class="mgl-2 pdtp-1 mgb-1">
                <h4><u><strong>Filtros</strong></u></h4>
            </div>
            <div class="mgtp-1 pdb-2">
                <!--Contenedor de los Filtros Superiores-->
                <div class="row">
                    <!--Genero-->
                    <div class="mgl-5 row generoDiv">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Género:</h6>
                        <select class="form-control" id="genero" name="genero">
                            <option selected disabled>--Genero--</option>
                            <option value="masculino">Masculino></option>
                            <option value="femenino">Femenino</option>
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
                            <option value="ligero">Ligero</option>
                            <option value="intermedio">Intermedio</option>
                            <option value="intenso">Intenso</option>
                        </select>
                    </div>
                    <!--Caracter-->
                    <div class="row caracterDiv mglp-3">
                        <h6 class="pdtp-1 mgr-2 nombreFiltro">Caracter:</h6>
                        <select class="form-control caracter mglp-1" id="caracter" name="caracter">
                            <option selected disabled>--Caracter--</option>
                            <option value="clasico">Clásico</option>
                            <option value="informal">Informal</option>
                            <option value="moderno">Moderno></option>
                            <option value="natural">Natural></option>
                            <option value="seductor">Seductor</option>
                        </select>
                    </div>
                </div>
                <!--Contenedor de los Filtros Inferior-->
                <div class="row mgt-1">
                    <!--Aroma Prevalenciente-->
                    <div class="mgl-5 row aromaPDiv">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Aroma Prevaleciente:</h6>
                        
                    </div>
                </div>
            </div>
        </div>
</template>

<script>
    export default {
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>