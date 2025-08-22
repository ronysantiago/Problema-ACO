function graficarSolucion(nodos, aviones)

    % Encontrar el tiempo máximo de destino
    tiempoMaximo = max(cellfun(@(x) x(end), {aviones.tiempoDestino}));
    
    % Inicializar la figura
    figura = figure;
    axis equal;
    grid on;
    xlabel('Eje X');
    ylabel('Eje Y');
    title('Movimiento de los Aviones');
    
    hold on;
    
    % Dibujar los nodos con etiqueta 'Ciudades'
    plot(nodos(:, 1), nodos(:, 2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Ciudades');
    
    % Agregar números de nodo encima de cada ciudad
    for i = 1:size(nodos, 1)
        text(nodos(i, 1), nodos(i, 2), num2str(i), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    
    % Inicializar los aviones en sus nodos iniciales
    avionesObjetos = gobjects(1, numel(aviones));
    
    for a = 1:numel(aviones)
        if a == 1
            % Solo establecer el 'DisplayName' para el primer avión
            avionesObjetos(a) = scatter(nodos(aviones(a).origen(1), 1), nodos(aviones(a).origen(1), 2), 100, 'b', 'filled', 'DisplayName', 'Aviones');
        else
            avionesObjetos(a) = scatter(nodos(aviones(a).origen(1), 1), nodos(aviones(a).origen(1), 2), 100, 'b', 'filled', 'HandleVisibility', 'off');
        end
    end
    
    % Guardar los objetos avión como propiedad de la figura
    set(figura, 'UserData', struct('aviones', avionesObjetos));
    
    % Agregar la leyenda una vez antes de entrar al bucle
    legend('show');
    lgd = findobj(gcf, 'Type', 'legend');
    lgd.FontSize = 14;
    lgd.Title.String = sprintf('Tiempo: %.1f', 0); % Establecer el tiempo inicial
    
    % Bucle para animar el movimiento de los aviones
    for tiempo = 0:0.1:tiempoMaximo
        % Actualizar la posición de los aviones en función del tiempo
        for a = 1:numel(aviones)
            tiempoAvion = tiempo;
            if tiempoAvion >= aviones(a).tiempoOrigen(1) && tiempoAvion <= aviones(a).tiempoDestino(end)
                for tramo = 1:numel(aviones(a).origen)
                    if tiempoAvion >= aviones(a).tiempoOrigen(tramo) && tiempoAvion <= aviones(a).tiempoDestino(tramo)
                        alpha = (tiempoAvion - aviones(a).tiempoOrigen(tramo)) / (aviones(a).tiempoDestino(tramo) - aviones(a).tiempoOrigen(tramo));
                        posicionAvion = nodos(aviones(a).origen(tramo), :) + (nodos(aviones(a).destino(tramo), :) - nodos(aviones(a).origen(tramo), :)) * alpha;
                        % Actualizar la posición del avión en la figura
                        datosFigura = get(figura, 'UserData');
                        set(datosFigura.aviones(a), 'XData', posicionAvion(1), 'YData', posicionAvion(2));
                        break;
                    end
                end
            end
        end
        
        % Actualizar la leyenda con el valor de tiempo
        lgd.Title.String = sprintf('Tiempo: %.1f', tiempo);
    
        % Pausa para la animación
        pause(0.1);
    end
end
