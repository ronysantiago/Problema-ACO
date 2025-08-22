function cargasViables = encontrarCargasViables(avion, datos, ruta, cargaAlmacenada)
    % Función para encontrar cargas viables en el nodo actual
    cargasViables = [];

    % Recorremos todas las posibilidades de carga
    for origen = 1:size(datos.cargas, 1)
        for destino = 1:size(datos.cargas, 1)

            % Si hay carga y el avión tiene suficiente espacio para cargarla
            if datos.cargas(origen, destino) > 0 && (avion(2) + datos.cargas(origen, destino) <= datos.cargaMax)
                % Calculamos el tiempo que costaría la ruta si añadimos la carga
                tiempoTotal = calcularTiempoTotal(origen, destino, avion, datos, ruta, cargaAlmacenada);
    
                % Si el tiempo total de ruta es menor que el máximo permitido
                if tiempoTotal <= datos.tiempoMax
                    % Agregamos la carga viable a la lista
                    cargasViables(end+1,:) = [origen, destino, datos.cargas(origen, destino),  tiempoTotal];
                end
            end

        end % Destino
    end % Origen
end