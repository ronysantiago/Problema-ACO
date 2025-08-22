function [tiempoDescargarTodas, posicionAvion] = calcularTiempoDescargarTodas(origen, destino, datos, cargaAlmacenada)
    % Sumamos el tiempo que cuesta llevar la ultima carga cogida
    tiempoDescargarTodas = datos.distancias(origen, destino) + datos.tiempoEscala;

    % El avión se encuentra en el destino de la ultima carga
    posicionAvion = destino;

    % Si el avión tiene cargas para este nodo
    if ~isempty(cargaAlmacenada) && cargaAlmacenada(end, 2) == destino
        % Miramos si hay cargas
        cargasEntregadas = cargaAlmacenada(:, 2) == destino;
        % Las eliminamos de la matriz
        cargaAlmacenada(cargasEntregadas, :) = [];
    end
    
    % Mientras el avión tenga cargas que repartir
    while ~isempty(cargaAlmacenada)
        % Destino de la siguiente carga
        destinoCarga = cargaAlmacenada(end, 2);
        
        % Suma el tiempo correspondiente a entregar la carga y hacer escala
        tiempoDescargarTodas = tiempoDescargarTodas + datos.distancias(posicionAvion, destinoCarga) + datos.tiempoEscala;

        % Mueve el avión al destino de dicha carga
        posicionAvion = destinoCarga;

        % Encuentra filas con destino igual al de esa carga y las elimina
        cargasEntregadas = cargaAlmacenada(:, 2) == destinoCarga;
        cargaAlmacenada(cargasEntregadas, :) = [];
    end
end