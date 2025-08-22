clc;
clear;
close all;
%% Datos

% Cargamos los datos del problema y los almacenamos en el struct datos
    % datos = inicializarDatos(); % Datos de problema "real"
    % save('datos.mat', 'datos'); % Guardamos el struct datos para reutilizarlo
  load ('datos.mat'); % Usa el struct datos ya almacenado

% Genera struct aviones que contiene todos los aviones // tiempo - carga - posicion - Hangar
aviones = generarAviones(datos.hangares, datos.numAviones);

% Carga total inicial a repartir
cargaRestante = sum(datos.cargas(:));   % Volumen (peso) de carga a repartir
nCargas = sum(datos.cargas(:) ~= 0);    % Numero de cargas a repartir

nHangares = length(datos.hangares);     % Numero de hangares

% Inicializa eta tau alfa y beta con valor unitario para que todas las P
% sean iguales y q0 = 0 para tener probabilidad en todas las cargas viables
parametros = inicializarParametrosS0(datos.distancias, nHangares);

% Generamos una solución objetivo inicial (los ~ son para ignorar esos output)
[s0, OBJ_s0, avionesS0, ~, ~, M] = generarSolucion(cargaRestante, datos, aviones, parametros);

% Almacenamos estos datos como mejor solución actual
MejorSol.OBJ_smg = OBJ_s0;
MejorSol.smg = s0;
MejorSol.M = M;

%% Parámetros de ACO

MaxIt = 500;      % Número Máximo de Iteraciones

nHormigas = 20;        % Número de Hormigas

parametros.tau0 = 1 / ((nCargas + nHangares) * OBJ_s0);	% Feromona Inicial

parametros.alfa = 1;        % Peso Exponencial de Feromona
parametros.beta = 1;        % Peso Exponencial Heurístico

parametros.q0 = 0.3;        % Parametro de pseudoaleatoriedad entre 0 y 1

parametros.rho_local = 0.025;      % Tasa de Evaporación local (tras cada hormiga)
parametros.rho_global = 0.05;      % Tasa de Evaporación global (tras cada iteración)

%% Inicialización

% La matriz de información heuristica no seria necesario recalcularla ya
% que ya se calculó para generar la solución inicial, pero va a volver a
% calcularse por si no se prestó atención a inicializarParametrosS0
[m, n] = size(datos.distancias); % Dimensiones de la matriz de distancias

% Matriz de Información Heurística para selección de cargas y hangares
% Las primeras filas y columnas hacen referencia a las cargas y las
% ultimas a la selección de hangares
parametros.eta = ones(m + nHangares, n + nHangares);
parametros.eta(1:m, 1:n) = 1 ./ datos.distancias;   % Actualiza las celdas correspondientes a la distancia
parametros.eta(isinf(parametros.eta)) = 1;   % Hace 1 los valores de eta = infinito (diagonal asociada a distancias)

% Inicializa matriz tau con valor tau0 para todos los casos (tau tiene las mismas dimensiones que eta)
parametros.tau = parametros.tau0 * ones(size(parametros.eta));        % Tau de selección de carga

MejorOBJ = zeros(MaxIt, 1);    % Vector para Almacenar los Mejores Costos

% Hormiga Vacía
hormigaVacia.smg = [];
hormigaVacia.OBJ_smg = [];

% Matriz de la Colonia de Hormigas
hormiga = repmat(hormigaVacia, nHormigas, 1);

%% Bucle Principal de ACO

for it = 1:MaxIt
    % Mover las Hormigas
    for k = 1:nHormigas

        [hormiga(k).smg, hormiga(k).OBJ_smg, hormiga(k).aviones, ...
            hormiga(k).decisiones, hormiga(k).contadorHangares, hormiga(k).M] ...
        = generarSolucion(cargaRestante, datos, aviones, parametros);

        parametros.tau = actualizarFeromonasLocal(hormiga, parametros);
        
        if hormiga(k).OBJ_smg < MejorSol.OBJ_smg
            MejorSol = hormiga(k);
        end

    end

    % Muestra si en la iteración no se ha encontrado solución viable
    if MejorSol.M == 1
        fprintf('Iteración %d: M\n', it);
    end


    % Actualización global de Feromona
    parametros.tau = actualizarFeromonasGlobal(MejorSol, parametros);

    % Almacena el Mejor Costo
    MejorOBJ(it) = MejorSol.OBJ_smg;

    % Mostrar Información de la Iteración
    disp(['Iteración ' num2str(it) ': Mejor OBJ = ' num2str(MejorOBJ(it))]);
end

if MejorSol.M ~= 1
    fprintf('Coste: %d\n', MejorSol.OBJ_smg);
else
    disp('Coste: M');
end

% Guardamos la solución
save('Solucion.mat', 'MejorSol');

% Plotea el OBJ respecto de las iteraciones
figure;
plot(MejorOBJ, 'LineWidth', 2);
xlabel('Iteración');
ylabel('Mejor Costo');
grid on;

% Grafica el movimiento de los aviones
graficarSolucion(table2array(datos.Coordenadas(:,[2,3])), MejorSol.smg);