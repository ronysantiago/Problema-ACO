function [hangarSeleccionado, contadorHangares] = seleccionarHangar(hangares, tau, eta, alfa, beta, contadorHangares)
% Función que selecciona un hangar y retorna el valor del nodo del hangar y
% cuenta el numero de veces que ha sido seleccionado cada hangar
    numHangares = size(hangares, 1);    % Numero de hangares
    P = zeros(1, numHangares);          % Inicializa con ceros el vector que contendrá las probabilidades

    % Número de fila y columna que marca el comienzo de la diagonal que
    % está asociada a la elección de hangar
    limite = size(tau,1) - numHangares;

    for hangar = 1:numHangares
        i = limite + hangar;
        P(hangar) = tau(i,i)^alfa * eta(i,i)^beta;
    end

    P = P / sum(P);                 % Pasa las probabilidades a tanto por 1
    nHangar = tirarDados(P);        % Nos selecciona un hangar
    hangarSeleccionado = hangares(nHangar);   % Almacenamos el nodo del hangar seleccionado

    contadorHangares(nHangar) = contadorHangares(nHangar) + 1;
end