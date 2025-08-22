function costeRuta = calcularCosteRuta(ruta, datos, costeRuta)
    tiempoVuelo = 0;
    numTotalVuelos = length(ruta.origen);
    
    % Calcula el tiempo total que se ha volado
    for nVuelo = 1:numTotalVuelos
        tiempoVuelo = tiempoVuelo + datos.distancias(ruta.origen(nVuelo), ruta.destino(nVuelo));
    end
    
    costeVuelos = tiempoVuelo * datos.costePorHora; % Coste de todos los vuelos
    costeEscalas = (numTotalVuelos) * datos.costeEscala; % Coste de todas las escalas

    costeRuta = costeRuta + costeVuelos + costeEscalas; % Coste total de entregar todas las cargas
end