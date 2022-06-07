// dichiarazione variabili
var scambio;
var count;
var nodoMinuti;
var nodoFrasi;
var modale;
var modale2;
var btn;
var btn2;
var span;
var span2;
var btnCerca;
var ricerca;
var isEmpty = str => !str.trim().length;

function gestoreLoad() {
    try {
        count = 1;
        scambio = true;
        modale = document.getElementById("modale");
        modale2 = document.getElementById("modale2");
        btn = document.getElementById("modal");
        btn2 = document.getElementById("modal2");
        span = document.getElementsByClassName("close")[0];
        span2 = document.getElementsByClassName("close2")[0];
        nodoFrasi = document.getElementsByClassName("frasi");
        nodoMinuti = document.getElementsByClassName("minutaggio");
        btnCerca = document.getElementById("cerca");
        ricerca = document.getElementById("ricerca");
        for (var i = 0; i < nodoFrasi.length; i++) {
            nodoFrasi[i].setAttribute('id', [i]);
        }
        btn.onclick = function() {
            modale.style.display = "block";
        }
        span.onclick = function() {
            modale.style.display = "none";
        }
        btn2.onclick = function() {
            modale2.style.display = "block";
        }
        span2.onclick = function() {
            modale2.style.display = "none";
        }
        
        var a = 1;
        var array = [];
        for (var i = 0; i < nodoMinuti.length; i++) {
            nodoMinuti[i].setAttribute('id', [i + "m"]);
            array.push(nodoMinuti[i]);
            nodoMinuti[i].onmouseover = function(e) {
                gestoreAssocia1(e.target.id);
            }
            nodoMinuti[i].onmouseout = gestoreDecolora1;
        }
        console.log((array[4].outerText).substr(2));
        btnCerca.onclick = function() {
            if (isEmpty (ricerca.value)) {
                alert("inserire i valori correttamente");
            } else {
            var id = ricerca.value;
            for (var i = 0; i < array.length; i++) {
                if (id == (array[i].outerText.substr(2))) {
                    var minuto = document.getElementById(i);
                    minuto.scrollIntoView({behavior: 'smooth'});
                    minuto.style.backgroundColor = "#0dc8e0";
                }
            }
        }
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
            nodoMinuti[i].style.backgroundColor = "#ccced0";
            nodoFrasi[i].style.backgroundColor = "#ccced0";
        }
    } catch (e) {
        alert("gestoreDecolora" + e);
    }
}