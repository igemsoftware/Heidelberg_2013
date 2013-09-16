var gCanvasElement; var size = 0; var clickX = 0; var clickY = 0; var Xpos = 0; var Ypos = 0; var hydrophobicity_array = 0; var click = 0; var scheme = 0; var fontsize = 8;
var name_width = 15;
var font_string  = "8pt monospace";
var aln_len = affe.length;
var numseq = $("#affe.List").children().length;
	hydrophobicity_array = new Array(numseq);
	for(i = 0;i < numseq;i++){
		hydrophobicity_array[i] = new Array(aln_len);
	}
function onKeyDown(evt) {
var element;var jump = 1;if(fontsize <= 8) {
	jump = 5;
}
	if (evt.keyCode == 39) draw(Xpos+jump, Ypos ,0);
	else if (evt.keyCode == 40)draw(Xpos,  Ypos+jump ,0);
	else if (evt.keyCode == 38)draw(Xpos,  Ypos-jump ,0);
	else if (evt.keyCode == 37)draw(Xpos-jump,  Ypos ,0);
	else if (evt.keyCode == 189)draw(0, 0 , -4);
	else if (evt.keyCode == 187)draw(0, 0 , 4);
	else if (evt.keyCode == 109)draw(0, 0 , -4);
	else if (evt.keyCode == 61)draw(0, 0 , 4);
}
	document.addEventListener("keydown", onKeyDown, false);
var a = new Array(numseq);
for (var i = 0; i < a.length; i++) {
    a[i] = new String (affe[i]);
}

var n = new Array(numseq);
for (var i = 0; i < n.length; i++) {
    n[i] = new String (affe[i]);
}

