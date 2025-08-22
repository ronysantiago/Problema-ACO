function P = calcularProbabilidad(origen, tau, eta, alfa, beta, cargasViables)
    % Numero de cargasViables
    numCargas = size(cargasViables, 1);

    % Inicializa vectorProbabilidades
    P = zeros(1, size(cargasViables,1));

    % Calcula numerador
    for i = 1:numCargas
        % Nodo al que se mueve el avión -> Nodo en el que cogerá la carga
        destino = cargasViables(i, 1); 

        % Numerador de cada opción
        P(i) = tau(origen, destino)^alfa * eta(origen, destino)^beta;
    end
    % Lo pasa a tanto por 1
    P = P / sum(P);
end