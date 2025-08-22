function datos = inicializarDatos()
% Carga de datos e introducción de variables

coordenadas = readtable('Datos.xlsx',Sheet='Ciudades',Range='C:D');
ciudades = readtable('Datos.xlsx',Sheet='Ciudades',Range='A:A');
datos.Coordenadas = [ciudades coordenadas];% Matriz [ciudad latitudY LongitudX]
datos.Habitantes = readtable('Datos.xlsx',Sheet='Ciudades',Range='E:E');% VectCol Num. habitantes por ciudad

% Datos de avión
datos.cargaMax = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='C2:C2'));    % Carga máxima que soporta cada avión - ton
datos.velocidad = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='D2:D2'));   % Velocidad del avión - km/h
datos.costePorHora = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='G15:G15'));   % Coste de volar - €/h
datos.tiempoEscala = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='G2:G2'));     % Tiempo de escala - h
datos.costeEscala = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='G3:G3'));     % Coste de escala - €
datos.costeActivacion = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='G6:G6'));   % Coste activación - €
datos.tiempoMax = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='G9:G9'));       % Tiempo límite - h

% Calcula matriz de distancias (en horas)
datos.distancias = CalculaDistancias(datos.Coordenadas, datos.velocidad);

% Hangares
datos.hangares = table2array(readtable('Datos.xlsx', 'Sheet', 'Aviones', 'Range', 'I:I'));  % Nodo en el que se encuentran los aviones
datos.hangares = rmmissing(datos.hangares);     % Eliminar filas con valores NaN
datos.numAviones = table2array(readtable('Datos.xlsx',Sheet='Aviones',Range='G12:G12'));  % Numero de aviones en cada hangar

% Generación de cargas a distribuir
datos.tipoCiudad = ClasificaCiudades(datos.Habitantes);
[bool_oferta, bool_demanda] = Clasifica_OfertaDemanda(datos.tipoCiudad);
demanda = ValorDemanda(bool_demanda, datos.tipoCiudad);
datos.cargas = DistribuirDemanda(demanda, bool_oferta, datos.cargaMax); % Matriz de cargas en toneladas
end