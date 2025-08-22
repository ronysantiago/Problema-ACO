function [oferta, demanda] = Clasifica_OfertaDemanda(tipo_ciudad)
    % Función que lee de qué tipo es cada ciudad y les asigna si ofertan,
    % demandan u ofertan+demandan
    % Devuelve dos vectores booleanos

    % Lee los valores de las probabilidades y los almacena
    probabilidades = table2array(readtable('Datos.xlsx',Sheet='Ciudades',Range='H6:J8'));

    % Inicializa vectores de oferta y demanda en 0
    oferta = zeros(size(tipo_ciudad, 1), 1);
    demanda = zeros(size(tipo_ciudad, 1), 1);

    for i = 1:size(tipo_ciudad, 1)
        % Tipo de ciudad actual
        tipo_actual = tipo_ciudad(i);

        % Probabilidades asociadas al tipo de ciudad desde la matriz
        switch tipo_actual
            case 'Grande'
                probabilidades_tipo = probabilidades(:, 1);
            case 'Mediana'
                probabilidades_tipo = probabilidades(:, 2);
            case 'Pequeña'
                probabilidades_tipo = probabilidades(:, 3);
            otherwise
                error('Tipo de ciudad no reconocido');
        end

        % Determina si es oferta, demanda u oferta+demanda
        eleccion = tirarDados(probabilidades_tipo);

        % Asigna 1 a oferta si es Oferta u Oferta+Demanda
        oferta(i) = eleccion == 1 || eleccion == 3;

        % Asigna 1 a demanda si es Demanda u Oferta+Demanda
        demanda(i) = eleccion == 2 || eleccion == 3;
    end
end
