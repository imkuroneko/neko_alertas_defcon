$(function () {
    window.onload = function (e) {
        window.addEventListener('message', function (event) {
            var item = event.data;
            if(item !== undefined) {
                switch(item.alert) {
                    case 'g': $('#defcon').attr('src', 'img/alerta_verde.png'); break;
                    case 'y': $('#defcon').attr('src', 'img/alerta_amarilla.png'); break;
                    case 'r': $('#defcon').attr('src', 'img/alerta_roja.png'); break;
                    default:  $('#defcon').attr('src', 'img/alerta_verde.png'); break;
                }
            }
        });
    };
});