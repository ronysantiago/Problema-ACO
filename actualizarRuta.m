function [ruta, avion, cargaAlmacenada, decisiones] = actualizarRuta(ruta, avion, cargaAlmacenada, datos, decisiones)

    origen = avion(3); % El origen es la posición del avión
    destino = cargaAlmacenada(end,1); % El destino es el nodo en el que se coge la carga

    decisiones = [decisiones; origen destino]; % Almacena la decisión tomada

    % Caso en el que la carga esté en el nodo del avión
    if origen == destino
        % Si es la primera carga que se coge en ese nodo
        if length(ruta.carga) == length(ruta.origen) % Si los vectores carga y origen miden igual, es primera carga
            ruta.carga{end+1} = cargaAlmacenada(end,:);
        % Si ya se han cogido otras cargas
        else
            ruta.carga{end} = [ruta.carga{end}; cargaAlmacenada(end,:)];
        end
    
    % En en el que la carga se recoja en otro nodo
    else
        nTramo = length(ruta.origen) + 1; % Equivalente a un (end+1) pero es mejor calcular nTramo
        ruta.origen(nTramo) = origen;  % Origen del tramo
        ruta.destino(nTramo) = destino; % Destino del tramo
        ruta.tiempoOrigen(nTramo) = avion(1);   % Hora de despegue
        ruta.tiempoDestino(nTramo) = ruta.tiempoOrigen(nTramo) + datos.distancias(origen,destino);  % Hora de aterrizaje
        ruta.descarga{nTramo} = []; % Creamos la celda de descarga vacía
        % La carga se muestra que se coge en el origen del siguiente tramo,
        % ya que nTramo tiene como destino el origen de la carga
        ruta.carga{nTramo + 1} = cargaAlmacenada(end,:);

        avion(1) = ruta.tiempoDestino(nTramo) + datos.tiempoEscala;   % Añade la escala correspondiente tras aterrizaje
        avion(3) = ruta.destino(nTramo);    % Actualiza la posición del avión

        % Deja toda la carga con destino en el nodo actual
        [ruta, avion, cargaAlmacenada] = dejaCarga(ruta, avion, cargaAlmacenada);
    end        
end