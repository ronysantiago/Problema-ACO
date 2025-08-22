function parametros = inicializarParametrosS0(distancias, nHangares)
% Inicializa con valor 1 los parametros que influyen en la elección de una
% carga para generar así una solución inicial completamente aleatoria

    [m, n] = size(distancias); % Dimensiones de la matriz de distancias

    % Crea la matriz cuadrada eta con dimensiones (numCiudades + nHangares) x (numCiudades + nHangares) 
    parametros.eta = ones(m + nHangares, n + nHangares);
    parametros.eta(1:m, 1:n) = 1 ./ distancias;   % Actualiza las celdas correspondientes a la distancia
    parametros.eta(isinf(parametros.eta)) = 1;          % Hace 1 los valores de eta = infinito (Diagonal principal)

    % Crea la matriz cuadrada tau con las mismas dimensiones que eta
    parametros.tau = ones(size(parametros.eta));

    % Parámetros independientes
    parametros.alfa = 1;
    parametros.beta = 1;
    parametros.q0 = 0;      % De esta forma forzamos que todas las decisiones de s0 sean aleatorias (probabilidades)
end