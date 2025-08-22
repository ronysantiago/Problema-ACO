function [MatrizDistancias] = CalculaDistancias(MatrizCoordenadas, velocidad)
    % Introducimos una matriz que contenga las coordenadas de las ciudades
    % Estructura de la matriz: Ciudad Latitud Longitud
    % Calcula la distancia entre todas las ciudades (diagonal principal es siempre 0)
    
    % Obtenemos el número de ciudades
    numCiudades = size(MatrizCoordenadas, 1);
    
    % Inicializamos la matriz de distancias
    MatrizDistancias = zeros(numCiudades);

    for i = 1:numCiudades
        for j = i+1:numCiudades % Solo necesitamos recorrer la mitad superior de la matriz
            % Fórmula de la distancia haversine
            distanciaKilometros = haversine(MatrizCoordenadas{i,2}, MatrizCoordenadas{i,3}, ...
                MatrizCoordenadas{j,2}, MatrizCoordenadas{j,3});

            % Conversión a horas
            distanciaHoras = distanciaKilometros / velocidad;

            % La matriz es simétrica
            MatrizDistancias(i, j) = distanciaHoras;
            MatrizDistancias(j, i) = distanciaHoras;
        end
    end
end
