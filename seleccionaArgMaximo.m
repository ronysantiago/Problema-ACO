function numCargaSeleccionada = seleccionaArgMaximo(origen, tau, eta, alfa, beta, cargasViables)
    % Numero de cargasViables
    numCargas = size(cargasViables, 1);
    
    % Vector de índices máximos
    arg = zeros(numCargas, 1);

    % Calcular índice máximo para cada fila
    for i = 1:numCargas
        % Nodo al que se mueve el avión -> Nodo en el que cogerá la carga
        destino = cargasViables(i, 1); 
        
        % Calcular el valor de la fórmula
        arg(i) = tau(origen, destino)^alfa * eta(origen, destino)^beta;
    end
    % Encontrar el índice máximo
    [~, numCargaSeleccionada] = max(arg);
end