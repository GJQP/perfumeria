<template>
    <div class="container mgt-2 mgrb-1">
        <!--Filtros-->

            <!--
            <div>
                <Filtros id="app"></Filtros>
            </div>
        -->
            <div>
                <div class="stage tarjeta muli pdb-2">
                    <div class="mgl-2 pdtp-1 mgb-1">
                        <h4><u><strong>Filtros</strong></u></h4>
                    </div>
                    <div class="mgtp-1 pdb-1">
                        <!--Contenedor de los Filtros Superiores-->
                        <div class="row">
                            <!--Genero-->
                            <div class="offset-1 col-md-2">
                                <label class="pdtp-1 mgr-1">Género:</label>
                                <select class="form-control" v-model="genero">
                                    <option selected  :value="null">--Genero--</option>
                                    <option v-for="genero in generos" v-bind:value="genero.texto">{{genero.texto}}
                                    </option>
                                </select>
                            </div>
                            <!--edad-->
                            <div class="col-md-3">
                                <label class="pdtp-1 mgr-1">Edad:</label>
                                <select class="form-control"  v-model="edad">
                                    <option selected  :value="null">--Edad--</option>
                                    <option v-for="edad in edades" v-bind:value="edad.texto">{{edad.texto}}
                                    </option>
                                </select>
                            </div>
                            <!--Intensidad-->
                            <div class="col-md-3">
                                <label class="pdtp-1 mgr-1">Intensidad:</label>
                                <select class="form-control" v-model="intensidad">
                                    <option selected  :value="null">--Intensidad--</option>
                                    <option v-for="intensidad in intensidades" v-bind:value="intensidad.value">
                                        {{intensidad.texto}}
                                    </option>
                                </select>
                            </div>
                            <!--Preferencia de Uso-->
                            <div class="col-md-2">
                                <label class="pdtp-1 mgr-1">Preferencia de Uso:</label>
                                <select class="form-control" v-model="preferencia">
                                    <option selected  :value="null">--Preferencia--</option>
                                    <option v-for="uso in usos" v-bind:value="uso.texto">{{uso.texto}}</option>
                                </select>
                            </div>
                        </div>
                        <!--Contenedor de los Filtros Inferior-->
                        <div class="row mgt-1">
                            <!--Caracter-->
                            <div class="offset-1 col-md-2">
                                <label class="pdtp-1 mgr-2 nombreFiltro">
                                    Caracter:
                                    <span @click="agregar(caracterSelected,caracteres,caracter)"
                                            class="circle plus"
                                            v-if="caracteres.length > 0"
                                    ></span>
                                    <span @click="agregar(caracteres,caracterSelected,0)"
                                            class="circle minus"
                                            v-if="caracterSelected.length > 0"
                                    ></span>
                                </label>
                                <select class="form-control caracter mglp-1" v-model="caracter" v-if="caracteres.length > 0">
                                    <option selected  :value="null">--Caracter--</option>
                                    <option v-for="(val, key) in caracteres" :value="key" >{{val.texto}}</option>
                                </select>
                                <p v-for="caracter in caracterSelected">{{caracter.texto}}</p>
                            </div>
                            <!--Aspecto Personalidad-->
                            <div class="col-md-3">
                                <label class="pdtp-1 mgr-1 nombreFiltro">
                                    Aspecto de Personalidad:
                                    <span @click="agregar(aspectoSelected, aspectos, aspecto)"
                                            class="circle plus"
                                            v-if="aspectos.length > 0"
                                    ></span>
                                    <span @click="agregar(aspectos,aspectoSelected,0)"
                                            class="circle minus"
                                            v-if="aspectoSelected.length > 0"
                                    ></span>
                                </label>
                                <select class="form-control caracter" v-model="aspecto"  v-if="aspectos.length > 0">
                                    <option selected  :value="null">--Aspecto--</option>
                                    <option v-for="(val, key) in aspectos" :value="key" >{{val.texto}}</option>
                                </select>
                                <p v-for="val in aspectoSelected">{{val.texto}}</p>
                            </div>
                            <!--Familia Olfativa-->
                            <div class="col-md-3" >
                                <label class="pdtp-1 mgr-1 nombreFiltro">
                                    Familia Olfativa:
                                    <span @click="agregar(familiaSelected,familias,familia)"
                                            class="circle plus"
                                            v-if="familias.length > 0"
                                    ></span>
                                    <span
                                        @click="agregar(familias,familiaSelected,0)"
                                        class="circle minus"
                                        v-if="familiaSelected.length > 0"
                                    ></span>
                                </label>
                                <select class="form-control caracter" v-model="familia"  v-if="familias.length > 0">
                                    <option selected  :value="null">--Familias--</option>
                                    <option v-for="(val, key) in familias" :value="key" >{{val.texto}}</option>
                                </select>
                                <p v-for="val in familiaSelected">{{val.texto}}</p>
                            </div>
                            <!--Aroma Prevalenciente-->
                            <div class="col-md-3">
                                <label class="pdtp-1 mgr-1 nombreFiltro">
                                    Aroma Prevaleciente:
                                    <span @click="agregar(aromaSelected,aromas,aroma)"
                                          class="circle plus"
                                          v-if="aromas.length > 0"
                                    ></span>
                                    <span
                                        @click="agregar(aromas,aromaSelected,0)"
                                        class="circle minus"
                                        v-if="aromaSelected.length > 0"
                                    ></span>
                                </label>
                                <select class="form-control caracter" v-model="aroma"  v-if="aromas.length > 0">
                                    <option selected  :value="null">--Aromas--</option>
                                    <option v-for="(val, key) in aromas" :value="key" >{{val.texto}}</option>
                                </select>
                                <p v-for="val in aromaSelected">{{val.texto}}</p>
                            </div>
                        </div>
                        <div class="offset-10 mgt-1 row" style="text-align: right;">
                            <button type="submit" class="btn btn-primary">Buscar</button>

                            <button class="btn btn-primary" type="button" disabled>
                                <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                                <span class="sr-only">Loading...</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        <!--Rueda con la informacion-->
        <div class="stage tarjeta muli mgt-1 pdb-2">
            <div class=" mgl-2 row">
                <!--Lado izquierdo para la Rueda-->
                <div class="rueda">
                    <rueda/>
                </div>
                <!--Lado derecho para mostrar perfumes-->
                <div class="perfumes">
                    <div>
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
</template>

