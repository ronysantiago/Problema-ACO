function aviones = generarAviones(hangares, numAviones)
% Genera un struct aviones.hangarX // X es el nodo del hangar y tiene numAviones aviones
% Cada avión tiene 4 columnas // tiempo - carga - posicion - nodoHangar
% Se inicializan con posición en el hangar de origen

    % Inicializa la estructura de aviones
    aviones = struct();

    % Itera sobre cada hangar y crea la matriz correspondiente
    for i = 1:length(hangares)
        % Crea la matriz con numAviones filas y 3 columnas
        matriz_aviones = zeros(numAviones, 4);

        % Posición inicial del avión
        matriz_aviones(:, 3) = hangares(i); 

        % Nodo en el que se encuentra el hangar
        matriz_aviones(:, 4) = hangares(i); 

        % Asigna la matriz a la estructura de aviones con el nombre adecuado
        aviones.(['hangar' num2str(hangares(i))]) = matriz_aviones;
    end
end