function Joshua_annotation(x,ctx) {
switch (x){
	case 'A':
	case 'F':
	case 'I':
	case 'L':
	case 'M':
	case 'V':
	case 'W':
	case 'Y':
		ctx.fillStyle = "#ffff00";
		break;
	case 'B':
		ctx.fillStyle = "#ffffff";
		break;
	case 'C':
		ctx.fillStyle =  "#00bfff";
		break;
	case 'G':
	case 'P':
		ctx.fillStyle =  "#00ffff";
		break;
	case 'H':
	case 'K':
	case 'R':
		ctx.fillStyle= "#00ff00";
		break;
	case 'D':
	case 'E':
	case 'N':
	case 'Q':
	case 'S':
	case 'T':
		ctx.fillStyle= "#f08080";
		break;
	default:
		ctx.fillStyle = "#ffffff";
		break;
}
}
function Nikos_annotation(x,ctx) {
switch (x){
	case 'B':
	case 'Z':
		ctx.fillStyle = "#ffffff";
		break;
	case 'A':
	case 'C':
	case 'F':
	case 'I':
	case 'L':
	case 'M':
	case 'V':
	case 'W':
		ctx.fillStyle = "#00bfff";
		break;
	case 'D':
	case 'E':
		ctx.fillStyle = "#ba55d3";
		break;
	case 'G':
		ctx.fillStyle = "#ffa500";
		break;
	case 'H':
		ctx.fillStyle = "#87cefa";
		break;
	case 'K':
	case 'R':
		ctx.fillStyle = "#ff0000";
		break;
	case 'N':
	case 'Q':
	case 'S':
	case 'T':
		ctx.fillStyle = "#00ff00";
		break;
	case 'P':
		ctx.fillStyle =  "#ffff00";
		break;
	case 'Y':
		ctx.fillStyle =" #87cefa";
		break;
	default:
		ctx.fillStyle = "#ffffff";
		break;
}
}
function hydro_annotation(x,ctx) {
switch (x){
	case -4:
		ctx.fillStyle = "#00008b";
		break;
	case -3:
		ctx.fillStyle = "#0000ff";
		break;
	case -2:
		ctx.fillStyle = "#1e90ff";
		break;
	case -1:
		ctx.fillStyle = "#87cefa";
		break;
	case 0:
		ctx.fillStyle = "#ffffff";
		break;
	case 1:
		ctx.fillStyle = "#ffb6c1";
		break;
	case 2:
		ctx.fillStyle = "#ff6347";
		break;
	case 3:
		ctx.fillStyle = "#dc143c";
		break;
	case 4:
		ctx.fillStyle = "#bdb76b";
		break;
	default:
		ctx.fillStyle = "#ffffff";
		break;
}
}
function kdval(x) {
switch (x){
	case 'A':
		return 1.8;
		break;
	case 'B':
		return 0;
		break;
	case 'C':
		return 2.5;
		break;
	case 'D':
		return -3.5;
		break;
	case 'E':
		return -3.5;
		break;
	case 'F':
		return 2.8;
		break;
	case 'G':
		return -0.4;
		break;
	case 'H':
		return -3.2;
		break;
	case 'I':
		return 4.5;
		break;
	case 'J':
		return 0;
		break;
	case 'K':
		return -3.9;
		break;
	case 'L':
		return 3.8;
		break;
	case 'M':
		return 1.9;
		break;
	case 'N':
		return -3.5;
		break;
	case 'O':
		return 0;
		break;
	case 'P':
		return -1.6;
		break;
	case 'Q':
		return -3.5;
		break;
	case 'R':
		return -4.5;
		break;
	case 'S':
		return -0.8;
		break;
	case 'T':
		return -0.7;
		break;
	case 'U':
		return 0;
		break;
	case 'V':
		return 4.2;
		break;
	case 'W':
		return -0.9;
		break;
	case 'X':
		return 0;
		break;
	case 'Y':
		return -1.3;
		break;
	case 'Z':
		return 0;
		break;
}
}
function default_dna_annotation(x,ctx) {
switch (x){
	case 'A':
		ctx.fillStyle = "#8470ff";
		break;
	case 'C':
		ctx.fillStyle = "#f4a460";
		break;
	case 'G':
		ctx.fillStyle = "#f08080";
		break;
	case 'T':
		ctx.fillStyle = "#90ee90";
		break;
	case 'U':
		ctx.fillStyle = "#d3d3d3";
		break;
	default:
		ctx.fillStyle = "#ffffff";
		break;
}
}
function strong_dna_annotation(x,ctx) {
switch (x){
	case 'A':
		ctx.fillStyle = "#32cd32";
		break;
	case 'C':
		ctx.fillStyle = "#4169e1";
		break;
	case 'G':
		ctx.fillStyle = "#ffa500";
		break;
	case 'T':
		ctx.fillStyle = "#ff0000";
		break;
	case 'U':
		ctx.fillStyle = "#ffffff";
		break;
	default:
		ctx.fillStyle = "#ffffff";
		break;
}
}
function hydrophobicity(x) {
var run  = 0;var c = 0;var score = 0;var tmp =  new Array (aln_len);var tmp_val =  new Array (aln_len);var kd = [1.8,0,2.5,-3.5,-3.5,2.8,-0.4,-3.2,4.5,0,-3.9,3.8,1.9,-3.5,0,-1.6,-3.5,-4.5,-0.8,-0.7,0,4.2,-0.9,0,-1.3,0];	if ( typeof hydrophobicity.window == 'undefined' ) {
		hydrophobicity.window = x;
		run  = 1;	}else{ 
		if (hydrophobicity.window!= x ) {
			hydrophobicity.window = x;
			run  = 1;		}
	}
	if (run == 1) {
		for(i = 0;i < numseq;i++){
			for(j = 0;j < aln_len;j++){
				hydrophobicity_array[i][j] = -99;
			}
		}
		for(i = 0;i < numseq;i++){
			c  = 0;			for(j = 0;j < aln_len;j++){
				if(a[i].charAt (j) >= 'A' && a[i].charAt (j) <= 'Z'){
					tmp[c] = a[i].charAt(j);
					c = c + 1;
				}
			}
			for(j = 0;j < aln_len;j++){
				tmp_val[j] = -99;
			}
			for (j = 0;j <= c - x;j++){
				score = 0;
				for ( g = 0; g < x;g++){
					score += kdval (tmp[j+g]);
				}
				score =  score / x;
				tmp_val[parseInt(j+ x/2)] = parseInt(score);
			}
			c  = 0;			for(j = 0;j < aln_len;j++){
				if(a[i].charAt (j) >= 'A' && a[i].charAt (j) <= 'Z'){
					hydrophobicity_array[i][j]  = tmp_val[c];
					c = c + 1;
				}
			}
		}
	}
}
function conservation_routine() {
var run  = 0;var c = 0;var score = 0;var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";var tmp =  new Array (26);for(i = 0;i < aln_len;i++){
	for(j = 0;j < 26;j++){
		tmp[j] = 0;
	}
	for(j = 0;j < numseq;j++){
		c = alphabet.indexOf(a[j].charAt (i)) ;
		if(c != -1){
			tmp[c] = tmp[c] + 1;
		}
	}
	c = -1;
	for(j = 0;j < 26;j++){
		if(tmp[j] / numseq> c){
			c = tmp[j] /numseq;
		}
	}
	if (c > 0.9) score = 10;
	else if (c > 0.8)score = 9;
	else if (c >0.7)score = 8;
	else if (c > 0.6 )score = 7;
	else if (c > 0.5)score = 6;
	else if (c > 0.4)score = 5;
	else if (c > 0.3)score = 4;
	else if (c > 0.2 )score = 3;
	else score = 2;
	for(j = 0;j < numseq;j++){
		c = alphabet.indexOf(a[j].charAt (i)) ;
		if(c != -1){
			hydrophobicity_array[j][i] = score;
		}else{
			hydrophobicity_array[j][i] = 2;
		}
	}
}
}
function  conservation_color(x,ctx) {
switch (x){
	case 10:
		ctx.fillStyle = "#0000ff";
		break;
	case 9:
		ctx.fillStyle = "#0000cd";
		break;
	case 8:
		ctx.fillStyle = "#7b68ee";
		break;
	case 7:
		ctx.fillStyle = "#8470ff";
		break;
	case 6:
		ctx.fillStyle = "#87ceeb";
		break;
	case 5:
		ctx.fillStyle = "#87cefa";
		break;
	case 4:
		ctx.fillStyle = "#add8e6";
		break;
	case 3:
		ctx.fillStyle = "#e0ffff";
		break;
	case 2:
	default:
		ctx.fillStyle = "#ffffff";
		break;
}
}
function change_scheme(val)
{
	if(val > 6){
		hydrophobicity(val);
		scheme = 5;
	}else if(val ==2){
		conservation_routine();
		scheme = 2 ;
	}else{
	scheme = val;
}
}
function reset_click()
{
	click = 0;
}
function init()
{
div=document.getElementsByTagName('div')[0];
	gCanvasElement = document.getElementById("alignment");
	gCanvasElement.width=div.scrollWidth;
	gCanvasElement.height=div.scrollHeight;
	gCanvasElement.addEventListener("mousedown", record_pos, false);
	gCanvasElement.addEventListener("mouseup", record_pos, true);
	gCanvasElement.addEventListener("click", reset_click, false);
}
function record_pos(e)
{
var x;
var y;
var x_move;
var y_move;
var xoffset = name_width*(fontsize + 4) +10;if (e.pageX || e.pageY) {
	x = e.pageX;
	y = e.pageY;
}	else {
	x = e.clientX +document.body.scrollLeft + document.documentElement.scrollLeft;
y = e.clientY +document.body.scrollTop + document.documentElement.scrollTop;
}
	x -= gCanvasElement.offsetLeft;
	y -= gCanvasElement.offsetTop;
if(y <  50 && x > xoffset){
 x_move = parseInt((x- xoffset) / (gCanvasElement.width- xoffset) * aln_len);
 y_move = Ypos;
	draw(x_move, y_move,0);
	click = 0;
}
if(click == 0){
 clickX = x;
 clickY = y;
	click = 1;
}else{
	x_move = Xpos+ parseInt((clickX - x) /  (fontsize + 4));
	y_move = Ypos+ parseInt((clickY - y) /  (fontsize + 4));
if(x_move < 0){
	x_move = 0;
}
	draw(x_move, y_move,0);
	click = 0;
}
}
function showValue(newValue)
{
	document.getElementById("range").innerHTML=newValue;
}
function draw(x,y,size) {
var yoffset = 50;var xoffset = 0;if ( typeof draw.xpos == 'undefined' ) {
	draw.xpos = 0;
}
if(typeof draw.ypos == 'undefined' ) {
	draw.ypos = 0;
}
if(x !=  0) {
	draw.xpos = parseInt(x);}
if(y !=  0) {
	draw.ypos = parseInt(y);}
if(draw.ypos +10 >  numseq ) {
	draw.ypos = numseq - 10;
}
if(draw.xpos +10 >  aln_len ) {
	draw.xpos = aln_len - 10;
}
if(draw.ypos < 0 ) {
	draw.ypos = 0;
}
if(draw.xpos  <  0  ) {
	draw.xpos = 0;
}
if(size != 0){
	fontsize = fontsize + size;
	if(fontsize  <  4  ) 	fontsize = 4;
	if(fontsize  > 96  ) 	fontsize = 96;
	font_string = fontsize +  "pt monospace";
}
Xpos = draw.xpos;xoffset = name_width*(fontsize + 4) +10;var canvas = document.getElementById("alignment");
if (canvas.getContext) {
var ctx = canvas.getContext("2d");
ctx.clearRect(0,0,canvas.width,canvas.height);
	ctx.beginPath();
	ctx.moveTo(xoffset,30);
	ctx.lineTo(canvas.width,30);
	ctx.strokeStyle = "#000";
	ctx.closePath();
	ctx.stroke();
	ctx.font =  "12pt monospace";
ctx.moveTo(600,40);
ctx.lineTo(600,150);
ctx.stroke();
	for(j = 0; j < aln_len;j +=100 ){
		ctx.fillStyle = "#0000000";
		ctx.fillText(j, j / aln_len*  (canvas.width- xoffset)  + xoffset,25);
		ctx.beginPath();
		ctx.moveTo( j / aln_len*  (canvas.width- xoffset)  + xoffset,25);
		ctx.lineTo( j / aln_len*  (canvas.width- xoffset)  + xoffset,35);
		ctx.strokeStyle = "#000";
		ctx.closePath();
		ctx.stroke();
	}
	ctx.beginPath();
	ctx.rect((Xpos /  aln_len) *  (canvas.width- xoffset)  + xoffset , 10, 3, 40);
	ctx.fillStyle = "#F62817";
	ctx.fill();
	ctx.fillStyle = "#000000";
if((numseq - draw.ypos) * (fontsize + 4) <  canvas.height-yoffset){
	draw.ypos  =  parseInt(numseq  -  parseInt((canvas.height-yoffset)   /    ( fontsize  + 4))); 	if(draw.ypos < 0 ) {
		draw.ypos = 0;
	}
}
Ypos = draw.ypos;	ctx.font = font_string;
for(i = draw.ypos;i < numseq;i++){
	for(j = 0; j < name_width;j++){
		ctx.fillText(n[i].charAt (j), (j+1) * (fontsize + 4), (i+1  - draw.ypos)*(fontsize+4)+yoffset);
	}
	for(j = draw.xpos; j < aln_len;j++){
		switch (parseInt(scheme)){
			case 0:
				Joshua_annotation(a[i].charAt (j),ctx);
				break;
			case 1:
				Nikos_annotation(a[i].charAt (j),ctx);
				break;
			case 2:
				conservation_color(hydrophobicity_array[i][j] ,ctx);
				break;
			case 3:
				default_dna_annotation(a[i].charAt (j) ,ctx);
				break;
			case 4:
				strong_dna_annotation(a[i].charAt (j) ,ctx);
				break;
			case 5:
				hydro_annotation(hydrophobicity_array[i][j] ,ctx);
				break;
			default:
				Joshua_annotation(a[i].charAt (j),ctx);
				break;
}
		ctx.beginPath();
		ctx.rect((j-draw.xpos) * (fontsize + 4)-4+xoffset, (i  - draw.ypos)*(fontsize+4)+yoffset +4, (fontsize + 4), (fontsize + 4));
		ctx.fill();
	ctx.fillStyle = "#000000";
		ctx.fillText(a[i].charAt (j), (j-draw.xpos) * (fontsize + 4)+xoffset, (i+1  - draw.ypos)*(fontsize+4)+yoffset);
		if((j-draw.xpos)* (fontsize + 4)> canvas.width){
			j = aln_len
		}
	}
}
}
}
