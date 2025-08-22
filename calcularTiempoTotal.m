function tiempoTotalRuta = calcularTiempoTotal(origen, destino, avion, datos, ruta, cargaAlmacenada)
    % Tiempo que lleva el avión antes de meter otra carga nueva
    tiempoOrigen = calcularTiempoOrigen(ruta, avion, datos);
    
    % Tiempo que le cuesta meter la carga en el avión
    tiempoCargar = calcularTiempoCargar(origen, avion, datos);
    
    % Tiempo que le cuesta al avión repartir todas las cargas que lleva y
    % posición del avión cuando termina de repartir
    [tiempoDescargarTodas, avion(3)] = calcularTiempoDescargarTodas(origen, destino, datos, cargaAlmacenada);

    % Tiempo que le cuesta al avión volver al hangar inicial
    tiempoVueltaHangar = datos.distancias(avion(3), avion(4));
    
    % Coste total de la ruta del avión tras introducir la carga nueva
    tiempoTotalRuta = tiempoOrigen + tiempoCargar + tiempoDescargarTodas + tiempoVueltaHangar;
end