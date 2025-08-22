function [ruta, avion, cargaAlmacenada] = dejaCarga(ruta, avion, cargaAlmacenada)
    % Encuentra las cargas que puedan descargarse en el nodo en el que está el avión
    depositarCargas = find(cargaAlmacenada(:, 2) == avion(3));

    % Si el avión puede descargar en el nodo
    if ~isempty(depositarCargas)
        nVuelo = length(ruta.origen);

        % Creamos la celda ruta.descarga{nVuelo} para evitar errores
        if length(ruta.descarga) < nVuelo
            ruta.descarga{nVuelo} = [];
        end
        % También lo hacemos con el de carga para que tengan ambos el mismo tamaño
        if length(ruta.carga) < nVuelo
            ruta.carga{nVuelo} = [];
        end
        % Añade las filas coincidentes a ruta.descarga{nVuelo}
        ruta.descarga{nVuelo} = [ruta.descarga{nVuelo}; cargaAlmacenada(depositarCargas, :)];
    
        % Quita la carga del avión
        avion(2) = avion(2) - sum(cargaAlmacenada(depositarCargas, 3));
    
        % Elimina las cargas de cargaAlmacenada
        cargaAlmacenada(depositarCargas, :) = [];
    end
end