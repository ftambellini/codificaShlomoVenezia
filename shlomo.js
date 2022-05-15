// dichiarazione variabili
var scambio;
var count;
var nodoMinuti;
var nodoFrasi;

function gestoreLoad() {
    try {
        count = 1;
        scambio = true;
        nodoFrasi = document.getElementsByClassName("frasi");
        nodoMinuti = document.getElementsByClassName("minutaggio");
        var a = 1;
        for (var i = 0; i < nodoMinuti.length; i++) {
            nodoMinuti[i].setAttribute('id', [i + "m"]);
            nodoMinuti[i].onmouseover = function(e) {
                gestoreAssocia1(e.target.id);
            }
            nodoMinuti[i].onmouseout = gestoreDecolora1;
        }
    } catch (e) {
        alert("gestoreLoad" + e);
    }
}
//associazione frasi a minuti
function gestoreAssocia1(a) {
    try {
        var minuto = document.getElementById(a);
        minuto.style.backgroundColor = "#0dc8e0";
        for (var i = 0; i < nodoFrasi.length; i++) {
            nodoFrasi[i].setAttribute('id', [i]);
        }
        len = a.length;
        identificatore = a.substring(0, len - 1);
        var frase = document.getElementById(identificatore);
        frase.style.backgroundColor = "#0dc8e0";
    } catch (e) {
        alert("gestoreAssocia" + e);
    }
}
//De evidenza dopo che si toglie il mouse dai minuti
function gestoreDecolora1() {
    try {
        for (var i = 0; i < nodoMinuti.length; i++) {
            nodoMinuti[i].style.backgroundColor = "#e8e9ea";
            nodoFrasi[i].style.backgroundColor = "#e8e9ea";
        }
    } catch (e) {
        alert("gestoreDecolora" + e);
    }
}