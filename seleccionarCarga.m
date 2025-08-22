function cargaAlmacenada = seleccionarCarga(posicion, parametros, cargasViables, cargaAlmacenada)
    % Revisamos que q0 esté entre 0 y 1
    if parametros.q0 < 0 || parametros.q0 > 1
        error('Error: Modifica q0 para que tenga un valor entre 0 y 1');
    end

    q = rand; % Aleatorio entre 0 y 1

    % Si q es menor o igual que q0
    if q <= parametros.q0
        numCargaSeleccionada = seleccionaArgMaximo(posicion, parametros.tau, parametros.eta, parametros.alfa, parametros.beta, cargasViables);
    
    % Si q es mayor que q0
    else
        P = calcularProbabilidad(posicion, parametros.tau, parametros.eta, parametros.alfa, parametros.beta, cargasViables);
        numCargaSeleccionada = tirarDados(P);
    end

    cargaAlmacenada = [cargaAlmacenada; cargasViables(numCargaSeleccionada, :)];
end
