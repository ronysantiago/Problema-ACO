function clasificacion = ClasificaCiudades(habitantes)
    % Clasifica las ciudades en Grandes, Medianas y Pequeñas, nos devuelve
    % un vector columna con el orden que se le introdujeron.
    
    % Lee el numero de ciudades grandes y pequeñas
    NumGran = table2array(readtable('Datos.xlsx',Sheet='Ciudades',Range='H2:H2'));
    NumPeq = table2array(readtable('Datos.xlsx',Sheet='Ciudades',Range='J2:J2'));
    
    % Ordena el vector de habitantes de forma descendente
    [~, indices] = sortrows(habitantes, 'Habitantes', 'descend');
    
    % Inicializa el vector de clasificación
    clasificacion = cell(size(habitantes));
    
    % Asigna 'Grande' a las NumGran ciudades con más habitantes
    clasificacion(indices(1:NumGran)) = {'Grande'};
    
    % Asigna 'Pequeña' a las NumPeq ciudades con menos habitantes
    clasificacion(indices(end-(NumPeq-1):end)) = {'Pequeña'};
    
    % Asigna 'Mediana' al resto de las ciudades
    clasificacion(cellfun('isempty', clasificacion)) = {'Mediana'};
    
    % Convierte el vector de celdas a un vector de columnas
    clasificacion = categorical(clasificacion);
end
