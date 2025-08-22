function tiempoOrigen = calcularTiempoOrigen(ruta, avion, datos)
    % Tiempo que el avión ya lleva de vuelo

    if isempty(ruta.origen)
        % Si es su primer viaje, no hay escala
        tiempoOrigen = avion(1);
    else
        % Si acaba de aterrizar, tomamos el tiempo al que llega y le
        % sumamos la escala debida a la carga y/o descarga
        tiempoOrigen = ruta.tiempoDestino(end) + datos.tiempoEscala;
    end
    
end