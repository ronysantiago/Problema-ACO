function [ruta, costeTotal, aviones, decisiones, contadorHangares, M] = ...
    generarSolucion(cargaRestante, datos, aviones, parametros)
% antes tenia de output [datos, aviones, trayectorias, coste, solucion]
    coste = [];
    numVuelo = 1;
    decisiones = []; % Almacena donde ha decicido ir el avión a cargar
    contadorHangares = zeros(1, size(datos.hangares,1)); % Cuenta el numero de veces que sale cada hangar
    M = 0;  % Si M == 1, indica que no se ha alcanzado solucion

    % Mientras haya carga que repartir, generará ruta de un avión
    while cargaRestante > 0
        nHangaresDisponibles = length(datos.hangares);
        if nHangaresDisponibles == 0
            % Indicamos que no se ha alcanzado solución
            M = 1;
            costeTotal = inf;
            break;
        end
        % Seleccionar hangar de forma aleatoria y almacenarlo como flotaAviones
        [numHangar, contadorHangares] = seleccionarHangar(datos.hangares, ...
            parametros.tau, parametros.eta, parametros.alfa, parametros.beta, contadorHangares);

        flotaAviones = aviones.(['hangar' num2str(numHangar)]);
    
        % Seleccionamos un avión disponible de la flota
        numAvion = find(flotaAviones(:, 1) == 0, 1);

        if isempty(numAvion)
            eliminaHangar = find(datos.hangares == numHangar);
            datos.hangares(eliminaHangar) = [];
        else
            % Genera la ruta del avión
            [datos, cargaRestante, ruta(numVuelo), flotaAviones(numAvion,:), ...
                coste(numVuelo), saleAvion, decisiones] = generarRuta(flotaAviones(numAvion,:), ...
                datos, cargaRestante, parametros, decisiones);
            
            % Si el avión ha salido, almacena los datos, en caso de no
            % entrar en el if, numVuelo no aumenta y se sobreescriben los datos
            if saleAvion == true
                % Almacenamos los datos
                aviones.(['hangar' num2str(numHangar)]) = flotaAviones;
                costeTotal = sum(coste);
                numVuelo = numVuelo + 1;
            end
        end % Cierra condicional de chequeo de si hay avión

    end % Cierra while
        
end