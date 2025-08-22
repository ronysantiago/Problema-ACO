function tau = actualizarFeromonasLocal(hormigas, parametros)
    % Actualiza la feromona basándose en la información de las hormigas

    nHormigas = length(hormigas);

    % Actualizar Feromonas
    for k = 1:nHormigas
        
        % Feromona de selección de carga
        numDecisiones = length(hormigas(k).decisiones); % Tiene que ser lo mismo que el numero de cargas

        for decision = 1:numDecisiones
            origen = hormigas(k).decisiones(decision,1);
            destino = hormigas(k).decisiones(decision,2);

            % Actualizamos feromona
            parametros.tau(origen, destino) = ...
                parametros.tau(origen, destino) * (1 - parametros.rho_local);
            
        end

        % Feromona de selección de Hangar
        nHangares = length(hormigas(k).contadorHangares); % Tiene que ser lo mismo que el numero de cargas
        limite = size(parametros.tau,1) - nHangares; % Igual que en la función seleccionarHangar

        for hangar = 1:nHangares
            % Para evitar hacer otro bucle donde se actualice la feromona  cada vez que el hangar 
            % sea seleccionado. Se ha simplificado a: tau = tau * (1 - rho) ^ n
            % Donde n es el numero de veces que el hangar ha sido seleccionado
            i = limite + hangar;
            parametros.tau(i, i) = ...
                parametros.tau(i, i) * (1 - parametros.rho_local);

        end

    end
    % Almacenamos tau final
    tau = parametros.tau;
end
