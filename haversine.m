function distancia = haversine(lat1, lon1, lat2, lon2)
    %Función que calcula la distancia haversine entre dos puntos geográficos
    %cuyas coordenadas están en grados

    R = 6371; %Radio medio de la Tierra en kilómetros

    %Convertimos latitudes y longitudes en radianes
    lat1 = deg2rad(lat1);
    lon1 = deg2rad(lon1);
    lat2 = deg2rad(lat2);
    lon2 = deg2rad(lon2);

    %Fórmula haversine
    hav_theta = sin( (lat2 - lat1) / 2)^2 + cos(lat1) * cos(lat2) * sin( (lon2 - lon1) / 2)^2;
        %Siendo hav_theta la función haversina del angulo que forman ambas coordenadas
    
    theta = asin(sqrt(hav_theta))*2; %Ángulo en radianes
        %Viene de despejar que -> hav(theta) = sin(theta / 2)^2

    %Distancia en kilómetros
    distancia = R * theta;
end