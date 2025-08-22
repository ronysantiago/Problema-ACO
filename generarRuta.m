function [datos, cargaRestante, ruta, avion, costeRuta, saleAvion, decisiones] = ...
    generarRuta(avion, datos, cargaRestante, parametros, decisiones)
    % Struct que contendrá todos los pasos que da el avión
    ruta = inicializarRuta();
    cargaAlmacenada = [];
    costeRuta = datos.costeActivacion; % Coste por activación del avión
    saleAvion = true;

    % Buscamos si hay cargas viables
    cargasViables = encontrarCargasViables(avion, datos, ruta, cargaAlmacenada);

    if isempty(cargasViables)
        eliminaHangar = find(datos.hangares == avion(4));
        datos.hangares(eliminaHangar) = [];
        saleAvion = false;
    end

    % Mientras haya cargas viables
    while ~isempty(cargasViables)
        % Selecciona carga viable y la almacena   [...; origen  destino  carga  tiempoTotal]
        cargaAlmacenada = seleccionarCarga(avion(3), parametros, cargasViables, cargaAlmacenada);
        datos.cargas(cargaAlmacenada(end,1),cargaAlmacenada(end,2)) = ...
            datos.cargas(cargaAlmacenada(end,1),cargaAlmacenada(end,2)) - cargaAlmacenada(end,3);
        cargaRestante = cargaRestante - cargaAlmacenada(end,3); % Quita carga restante
        avion(2) = avion(2) + cargaAlmacenada(end,3);   % Suma la carga al avión

        % Actualiza la ruta, propiedades del avión y cargaAlmacenada (esto ultimo solo si ha descargado)
        [ruta, avion, cargaAlmacenada, decisiones] = ...
            actualizarRuta(ruta, avion, cargaAlmacenada, datos, decisiones);

        % Buscamos más cargas viables
        cargasViables = encontrarCargasViables(avion, datos, ruta, cargaAlmacenada); 

    end % No hay más cargas viables

    % Mientras haya carga almacenada
    while ~isempty(cargaAlmacenada)
        % Entrega la carga y actualiza la ruta // Funciona similar a actualizarRuta pero más simple
        [ruta, avion, cargaAlmacenada] = entregarCargas(ruta, avion, cargaAlmacenada, datos);
    end

    % Calcula el coste de entregar todas las cargas
    if ~isempty(ruta.origen)
        costeRuta = calcularCosteRuta(ruta, datos, costeRuta);
    end

    % Si el avión no ha terminado en su Hangar
    if avion(3) ~= avion(4)
        ruta.origen(end+1) = avion(3);  % Origen -> Posición del avión
        ruta.destino(end+1) = avion(4); % Destino -> Hangar inicial
        ruta.tiempoOrigen(end+1) = avion(1);   % Hora de despegue
        ruta.tiempoDestino(end+1) = ...
            ruta.tiempoOrigen(end) + datos.distancias(avion(3),avion(4));  % Hora de aterrizaje
        ruta.carga{end+1} = [];
        ruta.descarga{end+1} = [];

        avion(1) = ruta.tiempoDestino(end);   % Actualiza el tiempo final del avión
        avion(3) = ruta.destino(end);    % Mueve el avión al Hangar inicial

        % Añadimos el coste del vuelo en vacío al Hangar
        costeRuta = costeRuta + datos.distancias(ruta.origen(end), ruta.destino(end)) * datos.costePorHora;
    end
end