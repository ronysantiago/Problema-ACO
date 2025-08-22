function tau = actualizarFeromonasGlobal(MejorSol, parametros)
% Actualiza la feromona basándose en la información de la mejor solución

    % Feromona de selección de carga
    numDecisiones = length(MejorSol.decisiones); % Tiene que ser lo mismo que el numero de cargas

    for decision = 1:numDecisiones
        origen = MejorSol.decisiones(decision,1);
        destino = MejorSol.decisiones(decision,2);

        % Actualizamos feromona
        parametros.tau(origen, destino) = ...
            parametros.tau(origen, destino) * (1 - parametros.rho_global)+ ...
            parametros.rho_global / MejorSol.OBJ_smg;
        
    end

    % Feromona de selección de Hangar
    nHangares = length(MejorSol.contadorHangares); % Tiene que ser lo mismo que el numero de cargas
    limite = size(parametros.tau,1) - nHangares; % Igual que en la función seleccionarHangar

    for hangar = 1:nHangares
        % Para evitar hacer otro bucle donde se actualice la feromona  cada vez que el hangar 
        % sea seleccionado. Se ha simplificado a: tau = tau * (1 - rho) ^ n
        % Donde n es el numero de veces que el hangar ha sido seleccionado
        i = limite + hangar;
        parametros.tau(i, i) = ...
            parametros.tau(i, i) * (1 - parametros.rho_local)+ ...
            parametros.rho_global / MejorSol.OBJ_smg;

    end
    
    % Almacenamos tau final
    tau = parametros.tau;
end
