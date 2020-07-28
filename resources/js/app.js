/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Stepper = require('bs-stepper/dist/js/bs-stepper.min');

window.Vue = require('vue');

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

const files = require.context('./', true, /\.vue$/i)
files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

//Vue.component('filtros', require('./components/Filtros.vue').default);
//Vue.component('insert-row', require('./components/InsertRow').default);
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const aromas = new Vue({
    el: '#filtrosComp',
    data:{
        prueba:[],
        valores:[],
        generos:[
            { texto:'Femenino', value: 'femenino'},
            { texto:'Masculino', value: 'masculino'}
        ],

        intensidades:[
            { texto:'Ligero', value: 'ligero'},
            { texto:'Intermedio', value: 'intermedio'},
            { texto:'Intenso', value: 'intenso'}
        ],
        
        caracteres:[
            { texto:'Clasico', value: 'clasico'},
            { texto:'Informal', value: 'informal'},
            { texto:'Moderno', value: 'moderno'},
            { texto:'Natural', value: 'natural'},
            { texto:'Seductor', value: 'seductor'}
        ],

        aromas:[
            {texto: 'Floral', value: 'floral'},
            { texto: 'Frutal,', value: 'frutal,'},
            { texto: 'Verde', value: 'verde'},
            { texto: 'Herbal', value: 'herbal'},
            { texto: 'Cítrico', value: 'citrico,'},
            { texto: 'Herbal Aromático', value: 'herbalaro'}
            ],

        usos:[
                { texto: 'Diario', value:'diario'},
                { texto: 'Trabajo', value:'trabajo'},
                { texto: 'Ocasion Especial', value:'ocasionEsp'}
            ],
           
        aspectos:[
            { texto: 'Libertad', value:'libertad'},
            { texto: 'Independiente', value:'independietne'},
            { texto: 'Creatividad', value:'creatividad'},
            { texto: 'Diversion', value:'diversion'}
        ],
       
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
        ],
                caracSelected: null,
                caracInserted: []
    },

    methods:{
        agregarCarac:function(){
            this.inserted.push(this.caracteres[this.caractSelected]);
            this.caracteres.splice(this.caracSelected,1);
        }
    }
});