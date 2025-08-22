function ruta = inicializarRuta()
% Devuelve la estructura ruta con todos los campos creados
    ruta.origen = [];
    ruta.destino = [];
    ruta.tiempoOrigen = [];
    ruta.tiempoDestino = [];
    ruta.carga = {};
    ruta.descarga = {};
end