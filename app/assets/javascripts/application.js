// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

//É necesario que se marque un subformato antes de selecionar un formato.
//$('#tabla').delegate('input','click',function(){
//   if (this.id == 'selecionFormato'){
//       var formulario = $(this).parent().parent().children().children();
//       var form = formulario[0];
//       var checks = [];
//
//       //Dos atributos do formulario, recóllense os checkbox
//       for (i=0;i<form.length;i++){
//        if (form[i].type == 'checkbox'){
//            checks.push(form[i]);
//        }
//       }
//
//       //Compróbase que algún deles esté marcado
//       var isChecked = false;
//
//       for(i=0; i<checks.length; i++){
//           if(checks[i].checked == true){
//               isChecked = true;
//               break;
//           }
//       }
//
//       //Se ningún está marcado, amósase un aviso
//       if(isChecked == false){
//           alert("Debe selecionar un subformato!");
//           return false;
//       }
//   }
//});

//Activar a sombra do elemento, e ocultar a dos demáis
$('#datos').delegate('input[type=text]', 'click', function(){
    $(this).css('box-shadow', '0px 1px 1px rgba(0, 0, 0, 0.075) inset, 0px 0px 8px rgba(82, 168, 236, 0.6)');
    otrosInput = document.getElementsByTagName('input');
    otrosTextarea = document.getElementsByTagName('textarea');
    for(i=0;i<otrosInput.length;i++){
        if ($(this).attr('id') != otrosInput[i].id){
            otrosInput[i].style.boxShadow = 'none';
        }
    }
    for(i=0;i<otrosTextarea.length;i++){
        otrosTextarea[i].style.boxShadow = 'none';
    }
})

//Activar a sombra do elemento, e ocultar a dos demáis
$('#datos').delegate('textarea', 'click', function(){
    $(this).css('box-shadow', '0px 1px 1px rgba(0, 0, 0, 0.075) inset, 0px 0px 8px rgba(82, 168, 236, 0.6)');
    otrosTextarea = document.getElementsByTagName('textarea');
    otrosInput = document.getElementsByTagName('input');
    for(i=0;i<otrosTextarea.length;i++){
        if ($(this).attr('id') != otrosTextarea[i].id){
            otrosTextarea[i].style.boxShadow = 'none';
        }
    }
    for(i=0;i<otrosInput.length;i++){
        if ($(this).attr('id') != otrosInput[i].id && otrosInput[i].getAttribute('type') == 'text'){
            otrosInput[i].style.boxShadow = 'none';
        }
    }
})

//Ocultar notificacións pasados 5 segundos.
$('#notificacion').delay(5000).fadeOut(1000);

//Amosar ou ocultar a galería cando se solicite
$('#datosConGaleria').delegate('p', 'click', function(){
    if ($(this).parent().children('#galeria').css('display') == 'none'){
        $(this).parent().children('#galeria').show();
        //Ocultamos o selector de cores ó amosar a galería.
        $('#selectorColor').hide();
    }else{
        $(this).parent().children('#galeria').hide();
        //Amosamos o selector de cores.
        $('#selectorColor').show();
    }
});
   
//Recoller a ruta da imaxe e introducila no text field (pathContido)
$('#galeria').delegate('img', 'click', function(){
    $(this).parent().parent().children('#pathContido').val(this.src);
    $('#galeria').hide();
    $('#selectorColor').show();
    //Amosar a configuración das propiedades da imaxe
    $('#propiedades').show();
    $('#background_position_label').show();
    $('#background_position').show();
    $('#background_repeat_label').show();
    $('#background_repeat').show();
    $('#background_size_label').show();
    $('#background_size').show();
});

//Recoller a ruta do vídeo e introducila no text field (pathContido)
$('#galeria').delegate('video', 'click', function(){
    $(this).parent().parent().children('#pathContido').val(this.src);
    $('#galeria').hide();
    $('#selectorColor').show();
});

//Reproducir automáticamente un vídeo da galería ó pasar por encima del
$('#galeria').delegate('video', 'mouseenter', function(){
    this.play();
});

//Parar a reprodución do vídeo da galería ó saír de encima del
$('#galeria').delegate('video', 'mouseleave', function(){
    this.pause();
});

//Dependendo dos valores do select, necesítanse text-fields a maiores
$('#background_position').change(function(){
    if ($(this).val() == '%x %y' || $(this).val() == 'Posicion X Posicion Y'){
        $('#background_position_x').show();
        $('#background_position_y').show();
    }else{
        $('#background_position_x').hide();
        $('#background_position_y').hide();
    }
})

//Dependendo dos valores do select, necesítanse text-fields a maiores
$('#background_size').change(function(){
    if ($(this).val() == 'X pixels Y pixels' || $(this).val() == '%x %y'){
        $('#background_size_x').show();
        $('#background_size_y').show();
        $('#background_size_val').hide();
    }else if($(this).val() == 'Pixels' || $(this).val() == 'Porcentaxe'){
        $('#background_size_val').show();
        $('#background_size_x').hide();
        $('#background_size_y').hide();
    }else{
        $('#background_size_x').hide();
        $('#background_size_y').hide();
        $('#background_size_val').hide();
    }
})


//Amosar celdas no caso de que teñan un valor que sexa numérico (o placeholder é un valor), tamén amosar as etiquetas
if ($('#background_position_x').val() != null && $.isNumeric($('#background_position_x').val()) || $('#background_position_y').val() != null && $.isNumeric($('#background_position_x').val())){
    $('#propiedades').show();
    $('#background_position_x').show();
    $('#background_position_y').show();
    $('#background_position_label').show();
}
if ($('#background_size_x').val() != null && $.isNumeric($('#background_size_x').val()) || $('#background_size_y').val() != null && $.isNumeric($('#background_size_y').val())){
    $('#propiedades').show();
    $('#background_size_x').show();
    $('#background_size_y').show();
    $('#background_size_label').show();
}
if ($('#background_size_val').val() != null && $.isNumeric($('#background_size_val').val())){
    $('#propiedades').show();
    $('#background_size_val').show();
    $('#background_size_label').show();
}
if ($('#pathContido').val().length > 0){
    $('#propiedades').show();
    $('#background_position').show();
    $('#background_repeat').show();
    $('#background_size').show();
    $('#background_position_label').show();
    $('#background_repeat_label').show();
    $('#background_size_label').show();
}
 $(document).ready(function() {
     $('#colorpicker').farbtastic('#background_color');
 });

/*var winW = 630, winH = 460;
if (document.body && document.body.offsetWidth) {
 winW = document.body.offsetWidth;
 winH = document.body.offsetHeight;
}
if (document.compatMode=='CSS1Compat' &&
    document.documentElement &&
    document.documentElement.offsetWidth ) {
 winW = document.documentElement.offsetWidth;
 winH = document.documentElement.offsetHeight;
}
if (window.innerWidth && window.innerHeight) {
 winW = window.innerWidth;
 winH = window.innerHeight;
}

document.writeln('Window width = '+winW);
document.writeln('Window height = '+winH);*/