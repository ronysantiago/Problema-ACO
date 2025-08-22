function datos = inicializarDatosSimple()
    datos.cargaMax = 10;           % Carga máxima que soporta cada avión
    datos.tiempoEscala = 2;     % Tiempo de escala
    datos.tiempoMax = 15;       % Tiempo límite
    datos.costeActivacion = 10;   % Coste activación
% Lo que me faltaba por añadir
    datos.costePorHora = 1;
    datos.velocidad = 100;
    datos.costeEscala = 10;
    
                        
    datos.hangares = [1; 6];       % Nodo en el que se encuentran los aviones
    datos.numAviones = 40;        % Numero de aviones en cada hangar 
    
    % Coordenadas de los aeropuertos
    %          1   2   3   4   5   6   7   8   9
    x = [000 250 350 250 250 000 100 000 000];
    y = [250 300 250 150 350 350 250 100 000];
    datos.Coordenadas = [transpose(1:length(x)), transpose(y)/datos.velocidad, transpose(x)/datos.velocidad];
    
    % Matriz de cargas // filas origen - destino columnas
    % datos.cargas =   [0 2.5 0 0 0 0 0 2.5 0;
    %             0 0 0 0 0 0 0 0 0;
    %             0 0 0 2.5 0 0 0 0 0;
    %             0 0 0 0 0 0 0 2.5 0;
    %             0 0 0 2.5 0 2.5 0 2.5 0; % 5
    %             0 0 0 0 0 0 0 0 0;
    %             0 0 0 0 0 2.5 0 0 0;
    %             0 0 0 0 0 0 0 0 0;
    %             0 0 0 0 0 0 0 2.5 0];
    datos.cargas = 2.5 * ones(9); % Llena la matriz con 2.5 en todos los elementos
    datos.cargas(1:10:end) = 0;   % Establece los elementos de la diagonal principal a 0
    datos.cargasIniciales = datos.cargas;
    
    % Calcula distancias
    datos.distancias = calcular_distancias(datos.Coordenadas(:,3), datos.Coordenadas(:,2));
end