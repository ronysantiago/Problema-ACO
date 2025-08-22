function [avion, ruta, descargaEn] = despegaAvion(cargaSeleccionada, avion, ruta, descargaEn)
   avion(3) = cargaSeleccionada(1,4); % El avion se mueve al siguiente destino
   avion(2) = avion(2) - cargaSeleccionada(1,1); % Descarga la carga correspondiente
   ruta = [ruta, avion(3)]; % Se actualiza la ruta trazada por el avión
   descargaEn = [descargaEn, avion(3)]; % Actualiza los nodos donde descarga el avión
end