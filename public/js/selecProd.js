$(".checkbox-menu").on("change", "input[type='checkbox']", function() {
    $(this).closest("li").toggleClass("active", this.checked);
 });

 $(document).on('click', '.allow-focus', function (e) {
    e.stopPropagation();
  });

function descuento(){
   console.log('hola');
   if($("#descuento").val()){
      var descuento ='<div class="blocktext row ">'+
            '<p class="mgt-1">Fecha de finalizacion del descuento(opcional):</p>' +
            '<input type="text" class="form-control descuento pdb-1" name="fechaDesc">' +
            '<span class="input-group-addon">%</span>'+
        '</div>';
      //Insertar fecha
    document.getElementById("desc").before(descuento);
   }
};