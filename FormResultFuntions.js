function getData(formname_input) {
    var xmlhttp = new XMLHttpRequest();

    var url = "https://api.engin.io/v1/objects/resultforms";
    //https://api.engin.io/v1/objects/coffees&limit=2
    var url = "https://api.engin.io/v1/users?q={\"username\":"+ formname_input +"}&limit=2"

    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            //myFunction(xmlhttp.responseText);
            var arr = JSON.parse(xmlhttp.responseText);
            console.log(xmlhttp.responseText);
            var arr1 = arr.results;
            for(var i = 0; i < arr1.length; i++) {
                console.log(arr1[i].id);
            }
            console.log(arr1);
        }
        else
        {
            console.log("Bad request")
        }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.setRequestHeader("Enginio-Backend-Id","54be545ae5bde551410243c3");
    xmlhttp.send();
}

function getDataUserForms(formname_input) {
    var xmlhttp = new XMLHttpRequest();
    var url = "https://api.engin.io/v1/users?q={\"username\":\""+ formname_input +"\"}&limit=1"

    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var arr = JSON.parse(xmlhttp.responseText);
            var arr1 = arr.results;
            console.log(" ok: "+ arr1[0].forms)
            return arr1[0].forms
            /*for(var i = 0; i < arr1.length; i++) {
                console.log(arr1[i].forms);
                return arr1[i].forms;
            }*/
        }
        else
        {
            console.log("Bad request")
        }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.setRequestHeader("Enginio-Backend-Id","54be545ae5bde551410243c3");
    xmlhttp.send();
}
function readJson(input){
    var data = input;
    var data1 = data.results
    console.log(data1);
}
