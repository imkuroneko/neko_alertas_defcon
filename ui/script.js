$(function () {
	window.onload = function (e) {
		window.addEventListener('message', function (event) {
			var item = event.data;
			if(item !== undefined && item.type === "logo") {
				const img = document.getElementById('img');
				if(item.display === "alerta_verde") {
					img.src = 'img/alerta_verde.png'
				} else if(item.display === "alerta_amarilla") {
					img.src = 'img/alerta_amarilla.png'
				} else if(item.display === "alerta_roja") {
					img.src = 'img/alerta_roja.png'
				}
			}
		});
	};
});