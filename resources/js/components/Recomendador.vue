<template>
    <div class="container mgt-2 mgrb-1">
        <!--Filtros-->

            <!--
            <div>
                <Filtros id="app"></Filtros>
            </div>
        -->
            <div v-if="filtro < 9">
                <div class="stage tarjeta muli pdb-2">
                    <div class="mgl-2 pdtp-1 mgb-1">
                        <h4><u><strong>Filtros</strong></u></h4>
                    </div>
                    <div class="mgtp-1 pdb-1">
                        <!--Contenedor de los Filtros Superiores-->
                        <div class="row">
                            <!--Genero-->
                            <div class="offset-1 col-md-3" v-if="filtro === 1">
                                <label class="pdtp-1 mgr-1">Género:</label>
                                <select class="form-control" v-model="genero">
                                    <option selected :value="null">--Genero--</option>
                                    <option v-for="genero in generos" v-bind:value="genero.value">{{genero.texto}}
                                    </option>
                                </select>
                            </div>
                            <!--edad-->
                            <div class="offset-1 col-md-3" v-if="filtro === 2">
                                <label class="pdtp-1 mgr-1">Edad:</label>
                                <select class="form-control"  v-model="edad">
                                    <option selected  :value="null">--Edad--</option>
                                    <option v-for="edad in edades" v-bind:value="edad.value">{{edad.texto}}
                                    </option>
                                </select>
                            </div>
                            <!--Intensidad-->
                            <div class="offset-1 col-md-3" v-if="filtro === 3">
                                <label class="pdtp-1 mgr-1">Intensidad:</label>
                                <select class="form-control" v-model="intensidad">
                                    <option selected  :value="null">--Intensidad--</option>
                                    <option v-for="intensidad in intensidades" v-bind:value="intensidad.value">
                                        {{intensidad.texto}}
                                    </option>
                                </select>
                            </div>
                            <!--Preferencia de Uso-->
                            <div class="offset-1 col-md-3" v-if="filtro === 7">
                                <label class="pdtp-1 mgr-1">Preferencia de Uso:</label>
                                <select class="form-control" v-model="preferencia">
                                    <option selected  :value="null">--Preferencia--</option>
                                    <option v-for="uso in usos" v-bind:value="uso.value">{{uso.texto}}</option>
                                </select>
                            </div>
                        </div>
                        <!--Contenedor de los Filtros Inferior-->
                        <div class="row mgt-1">
                            <!--Caracter-->
                            <div class="offset-1 col-md-3" v-if="filtro === 4">
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
                            <div class="offset-1 col-md-3" v-if="filtro === 8">
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
                            <div class="offset-1 col-md-3" v-if="filtro === 5">
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
                            <div class="offset-1 col-md-3" v-if="filtro === 6">
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
                        <div class="offset-10 mgt-1 row" style="text-align: right;" v-if="filtro < 9">
                            <button type="submit" class="btn btn-primary" @click="buscar">Buscar</button>

                            <!--<button class="btn btn-primary" type="button" disabled>
                                <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                                <span class="sr-only">Loading...</span>
                            </button>-->
                        </div>
                    </div>
                </div>
            </div>
        <!--Rueda con la informacion-->
        <div class="stage tarjeta muli mgt-1 pdb-2" v-if="perfumes.length > 0">
            <div class="mgl-2 pdtp-1 mgb-1">
                <h4><u><strong>Resultados</strong></u></h4>
            </div>
            <div class=" mgl-2 row">
                <!--Lado izquierdo para la Rueda-->
                <div class="col-md-5" v-show="segmentos.length > 0">
                    <rueda :segments="segmentos" :cb="getNombre"/>
                </div>
                <!--Lado derecho para mostrar perfumes-->
                <div class="perfumes" v-if="perfumes.length > 0">
                    <div>
                        <h4 class="mgt-1 blocktext"><u>Perfumes</u></h4>
                    </div>
                    <div>
                        <table class="col-md-11">
                            <thead>
                            <tr>
                                <th>
                                    N°
                                </th>
                                <th>
                                    Nombre del perfume
                                </th>
                                <th v-if="perfumes[0].Genero !== undefined">
                                    Género
                                </th>
                                <th v-if="perfumes[0].Edad !== undefined">
                                    Edad
                                </th>
                                <th v-if="perfumes[0].Intensidad !== undefined">
                                    Intensidad
                                </th>
                                <th v-if="perfumes[0].Caracter !== undefined">
                                    Caracter
                                </th>
                                <th v-if="perfumes[0].Familia !== undefined">
                                    Familia Olfativa
                                </th>
                                <th v-if="perfumes[0].Esencia !== undefined">
                                    Aroma
                                </th>
                                <th v-if="perfumes[0].Preferencia !== undefined">
                                    Preferencia de uso
                                </th>
                                <th v-if="perfumes[0].Aspecto !== undefined">
                                    Personalidad
                                </th>


                            </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(perfume, key) in perfumes">
                                    <td>{{key + 1}}</td>
                                    <td>{{perfume.nombre}}</td>
                                    <td v-if="perfume.Genero !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Genero"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>
                                    <td v-if="perfume.Edad !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Edad"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>
                                    <td v-if="perfume.Intensidad !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Intensidad"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>
                                    <td v-if="perfume.Caracter !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Caracter"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>
                                    <td v-if="perfume.Familia !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Familia"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>
                                    <td v-if="perfume.Esencia !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Esencia"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>
                                    <td v-if="perfume.Preferencia !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Preferencia"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>
                                    <td v-if="perfume.Aspecto !== undefined">
                                        <span class="mi mi-check" v-if="perfume.Aspecto"></span>
                                        <span class="mi mi-close" v-else></span>
                                    </td>


                                </tr>
                            </tbody>
                        </table>
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
                    {texto: 'Femenino', value: 'F'},
                    {texto: 'Masculino', value: 'M'},
                    {texto: 'Unisex', value: 'U'},
                ],

                edades: [
                    {texto: 'Atemporal', value: 'ATEMPORAL'},
                    {texto: 'Adulto', value: 'ADULTO'},
                    {texto: 'Joven', value: 'JOVEN'},
                ],

                intensidades: [
                    {texto: 'Ligero', value: ["'EdC'", "'EdS'"].toString()},
                    {texto: 'Intermedio', value: ["'EdT'"].toString() },
                    {texto: 'Intenso', value: ["'P'", "'EdP'"].toString()},
                ],

                caracteres: [
                    {texto: 'Clasico', value: "'clasico'" },
                    {texto: 'Informal', value: "'informal'" },
                    {texto: 'Moderno', value: "'moderno'" },
                    {texto: 'Natural', value: "'natural'" },
                    {texto: 'Seductor', value: "'seductor'" },
                ],

                aromas: [
                    {texto: "Frutal",value: "'frutal'"},
                    {texto: "Floral",value: "'floral'"},
                    {texto: "Verde",value: "'verde'"},
                    {texto: "Herbal",value: "'herbal'"},
                    {texto: "Cítrico",value: "'citrico'"},
                    {texto: "Herbal",value: "'herbal'"},
                    {texto: "Café",value: "'cafe'"},
                    {texto: "Chocolate",value: "'chocolate'"},
                    {texto: "Vainilla",value: "'vainilla'"},
                    {texto: "Especias",value: "'especias'"},
                    {texto: "Tabaco",value: "'tabaco'"},
                ],

                usos: [
                    {texto: 'Diario', value:"diario"},
                    {texto: 'Trabajo', value:"trabajo"},
                    {texto: 'Ocasion Especial', value:"ocasion especial"},
                ],

                aspectos: [
                    {texto: 'Libertad', value:"'libertad'"},
                    {texto: 'Independiente', value:"'indepencia'"},
                    {texto: 'Creatividad', value:"'creatividad'"},
                    {texto: 'Diversion', value:"'diversion'"},
                    {texto: 'Deshinibida', value: "'deshinibida'"},
                    {texto: 'Tranquilidad', value: "'tranquilidad'"},
                    {texto: 'Sensualidad', value: "'sensualidad'"},
                    {texto: 'Alegría', value: "'alegría'"},
                    {texto: 'Lucidez', value: "'lucidez'"},
                    {texto: 'Calidez', value: "'calidez'"},
                    {texto: 'Optimismo', value: "'optimismo'"},
                ],

                familias: [
                    {texto: 'Verde', value:"'Verde'"},
                    {texto: 'Cítrico', value:"'Citrico'"},
                    {texto: 'Flores', value:"'Flores'"},
                    {texto: 'Frutas', value:"'Frutas'"},
                    {texto: 'Aromáticos', value:"'Aromáticos'"},
                    {texto: 'Helechos', value:"'Helechos'"},
                    {texto: 'Chipre', value:"'Chipre'"},
                    {texto: 'Maderas', value:"'Maderas'"},
                    {texto: 'Orientales', value:"'Orientales'"},
                    {texto: 'Otros', value:"'Otros'"},
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


                perfumes: [],
                segmentos: [],

                filtro: 1

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



                let datos = {};

                if(this.genero) {
                    this.filtro = 2;
                    datos['genero'] = this.genero;
                }
                if(this.edad) {
                    this.filtro = 3;
                    datos['edad'] = this.edad;
                }
                if(this.intensidad){
                    this.filtro = 4;
                    datos['intensidad'] = this.intensidad
                }

                if(this.caracterSelected.length > 0){
                    this.filtro = 5;
                    datos['caracteres'] = this.caracterSelected.map(item => item.value).toString()

                }

                if(this.familiaSelected.length > 0){
                    this.filtro = 6;
                    datos['familia']=this.familiaSelected.map(item => item.value).toString()
                }

                if(this.aromaSelected.length > 0){
                    this.filtro = 7;
                    datos['aromas']= this.aromaSelected.map(item => item.value).toString()
                }

                if(this.preferencia){
                    this.filtro = 8;
                    datos['preferencia']= this.preferencia
                }

                if(this.aspectoSelected.length > 0){
                    this.filtro = 9;
                    datos['aspecto']=this.aspectoSelected.map(item => item.value).toString()
                }




                console.log(datos);

                //console.log(this.aromaSelected);

                if (Object.keys(datos).length !== 0){
                    axios.post('/recomendar',datos).then( ({data}) => {
                        console.log("RESULTADOS",data);

                        this.perfumes = data
                        this.segmentos = this.generarSegementos(data);
                        //debugger;
                    });
                }

            },

            generarSegementos(data){
                let i = 0;
                let par = ((data.length-1) % 2);
                return data.map( (item,index) => {

                    let opciones = [
                            {
                                textFillStyle: '#fff',
                                fillStyle: '#000',
                            },
                            {
                                textFillStyle: '#000',
                                fillStyle: '#fadede',
                            },
                            {
                                textFillStyle: '#fff',
                                fillStyle: '#4ca4a0',
                            }
                    ];

                    if (par)
                        return {...opciones[(i++) % 2], text: `Perfume ${index + 1}`}
                    else
                        return {...opciones[(i++) % 3], text: `Perfume ${index + 1}`}






                })

            },
            getNombre(index){
                return this.perfumes[index].nombre;
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
