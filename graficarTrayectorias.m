function graficarTrayectorias(datos, MejorSol, it)
    % Crear o actualizar la Figura 1
    figure(1);
    clf;  % Limpiar la figura

    % Graficar las coordenadas de las ciudades
    scatter(datos.Coordenadas(:,3), datos.Coordenadas(:,2), 'filled');
    hold on;

    % Convertir números a cadenas para el texto
    ciudades = cellstr(num2str(datos.Coordenadas(:,1)));
    
    % Usar cadenas de caracteres para el texto
    text(datos.Coordenadas(:,3), datos.Coordenadas(:,2), ciudades, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

    % Obtener el número total de trayectorias
    numTrayectorias = size(MejorSol.trayectorias, 2);

    % Colores para las trayectorias
    colores = lines(numTrayectorias);

    % Crear o actualizar las líneas de las trayectorias
    for i = 1:numTrayectorias
        nodos = MejorSol.trayectorias{1, i};
        
        % Asegurarse de que los nodos están en un rango válido
        nodos = nodos(nodos <= size(datos.Coordenadas, 1));
        
        % Obtener las coordenadas de los nodos
        X = datos.Coordenadas(nodos, 3);
        Y = datos.Coordenadas(nodos, 2);
        
        % Plotear la trayectoria con líneas
        plot(X, Y, 'Color', colores(i,:), 'LineWidth', 3);
    end

    % Ajustar los límites de los ejes para mostrar todos los números de nodos
    margen = 10;
    xlim([min(datos.Coordenadas(:,3))-margen, max(datos.Coordenadas(:,3))+margen]);
    ylim([min(datos.Coordenadas(:,2))-margen, max(datos.Coordenadas(:,2))+margen]);

    % Actualizar la leyenda si es necesario
    %legend('Ubicación de las Ciudades', 'Trayectorias');

    % Mostrar las coordenadas como ejes XY (opcional)
    axis equal;

    % Actualizar el título si es necesario
    title(['Coordenadas de las Ciudades y Trayectorias - Iteración ' num2str(it)]);

    % Pausa para ver la gráfica antes de continuar con la siguiente iteración
    pause(0.01);
end
