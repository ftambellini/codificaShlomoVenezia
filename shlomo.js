// dichiarazione variabili
var scambio;
var count;
var nodoMinuti;
var nodoFrasi;
var loc= window.location.href;
var url= new URL(loc);
var xmlid= url.searchParams.get("xmlid");
var obj = { "get":"https://memoriarchivio.org/getfilexml/",
        "put": "https://memoriarchivio.org/settestotxt/",
        "aut": "francesco"
};
var req = new XMLHttpRequest();

req.overrideMimeType('text/xml');

req.onreadystatechange = function(){
    if (req.readyState == 4) {
        if(req.status==200) {
            xmlDoc = req.responseXML; 
            token = req.getResponseHeader("token");
            testoid = req.getResponseHeader("testoid");
            user = req.getResponseHeader("userad");
            Transformation();
            }   
        }
    }
req.open('GET', obj["get"]+xmlid, true); 
req.send();

function Transformation(){    
  
    SaxonJS.transform({
        stylesheetLocation: "shlomo.sef.json",
        sourceNode: xmlDoc,
        initialTemplate: "main",
    }, "async")
};

function send(){
    if(user=="admin"){
      SaxonJS.transform({
          stylesheetLocation: "shlomoDownload.sef.json",
          sourceNode: xmlDoc,
          destination: "serialized"
      },"async")
      .then(output => {
        var result = output.principalResult;
        var xhr = new XMLHttpRequest();
        xhr.open("PUT",obj["put"] + testoid +'/' + token + obj["aut"], true);
        xhr.setRequestHeader('Content-type','text/plain; charset=utf-8');
        xhr.onload = function () {
          if (xhr.readyState == 4 && xhr.status == "202") {
            alert ("File inserito correttamente!");
          } else {
            console.log("File not found");
          }
        }
        xhr.send(result);
        });
    }else{
        alert("funzione abilitata solo per l'amministratore");
    }
   
}
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
        minuto.style.backgroundColor = "green";
        for (var i = 0; i < nodoFrasi.length; i++) {
            nodoFrasi[i].setAttribute('id', [i]);
        }
        len = a.length;
        identificatore = a.substring(0, len - 1);
        var frase = document.getElementById(identificatore);
        frase.style.backgroundColor = "green";
    } catch (e) {
        alert("gestoreAssocia" + e);
    }
}
//De evidenza dopo che si toglie il mouse dai minuti
function gestoreDecolora1() {
    try {
        for (var i = 0; i < nodoMinuti.length; i++) {
            nodoMinuti[i].style.backgroundColor = "#dbccac";
            nodoFrasi[i].style.backgroundColor = "#dbccac";
        }
    } catch (e) {
        alert("gestoreDecolora" + e);
    }
}

window.onload = gestoreLoad;