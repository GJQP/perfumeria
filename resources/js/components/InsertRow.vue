<template>
    <div>
        <div class="form-inline" v-if="optionsIng.length > 0">
            <label>Seleccione el producto:</label>
            <select class="form-control" v-model="selectedIng">
                <option v-for="(val, key) in optionsIng" :value="key" >{{val.presentacion}}</option>
            </select>
            <button class="btn btn-primary" @click="agregarFila(true)">Agregar producto</button>
        </div>

        <table id="tabla" class="tablaDatos mgt-2" v-if="insertedIng.length > 0">
            <tr>
                <th>Producto</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Acción</th>
            </tr>
            <tr v-for="(val, key) in insertedIng">
                <td>{{val.presentacion}}</td>
                <td>$ {{val.precio}}</td>
                <td>
                    <input type="number" v-model="val.cantidad" min="0">
                </td>
                <td><button class="btn btn-danger" @click="eliminarFila(key,true)">Eliminar</button></td>
            </tr>
        </table>

        <div class="form-inline" v-if="optionsOtrIng.length > 0">
            <label>Seleccione el producto:</label>
            <select class="form-control" v-model="selectedOtrIng">
                <option v-for="(val, key) in optionsOtrIng" :value="key" >{{val.presentacion}}</option>
            </select>
            <button class="btn btn-primary" @click="agregarFila(false)">Agregar producto</button>
        </div>

        <table id="tabla2" class="tablaDatos mgt-2" v-if="insertedOtrIng.length > 0">
            <tr>
                <th>Producto</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Acción</th>
            </tr>
            <tr v-for="(val, key) in insertedOtrIng">
                <td>{{val.presentacion}}</td>
                <td>$ {{val.precio}}</td>
                <td>
                    <input type="number" v-model="val.cantidad" min="0">
                </td>
                <td><button class="btn btn-danger" @click="eliminarFila(key, false)">Eliminar</button></td>
            </tr>
        </table>

        <button class="btn btn-primary offset-2 mt-4" v-if="insertedIng.length > 0 || insertedOtrIng.length > 0" @click="guardar">Siguiente</button>
        <p v-else> No hay productos seleccionados</p>
    </div>
</template>

<script>
    export default {
        name: "InsertRow",
        props: ['opcionesIng','opcionesOtrIng','cantEnv','cantPag'],
        data() {
            return {
                optionsIng: JSON.parse(this.opcionesIng),
                optionsOtrIng: JSON.parse(this.opcionesOtrIng),
                selectedIng: null,
                selectedOtrIng: null,
                insertedIng: [],
                insertedOtrIng: [],
            }
        },
        methods: {
            agregarFila (esIng) {
                if (esIng && this.selectedIng !== null) {
                    this.insertedIng.push(this.optionsIng[this.selectedIng]);
                    this.optionsIng.splice(this.selectedIng,1);
                }
                else if (!esIng && this.selectedOtrIng !== null) {
                    this.insertedOtrIng.push(this.optionsOtrIng[this.selectedOtrIng]);
                    this.optionsOtrIng.splice(this.selectedOtrIng,1);
                }
                //console.log(this.inserted)
            },
            eliminarFila (index, esIng) {
                if (esIng){
                    this.optionsIng.push(this.insertedIng[index]);
                    this.insertedIng.splice(index,1);
                }
                else{
                    this.optionsOtrIng.push(this.insertedOtrIng[index]);
                    this.insertedOtrIng.splice(index,1);
                }

            },
            guardar() {
                //axios.post()
                if ( this.insertedIng.filter( item => !item.hasOwnProperty('cantidad') ).length === 0
                    &&
                    this.insertedOtrIng.filter( item => !item.hasOwnProperty('cantidad') ).length === 0
                ){
                    let data = {ingredientes: this.insertedIng, otros_ingredientes: this.insertedOtrIng};
                    if (id_ped)
                        data['id_ped'] = id_ped;
                    axios.post(`/pedido/${id_cto}/detalles`, data).then( ({data}) => {

                        id_ped = data.id_ped

                        totalPago = 0;
                        this.insertedIng.map(item => { totalPago += (item.cantidad * item.precio)  });
                        this.insertedOtrIng.map(item => { totalPago += (item.cantidad * item.precio)  });
                        document.getElementById('total').innerHTML ="$ " + totalPago.toFixed(2);
                        if (this.cantEnv == 0)
                            stepper.next();
                        else{
                            guardarOpcionEnvio(false);

                            //console.log(nuevoPrecio);
                            if (this.cantPag == 0){
                                stepper.to(3);
                            }
                            else {
                                guardarPago(false);
                                stepper.to(4);
                            }

                        }

                    })

                }
                else
                    alert('Debe ingresar cantidad validas');


            }
        }/*,
        mounted(){
            console.log(this.opciones);
        }*/
    }
</script>

<style scoped>

</style>