<script>
    export default {
        name: "Recomendador",
        data() {
            return {
                generos: [
                    {texto: 'Femenino'},
                    {texto: 'Masculino'},
                    {texto: 'Unisex'},
                ],

                edades: [
                    {texto: 'Atemporal'},
                    {texto: 'Adulto'},
                    {texto: 'Joven'},
                ],

                intensidades: [
                    {texto: 'Ligero', value: ['EdC', 'EdS']},
                    {texto: 'Intermedio', value: ['EdT'] },
                    {texto: 'Intenso', value: ['P', 'EdP']},
                ],

                caracteres: [
                    {texto: 'Clasico'},
                    {texto: 'Informal'},
                    {texto: 'Moderno'},
                    {texto: 'Natural'},
                    {texto: 'Seductor'},
                ],

                aromas: [
                    {texto: 'Floral'},
                    {texto: 'Frutal,'},
                    {texto: 'Verde'},
                    {texto: 'Herbal'},
                    {texto: 'Cítrico'},
                    {texto: 'Herbal Aromático'},
                ],

                usos: [
                    {texto: 'Diario'},
                    {texto: 'Trabajo'},
                    {texto: 'Ocasion Especial'},
                ],

                aspectos: [
                    {texto: 'Libertad'},
                    {texto: 'Independiente'},
                    {texto: 'Creatividad'},
                    {texto: 'Diversion'},
                ],

                familias: [
                    {texto: 'Verde'},
                    {texto: 'Cítrico'},
                    {texto: 'Flores'},
                    {texto: 'Frutas'},
                    {texto: 'Aromáticos'},
                    {texto: 'Helechos'},
                    {texto: 'Chipre'},
                    {texto: 'Maderas'},
                    {texto: 'Orientales'},
                ],

                genero: null,
                edad: null,
                preferencia: null,
                intensidad: null,
                caracter: null,
                familia: null,
                aroma: null,
                aspecto: null,

                caracterSelected: [],
                familiaSelected: [],
                aromaSelected: [],
                aspectoSelected: [],


                perfumes: [
                    "Acqua di Giò de Giorgio Armani",
                    "Boss Bottled de Hugo Boss",
                    "Romance de Ralph Lauren",
                    "Joseph Abboud de Joseph Abboud",
                    "Pistachio Brûlée de Urban Outfitters",
                    "Paris, She Met Him In Secret de Fictions Perfume",
                    "Exotic Musk",
                    "Let you Love Me de Blumarine",
                    "Gris Charnel de BDK Parfums",
                ],

            }
        },
        methods: {
            agregar(inserted, options, select){
                if (select !== null && select + 1 <= options.length ) {
                    //debugger
                    inserted.push(options[select]);
                    options.splice(select, 1);
                    select = null
                }
            },
            filtrar(){
                axios.post('/',{
                    genero: this.genero,
                    edad: this.edad,

                })
            },

            buscar(){



                let data = {};

                if(this.genero)
                    data['genero'] = this.genero;



                console.log(data);




            },

            generarSegementos(){

            }

            /*
        --UN PERFUME QUE TENGA POR LO MENOS
        --* 1 EL GENERO
        --* 2 EDAD
        --* 3 TENGA LA PREFERENCIA
        --* 4 TENGA LA INTENSIDAD
        --* 5 TENGA ALGUN CARACTER (PALABRAS CLAVES)
        --* 6 TENGA ALGUNA FAMILIA
        --* 7 TENGA ALGUN AROMA
        --* 8 TENGA ALGUN ASPECTO
 */
        }
    }
</script>

<style scoped>

</style>
