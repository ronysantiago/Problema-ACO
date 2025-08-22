% Función de callback para actualizar la posición de los aviones con el slider
function actualizarPosicion(slider, nodos, aviones, figura, tiempoMaximo)
    valorSlider = get(slider, 'Value');
    datosFigura = get(figura, 'UserData');
    
    % Ajustar para manejar posibles problemas de precisión o redondeo
    tiempo = max(0, min(tiempoMaximo, valorSlider));
    
    % Actualizar la posición de los aviones en función del valor del slider
    for a = 1:numel(aviones)
        tiempoAvion = tiempo;
        if tiempoAvion >= aviones(a).tiempoOrigen(1) && tiempoAvion <= aviones(a).tiempoDestino(end)
            for tramo = 1:numel(aviones(a).origen)
                if tiempoAvion >= aviones(a).tiempoOrigen(tramo) && tiempoAvion <= aviones(a).tiempoDestino(tramo)
                    alpha = (tiempoAvion - aviones(a).tiempoOrigen(tramo)) / (aviones(a).tiempoDestino(tramo) - aviones(a).tiempoOrigen(tramo));
                    posicionAvion = nodos(aviones(a).origen(tramo), :) + alpha * (nodos(aviones(a).destino(tramo), :) - nodos(aviones(a).origen(tramo), :));
                    % Actualizar la posición del avión en la figura
                    set(datosFigura.aviones(a), 'XData', [posicionAvion(1) - 0.05, posicionAvion(1) + 0.05, posicionAvion(1)], 'YData', [posicionAvion(2) - 0.05, posicionAvion(2) - 0.05, posicionAvion(2) + 0.05]);
                    break;
                end
            end
        end
    end
    
    % Actualizar la leyenda con el valor de tiempo
    lgd = legend('show');
    lgd.FontSize = 14;
    lgd.Title.String = sprintf('Tiempo: %.1f', tiempo);
end
