function cargasViables = encontrarOtrasCargasViables(avion, datos)
    % Función para encontrar cargas viables en otro nodo
    cargasViables = [];

    for recogida = 1:size(datos.cargas, 1)
        % Evita que busque carga en el nodo que está el avión
        if recogida ~= avion(3)
            for destino = 1:size(datos.cargas, 1)
                % Verifica si hay carga en el nodo actual y si es posible cargarla
                if datos.cargas(recogida, destino) > 0
                    % Calcula el tiempo que le cuesta ir desde que carga hasta el destino
                    tiempoTotal = calcularTiempoTotal(destino, recogida, avion, datos);
                    % Sumamos el movimiento en vacío + la escala para coger carga
                    tiempoTotal = tiempoTotal + datos.distancias(avion(3),recogida) + datos.tiempoEscala;
        
                    % Verifica si es factible tiempoMax y cargaMax
                    if tiempoTotal <= datos.tiempoMax && (avion(2) + datos.cargas(recogida, destino) <= datos.cargaMax)
                        % Agregamos la carga viable a la lista  [cantidadCargada - TiempoTotalAvion - OrigenCarga - DestinoCarga - PosicionDistancia - PosiciónAvión]
                        cargasViables = [cargasViables; [datos.cargas(recogida, destino), tiempoTotal, recogida, destino, avion(3), avion(3)]];
                    end % Revisión tiempo y carga

                end % Revisión si hay cargas

            end % Bucle destino

        end % Evita recogida en nodo del avión

    end % Bucle recogida
end