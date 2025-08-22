function [ruta, avion, cargaAlmacenada] = entregarCargas(ruta, avion, cargaAlmacenada, datos)

    origen = avion(3); % El origen es la posición del avión
    destino = cargaAlmacenada(end,2); % El destino es el nodo en el que se coge la carga

    nTramo = length(ruta.origen) + 1; % Equivalente a un (end+1)
    ruta.origen(nTramo) = origen;  % Origen del tramo
    ruta.destino(nTramo) = destino; % Destino del tramo
    ruta.tiempoOrigen(nTramo) = avion(1);   % Hora de despegue
    ruta.tiempoDestino(nTramo) = ruta.tiempoOrigen(nTramo) + datos.distancias(origen,destino);  % Hora de aterrizaje

    avion(1) = ruta.tiempoDestino(nTramo) + datos.tiempoEscala;   % Añade la escala correspondiente tras aterrizaje
    avion(3) = ruta.destino(nTramo);    % Actualiza la posición del avión

    % Deja toda la carga con destino en el nodo actual
    [ruta, avion, cargaAlmacenada] = dejaCarga(ruta, avion, cargaAlmacenada);        
end