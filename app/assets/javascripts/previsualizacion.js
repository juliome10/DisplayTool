// Last updated November 2010 by Simon Sarris
// www.simonsarris.com
// sarris@acm.org
//
// Free to use and distribute at will
// So long as you are nice to people, etc

// This is a self-executing function that I added only to stop this
// new script from interfering with the old one. It's a good idea in general, but not
// something I wanted to go over during this tutorial
(function(window) {


// holds all our boxes
var boxes = [];

// New, holds the 8 tiny boxes that will be our selection handles
// the selection handles will be in this order:
// 0  1  2
// 3     4
// 5  6  7
var selectionHandles = [];

// Hold canvas information
var canvas;

var ctx;

var WIDTH;

var HEIGHT;

var INTERVAL = 20;  // how often, in milliseconds, we check to see if a redraw is needed

var isDrag = false;

var isResizeDrag = false;

var expectResize = -1; // New, will save the # of the selection handle if the mouse is over one.
var mx, my; // mouse coordinates

 // when set to true, the canvas will redraw everything
 // invalidate() just sets this to false right now
 // we want to call invalidate() whenever we make a change
var canvasValid = false;

// The node (if any) being selected.
// If in the future we want to select multiple objects, this will get turned into an array
var mySel = null;

// The selection color and width. Right now we have a red selection with a small width
var mySelColor = '#000';//'#CC0000';//'#9dafe0';
var mySelWidth = 2;
var mySelBoxColor = 'darkred'; // New for selection boxes
var mySelBoxSize = 6;

// we use a fake canvas to draw individual shapes for selection testing
var ghostcanvas;

var gctx; // fake canvas context

// since we can drag from anywhere in a node
// instead of just its x/y corner, we need to save
// the offset of the mouse when we start dragging.
var offsetx, offsety;

// Padding and border style widths for mouse offsets
var stylePaddingLeft, stylePaddingTop, styleBorderLeft, styleBorderTop;
//var stylePaddingLeft2, stylePaddingTop2, styleBorderLeft2, styleBorderTop2;
//var stylePaddingLeft3, stylePaddingTop3, styleBorderLeft3, styleBorderTop3;

/************************************************************************************************************************************************/

// Box object to hold data
function Box() {
  this.x = 0;
  this.y = 0;
  this.w = 0;
  this.h = 0;
  this.fill = '#444444';
  this.row = 0;
}

/************************************************************************************************************************************************/

// New methods on the Box class
Box.prototype = {
  // we used to have a solo draw function
  // but now each box is responsible for its own drawing
  // mainDraw() will call this with the normal canvas
  // myDown will call this with the ghost canvas with 'black'
  draw: function(context, optionalColor) {
      if (context === gctx){ //|| context === gctx2 || context === gctx3) {
        context.fillStyle = 'black'; // always want black for the ghost canvas
      } else {
        context.fillStyle = this.fill;
      }
      
      // We can skip the drawing of elements that have moved off the screen:
      if (this.x > WIDTH || this.y > HEIGHT) return; 
      if (this.x + this.w < 0 || this.y + this.h < 0) return;
      
      context.fillRect(this.x,this.y,this.w,this.h);
      
    // draw selection
    // this is a stroke along the box and also 8 new selection handles
    if (mySel === this) {
      context.strokeStyle = mySelColor;
      context.lineWidth = mySelWidth;
      context.strokeRect(this.x,this.y,this.w,this.h);

      //PINTAR TODA A TABLA DE BLANCO
      pintarTablaBlanco();

      //CAMBIAR COR DA FILA
      var fila = this.row;
      var filas = document.getElementById('tabla').getElementsByTagName('td');
      for (var i=fila*7; i<fila*7+7; i++){
      	filas[i].style.background = "#9dafe0";//#d0dafd
      }
        

      //DEBUXO DAS CAIXAS DE REDIMENSIÓN
      /*/ draw the boxes
      var half = mySelBoxSize / 2;
      
      // 0  1  2
      // 3     4
      // 5  6  7

      var x = parseFloat(this.x);
      var y = parseFloat(this.y);
      var w = parseFloat(this.w);
      var h = parseFloat(this.h);

      // top left, middle, right
      selectionHandles[0].x = x-half;
      selectionHandles[0].y = y-half;

      selectionHandles[1].x = x+w/2-half;
      selectionHandles[1].y = y-half;

      selectionHandles[2].x = x + w-half;
      selectionHandles[2].y = y-half;

      //middle left
      selectionHandles[3].x = x-half;
      selectionHandles[3].y = y+h/2-half;

      //middle right
      selectionHandles[4].x = x+w-half;
      selectionHandles[4].y = y+h/2-half;

      //bottom left, middle, right
      selectionHandles[6].x = x+w/2-half;
      selectionHandles[6].y = y+h-half;

      selectionHandles[5].x = x-half;
      selectionHandles[5].y = y+h-half;

      selectionHandles[7].x = x+w-half;
      selectionHandles[7].y = y+h-half;

      
      context.fillStyle = mySelBoxColor;
      for (var i = 0; i < 8; i ++) {
        var cur = selectionHandles[i];
        context.fillRect(cur.x, cur.y, mySelBoxSize, mySelBoxSize);
      }*/
    }
    
  } // end draw

}

/************************************************************************************************************************************************/

//Initialize a new Box, add it, and invalidate the canvas
function addRect(x, y, w, h, fill, row) {
  var rect = new Box;
  rect.x = x;
  rect.y = y;
  rect.w = w
  rect.h = h;
  rect.fill = fill;
  rect.row = row;
  boxes.push(rect);
  invalidate();
}

/************************************************************************************************************************************************/

// initialize our canvas, add a ghost canvas, set draw loop then add everything we want to intially exist on the canvas
function init() {
  canvas = document.getElementById('canvas');
  HEIGHT = canvas.height;
  WIDTH = canvas.width;
  ctx = canvas.getContext('2d');
  ghostcanvas = document.createElement('canvas');
  ghostcanvas.height = HEIGHT;
  ghostcanvas.width = WIDTH;
  gctx = ghostcanvas.getContext('2d');
  
  //fixes a problem where double clicking causes text to get selected on the canvas
  canvas.onselectstart = function () {return false;}
  
// fixes mouse co-ordinate problems when there's a border or padding
  // see getMouse for more detail
  if (document.defaultView && document.defaultView.getComputedStyle) {
    stylePaddingLeft = parseInt(document.defaultView.getComputedStyle(canvas, null)['paddingLeft'], 10)     || 0;
    stylePaddingTop  = parseInt(document.defaultView.getComputedStyle(canvas, null)['paddingTop'], 10)      || 0;
    styleBorderLeft  = parseInt(document.defaultView.getComputedStyle(canvas, null)['borderLeftWidth'], 10) || 0;
    styleBorderTop   = parseInt(document.defaultView.getComputedStyle(canvas, null)['borderTopWidth'], 10)  || 0;
  }
  
  // make mainDraw() fire every INTERVAL milliseconds
  setInterval(mainDraw, INTERVAL);
  
  // set our events. Up and down are for dragging
  canvas.onmousedown = myDown;
  canvas.onmouseup = myUp;
  //canvas.ondblclick = myDblClick;
  canvas.onmousemove = myMove;
  
  //canvas2.onmousedown = myDown;
  //canvas2.onmouseup = myUp;
  //canvas2.ondblclick = myDblClick;
  //canvas2.onmousemove = myMove;

  //canvas3.onmousedown = myDown;
  //canvas3.onmouseup = myUp;

  // set up the selection handle boxes
  for (var i = 0; i < 8; i ++) {
    var rect = new Box;
    selectionHandles.push(rect);
  }

  //var datosInputs;
  //var datosTds;
  var posX = [];
  var posY = [];
  var lonX = [];
  var lonY = [];
  //var disp = [];
  //var campo = [];
  
  //datosInputs = document.getElementById('tabla').getElementsByTagName('input');
  //datosTds = document.getElementById('tabla').getElementsByTagName('td');
  inputs = document.querySelectorAll("#tabla input[type=text]")
  
  for(var i=0; i<inputs.length; i++){
      if(inputs[i].id == 'posicionX'){
	posX.push(inputs[i].value);
      }else if(inputs[i].id == 'posicionY'){
        posY.push(inputs[i].value);
      }else if(inputs[i].id == 'lonxitudeX'){
        lonX.push(inputs[i].value);
      }else if(inputs[i].id == 'lonxitudeY'){
        lonY.push(inputs[i].value);
      }
  }

    //Recuperación da liña cos datos
    var medidas = document.getElementById('medidas').innerHTML;
    //Eliminación de datos innecesarios
    medidas = medidas.replace("<b>Miniatura: </b>(","")
    medidas = medidas.replace(")","");
    //Recuperación do ancho
    var ancho = parseInt(medidas.substr(0, medidas.indexOf('x')));
    //Recuperación do alto
    var alto = parseInt(medidas.substr(medidas.indexOf('x')+1,medidas.length));
  
    for(var j=0; j<posX.length; j++){
        //addRect(x, y, w, h, fill, row) {
        addRect(calcularValor(ancho,posX[j]), calcularValor(alto,posY[j]), calcularValor(ancho,lonX[j]), calcularValor(alto,lonY[j]),calcularColor(j+1),j);
  }
}

/************************************************************************************************************************************************/
//Calcula os tamaños ou lonxitudes da caixa segundo a porcentaxe que ocupa na miniatura.
function calcularValor(total,porcentaje){
    return porcentaje * total / 100;
}

/************************************************************************************************************************************************/

function calcularColor(idCampo){
    idCampo = idCampo%10;
    switch(idCampo){
		case 0:
			return 'rgba(0,0,0,0.7)';
		break;		
		case 1:
			return 'rgba(200,0,0,0.7)';
		break;
		case 2:
			return 'rgba(200,200,0,0.7)';
		break;
		case 3:
			return 'rgba(0,200,0,0.7)';
		break;
		case 4:
			return 'rgba(0,200,200,0.7)';
		break;
		case 5:
			return 'rgba(0,0,200,0.7)';
		break;
		case 6:
			return 'rgba(200,0,200,0.7)';
		break;
		case 7:
			return 'rgba(50,0,200,0.7)';
		break;
		case 8:
			return 'rgba(200,0,50,0.7)';
		break;
		case 9:
			return 'rgba(0,50,200,0.7)';
		break;
		
	}
}

/************************************************************************************************************************************************/
function pintarTablaBlanco(){
	var filas = document.getElementById('tabla').getElementsByTagName('td');
	for (var i=0; i<filas.length; i++){
  		filas[i].style.background = "white";
  	}
}

/************************************************************************************************************************************************/

function pintarFila(nFila){

        if (boxes.length == 0){
            init();
        }

        //Píntase toda a tabla de blanco
        pintarTablaBlanco();
        //Identifícase a caixa respectiva á fila
        mySel = boxes[nFila];
        //Volver a debuxar
        invalidate();

}

/************************************************************************************************************************************************/

//wipes the canvas context
function clear(c) {
        c.clearRect(0, 0, WIDTH, HEIGHT);
}

/************************************************************************************************************************************************/

// Main draw loop.
// While draw is called as often as the INTERVAL variable demands,
// It only ever does something if the canvas gets invalidated by our code
function mainDraw() {
  if (canvasValid == false) {
	
    clear(ctx);
    // Add stuff you want drawn in the background all the time here
    
    // draw all boxes
	//DEBUXAMOS AS CAIXAS NOS CANVAS CORRESPONDENTES
	var l = boxes.length;
	for (var i = 0; i < l; i++) {
	  boxes[i].draw(ctx); // we used to call drawshape, but now each box draws itself
	}
	/*l = boxes2.length;
	for (var i = 0; i < l; i++){
		boxes2[i].draw(ctx2);
	}
	l = boxes3.length;
	for (var i = 0; i < l; i++){
		boxes3[i].draw(ctx3);
	} */

	// Add stuff you want drawn on top all the time here
    canvasValid = true;
	  
  }
	
}

/************************************************************************************************************************************************/

// Happens when the mouse is clicked in the canvas
function myDown(e){
  getMouse(e);
	  //we are over a selection box
	  //PINCHAMOS SOBRE UN BOX DE REDIMENSIÓN
	  if (expectResize !== -1) {
		isResizeDrag = true;
		return;
	  }
	  
	  //CONTROL DE EVENTO EN CANVAS 1
	  if(this.id == "canvas"){
		  clear(gctx,this.id);
		  var l = boxes.length;
		  for (var i = l-1; i >= 0; i--) {
			// draw shape onto ghost context
			boxes[i].draw(gctx, 'black');
			// get image data at the mouse x,y pixel
			var imageData = gctx.getImageData(mx, my, 1, 1);
			var index = (mx + my * imageData.width) * 4;
			// if the mouse pixel exists, select and break
			if (imageData.data[3] > 0) {
			  	mySel = boxes[i];
			  	offsetx = mx - mySel.x;
			  	offsety = my - mySel.y;
			  	mySel.x = mx - offsetx;
			  	mySel.y = my - offsety;
			  	isDrag = true;
			  
			  invalidate();
			  clear(gctx,this.id);
		  	  return;
			}
		  }
	  //CONTROL DE EVENTO EN CANVAS 2
	  }/*else if(this.id == "canvas2"){
		  clear(gctx2,this.id);
          var l = boxes2.length;
		  for (var i = l-1; i >= 0; i--) {
			// draw shape onto ghost context
			boxes2[i].draw(gctx2, 'black');
			// get image data at the mouse x,y pixel
			var imageData = gctx2.getImageData(mx, my, 1, 1);
			var index = (mx + my * imageData.width) * 4;
			// if the mouse pixel exists, select and break
			if (imageData.data[3] > 0) {
			  	mySel = boxes2[i];
			  	offsetx = mx - mySel.x;
			  	offsety = my - mySel.y;
			  	mySel.x = mx - offsetx;
			  	mySel.y = my - offsety;
			  	isDrag = true;
			  
			  invalidate();
			  clear(gctx2,this.id);
		  	  return;
			}
		  }
	  //CONTROL DE EVENTO EN CANVAS 3
	  }else if(this.id == "canvas3"){
		  clear(gctx3,this.id);
  	  	  var l = boxes3.length;
		  for (var i = l-1; i >= 0; i--) {
			// draw shape onto ghost context
			boxes3[i].draw(gctx3, 'black');
			// get image data at the mouse x,y pixel
			var imageData = gctx3.getImageData(mx, my, 1, 1);
			var index = (mx + my * imageData.width) * 4;
			// if the mouse pixel exists, select and break
			if (imageData.data[3] > 0) {
			  	mySel = boxes3[i];
			  	offsetx = mx - mySel.x;
			  	offsety = my - mySel.y;
			  	mySel.x = mx - offsetx;
			  	mySel.y = my - offsety;
			  	isDrag = true;
			  
			  invalidate();
			  clear(gctx3,this.id);
		  	  return;
			}
		  }
   	  }*/

	  // havent returned means we have selected nothing
	  mySel = null;
	  //NADA SELECIONADO, POLO QUE PINTAMOS A TABLA DE BLANCO
	  pintarTablaBlanco();
	  // clear the ghost canvas for next time
		clear(gctx);

                /*if(this.id == "canvas"){
			clear(gctx,this.id);
        }else if(this.id == "canvas2"){
			clear(gctx2,this.id);
	  	}else if(this.id == "canvas3"){
			clear(gctx3,this.id);
		}*/
	  // invalidate because we might need the selection border to disappear
	  invalidate();
}

/************************************************************************************************************************************************/

function myUp(){
  isDrag = false;
  isResizeDrag = false;
  expectResize = -1;
}


/************************************************************************************************************************************************/

function invalidate() {
	
  canvasValid = false;
  /*var filas = document.getElementById('formatos').getElementsByTagName('td');
      for (var i=0; i<filas.length; i++){
      	filas[i].style.background = "white";
      }*/
}


/************************************************************************************************************************************************/
// Sets mx,my to the mouse position relative to the canvas unfortunately this can be tricky, we have to worry about padding and borders
function getMouse(e) {
	var element = canvas;
	var offsetX = 0, offsetY = 0;
	if (element.offsetParent) {
            do {
                offsetX += element.offsetLeft;
                offsetY += element.offsetTop;
            }while ((element = element.offsetParent));
        }

	// Add padding and border style widths to offset
	offsetX += stylePaddingLeft;
        offsetY += stylePaddingTop;

        offsetX += styleBorderLeft;
        offsetY += styleBorderTop;
	
	mx = e.pageX - offsetX;
	my = e.pageY - offsetY;
}

/************************************************************************************************************************************************/

// Happens when the mouse is moving inside the canvas
function myMove(e){
  if (isDrag) {
    getMouse(e);
    //alert("Pinchei un!");
    mySel.x = mx - offsetx;
    mySel.y = my - offsety;   
    
    // something is changing position so we better invalidate the canvas!
    invalidate();
  } else if (isResizeDrag) {
    // time ro resize!
    var oldx = mySel.x;
    var oldy = mySel.y;

    // 0  1  2
    // 3     4
    // 5  6  7
    switch (expectResize) {
      case 0:
        mySel.x = mx;
        mySel.y = my;
        mySel.w += oldx - mx;
        mySel.h += oldy - my;
        break;
      case 1:
        mySel.y = my;
        mySel.h += oldy - my;
        break;
      case 2:
        mySel.y = my;
        mySel.w = mx - oldx;
        mySel.h += oldy - my;
        break;
      case 3:
        mySel.x = mx;
        mySel.w += oldx - mx;
        break;
      case 4:
        mySel.w = mx - oldx;
        break;
      case 5:
        mySel.x = mx;
        mySel.w += oldx - mx;
        mySel.h = my - oldy;
        break;
      case 6:
        mySel.h = my - oldy;
        break;
      case 7:
        mySel.w = mx - oldx;
        mySel.h = my - oldy;
        break;
    }
    
    invalidate();
  }
  
  getMouse(e);
  // if there's a selection see if we grabbed one of the selection handles
  if (mySel !== null && !isResizeDrag) {
    for (var i = 0; i < 8; i++) {
      // 0  1  2
      // 3     4
      // 5  6  7
      
      var cur = selectionHandles[i];
      
      // we dont need to use the ghost context because
      // selection handles will always be rectangles
      if (mx >= cur.x && mx <= cur.x + mySelBoxSize &&
          my >= cur.y && my <= cur.y + mySelBoxSize) {
        // we found one!
        expectResize = i;
        invalidate();
        
        switch (i) {
          case 0:
            this.style.cursor='nw-resize';
            break;
          case 1:
            this.style.cursor='n-resize';
            break;
          case 2:
            this.style.cursor='ne-resize';
            break;
          case 3:
            this.style.cursor='w-resize';
            break;
          case 4:
            this.style.cursor='e-resize';
            break;
          case 5:
            this.style.cursor='sw-resize';
            break;
          case 6:
            this.style.cursor='s-resize';
            break;
          case 7:
            this.style.cursor='se-resize';
            break;
        }
        return;
      }
      
    }
    // not over a selection box, return to normal
    isResizeDrag = false;
    expectResize = -1;
    this.style.cursor='auto';
  }
  
}

/************************************************************************************************************************************************/

// adds a new node
function myDblClick(e) {
  getMouse(e);
  // for this method width and height determine the starting X and Y, too.
  // so I left them as vars in case someone wanted to make them args for something and copy this code
  var width = 20;
  var height = 20;
  addRect(mx - (width / 2), my - (height / 2), width, height, 'rgba(220,205,65,0.7)');
}

/************************************************************************************************************************************************/

// If you dont want to use <body onLoad='init()'>
// You could uncomment this init() reference and place the script reference inside the body tag
//init();
window.init = init;
window.pintarFila = pintarFila;
})(window);


