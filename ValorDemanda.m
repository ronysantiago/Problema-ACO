function demanda_actualizada = ValorDemanda(demanda, tipo_ciudad)
    % Lee los valores de las probabilidades y de las cantidades de demanda
    % y los almacena
    probabilidades = table2array(readtable('Datos.xlsx',Sheet='Ciudades',Range='H6:J8'));
    matriz_cantidades = table2array(readtable('Datos.xlsx',Sheet='Ciudades',Range='H12:J14'));

    % Inicializa el vector de demanda actualizada
    demanda_actualizada = zeros(size(demanda, 1), 1);

    for i = 1:size(demanda, 1)
        % Si hay demanda en esta ciudad
        if demanda(i) == 1
            % Obtener las probabilidades asociadas al tipo de ciudad desde la matriz
            switch tipo_ciudad(i)
                case 'Grande'
                    probabilidades_tipo = probabilidades(:, 1);
                    tipo = 1;
                case 'Mediana'
                    probabilidades_tipo = probabilidades(:, 2);
                    tipo = 2;
                case 'Pequeña'
                    probabilidades_tipo = probabilidades(:, 3);
                    tipo = 3;
                otherwise
                    error('Tipo de ciudad no reconocido');
            end
            
            eleccion = tirarDados(probabilidades_tipo);
            % Utilizar la función SeleccionRuleta para determinar la cantidad de demanda

            demanda_actualizada(i) = matriz_cantidades(eleccion, tipo);
        end
    end
end
