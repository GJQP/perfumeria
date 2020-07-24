<template>
  <div class="stage tarjeta muli pdb-2">
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
                    <div class="mglp-3 row aromaPDiv" id="aromas">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Aroma Prevaleciente:</h6>
                        <select class="form-control aromaP" name="aromaP">
                            <option selected disabled value="0">--Aromas--</option>
                            <option v-for="aromas in aroma" v-bind:value="aroma.value">{{aroma.texto}}</option>
                        </select>
                    </div>
                    <!--Preferencia de Uso-->
                    <div class="mglp-2 row usoDiv" id="uso">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Preferencia de Uso:</h6>
                        <select class="form-control uso" name="uso">
                            <option selected disabled value="0">Preferencia</option>
                            <option v-for="uso in usos" v-bind:value="uso.value">{{uso.texto}}</option>
                        </select>
                    </div>
                    <!--Aspecto Personalidad-->
                    <div class="mglp-2 row aspectoPerDiv" id="aspectoPer">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Aspecto de Personalidad:</h6>
                        <select class="form-control aspectoPer" name="aspectoPer">
                            <option selected disabled value="0">--Aspecto--</option>
                            <option v-for="aspecto in aspectos" v-bind:value="aspecto.value">{{aspecto.texto}}</option>
                        </select>
                    </div>
                    <!--Familia Olfativa-->
                    <div class="mgl-1 row familiaOlfDiv" id="familiaOlf">
                        <h6 class="pdtp-1 mgr-1 nombreFiltro">Aspecto de Personalidad:</h6>
                        <select class="form-control familiaOlf" name="familiaOlf">
                            <option selected disabled value="0">--Familias--</option>
                            <option v-for="familia in familias" v-bind:value="familia.value">{{familia.texto}}</option>
                        </select>
                    </div>
                </div>
                <div class="mgr-5 mgt-1" style="text-align: right;">
                    <button type="submit" class="btn btn-primary">Aplicar</button>
                </div>
            </div>
        </div>
</template>

<script> 
    var aromas = new Vue({
        el: 'aromas',
        data:{
        aroma:[
            {texto: 'Floral', value: 'oro'},
        { texto: 'Hola', value: 'uno'}],
        }
    })

    var usos = new Vue({
        el: '#uso',
        data:{
            usos:[
                { texto: 'Diario', value:'diario'},
                { texto: 'Trabajo', value:'trabajo'},
                { texto: 'Ocasion Especial', value:'ocasionEsp'}
            ]
        }
    })

    var aspectoPer = new Vue({
        el: '#aspectoPer',
        data:{
            aspectos:[
                { texto: 'Libertad', value:'libertad'},
                { texto: 'Independiente', value:'independietne'},
                { texto: 'Creatividad', value:'creatividad'},
                { texto: 'Diversion', value:'diversion'}
            ]
        }
    })

    var familiaOlf = new Vue({
        el: '#familiaOlf',
        data:{
            familias:[
                { texto: 'Verde', value:'verde'},
                { texto: 'Cítrico', value:'citrico'},
                { texto: 'Flores', value:'flores'},
                { texto: 'Frutas', value:'frutas'},
                { texto: 'Aromáticos', value:'aromáticos'},
                { texto: 'Helechos', value:'helechos'},
                { texto: 'Chipre', value:'chipre'},
                { texto: 'Maderas', value:'maderas'},
                { texto: 'Orientales', value:'orientales'}
            ]
        }
    })
</script>