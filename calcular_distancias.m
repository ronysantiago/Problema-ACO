function distancia_matriz = calcular_distancias(x, y)
    % Verificar si los vectores de entrada tienen la misma longitud
    if length(x) ~= length(y)
        error('Los vectores de coordenadas deben tener la misma longitud.');
    end

    % Obtener el número de nodos
    num_nodos = length(x);

    % Inicializar la matriz de distancias con ceros
    distancia_matriz = zeros(num_nodos);

    % Calcular las distancias entre todos los nodos
    for i = 1:num_nodos
        for j = i+1:num_nodos
            % Calcular la distancia euclidiana entre los nodos i y j
            distancia = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);

            % Asignar la distancia a la matriz (simétrica)
            distancia_matriz(i, j) = distancia;
            distancia_matriz(j, i) = distancia;
        end
    end
end
