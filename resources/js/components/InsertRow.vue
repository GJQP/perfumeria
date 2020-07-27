<template>
    <div>
        <div class="form-inline" v-if="options.length > 0">
            <label>Seleccione el producto:</label>
            <select class="form-control" v-model="selected">
                <option v-for="(val, key) in options" :value="key" >{{val.presentacion}}</option>
            </select>
            <button class="btn btn-primary" @click="agregarFila">Agregar producto</button>
        </div>



        <table id="tabla" class="tablaDatos mgt-2" v-if="inserted.length > 0">
            <tr>
                <th id="">Producto</th>
                <th id="porcentaje">Cantidad</th>
                <th id="eliminar">Acción</th>
            </tr>
            <tr v-for="(val, key) in inserted">
                <td>{{val.presentacion}}</td>
                <td>
                    <input type="number" v-model="val.cantidad">
                </td>
                <td><button class="btn btn-danger" @click="eliminarFila(key)">Eliminar</button></td>
            </tr>
        </table>
        <button class="btn btn-primary" v-if="inserted.length > 0" @click="guardar">Siguiente</button>
        <p v-else> No hay productos seleccionados</p>
    </div>
</template>

<script>
    export default {
        name: "InsertRow",
        props: ['opciones'],
        data() {
            return {
                options: JSON.parse(this.opciones),
                selected: null,
                inserted: []
            }
        },
        methods: {
            agregarFila () {
                if (this.selected !== null) {
                    this.inserted.push(this.options[this.selected]);
                    this.options.splice(this.selected,1);
                }
                console.log(this.inserted)
            },
            eliminarFila (index) {
                this.options.push(this.inserted[index]);
                this.inserted.splice(index,1);
            },
            guardar() {
                //axios.post()
                if (this.inserted.filter( item => !item.hasOwnProperty('cantidad') ).length === 0)
                    stepper.next();
            }
        }/*,
        mounted(){
            console.log(this.opciones);
        }*/
    }
</script>

<style scoped>

</style>
