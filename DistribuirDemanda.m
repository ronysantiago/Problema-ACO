function matriz_oferta = DistribuirDemanda(demanda, oferta, cargaMax)
    % Función que genera una matriz de modo que la demanda de una ciudad se
    % vea cubierta por la oferta del resto.
    % Lee un vector columna demanda que contiene la demanda de
    % cada ciudad. El vector columna oferta contiene si la ciudad puede
    % ofertar o no.

    % Verifica que los vectores tengan la misma longitud
    if length(demanda) ~= length(oferta)
        error('Los vectores de demanda y oferta deben tener la misma longitud.');
    end

    % Numero de ciudades
    num_ciudades = length(demanda);

    % Inicializa matriz cuadrada con componentes nulas
    matriz_oferta = zeros(num_ciudades);

    % La demanda se cubre en paquetes de este valor
    paquete = table2array(readtable('Datos.xlsx',Sheet='Ciudades',Range='J16:J16'));

    for i = 1:num_ciudades
        % Mientras la demanda de la ciudad sea mayor que 0
        while demanda(i) > 0
            % Encuentra las ciudades que pueden ofertar (excluyendo la ciudad actual)
            ciudades_ofertantes = find(oferta == 1 & (1:num_ciudades)' ~= i);

            % Selecciona aleatoriamente una ciudad que pueda ofertar
            ciudad_ofertante = ciudades_ofertantes(randi(length(ciudades_ofertantes)));

            % Determina la cantidad a asignar (como máximo será el valor de paquete y 
            % como mínimo si no se llena paquete)
            cantidad_a_asignar = min(paquete, demanda(i));

            % Verifica si la cantidad a asignar no excede cargaMax, ya que
            % en nuestro programa no dejamos que el avión coja cargas
            % superiores a las que puede cargar
            if matriz_oferta(ciudad_ofertante, i) + cantidad_a_asignar > cargaMax
                % Si excede cargaMax, ajusta la cantidad a asignar
                cantidad_a_asignar = cargaMax - matriz_oferta(ciudad_ofertante, i);
            end

            % Asigna la cantidad a la matriz de oferta
            matriz_oferta(ciudad_ofertante, i) = matriz_oferta(ciudad_ofertante, i) + cantidad_a_asignar;

            % Reducir la demanda en la ciudad actual
            demanda(i) = demanda(i) - cantidad_a_asignar;
            
        end % Cierra while
    end % Cierra for
end
