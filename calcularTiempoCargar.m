function tiempoCargar = calcularTiempoCargar(origen, avion, datos)
    % Tiempo que cuesta ir a cargar y realizar la escala

    if avion(3) == origen
        % Si ya está en el nodo no le cuesta tiempo coger la carga
        tiempoCargar = 0;
    else
        % Si se mueve a otro nodo le cuesta moverse a ese nodo y hacer escala
        tiempoCargar = datos.distancias(avion(3), origen) + datos.tiempoEscala;
    end
    
end