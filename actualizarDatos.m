function [posicionDistancia, avion, datos, cargaRestante] = actualizarDatos(cargaSeleccionada, recogida, avion, datos, cargaRestante)
% posicion avion - carga avion - tiempo avión - carga restante - matriz de cargas

% Si el ultimo tiempoDestino se corresponde con la trayectoria trazada
% desde el origen actual, se coge ese tiempo
if (length(ruta.origen) ~= length(ruta.tiempoDestino))
    avion(1) = ruta.tiempoDestino(end);
% En caso de que 
else
end
% Función que actualiza tiempo y carga del avión, junto con
    % posicionDistancia y matriz de cargas
    
    % fila de cargaSeleccionada = [cantidadCargada - TiempoTotalAvion - OrigenCarga - DestinoCarga - PosicionDistancia - PosiciónAvión]
    posicionDistancia = cargaSeleccionada(4); % Actualiza posicionDistancia
    avion(1) = cargaSeleccionada(2); % Actualiza tiempo del avión
    avion(2) = avion(2) + cargaSeleccionada(1); % Actualiza carga del avión

    % Actualizar la matriz de cargas
    cargaRestante = cargaRestante - cargaSeleccionada(1);
    datos.cargas(recogida, cargaSeleccionada(4)) = datos.cargas(recogida, cargaSeleccionada(4)) - cargaSeleccionada(1);
end