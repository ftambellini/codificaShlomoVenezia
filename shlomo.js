
window.onload = function() { 
    SaxonJS.transform({ 
        stylesheetLocation: "shlomo.sef.json", 
        sourceLocation: "shlomo.xml" 
    }, "async");
}