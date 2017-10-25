function lbp = LBPu(im, T)
   % Implementamos la estrategia zero-padding para resolver el problema
   % de los bordes
   imSize = size(im);
   imP = zeros(imSize(1) + 2, imSize(2) + 2);
   imNew = imP;
   imP(2:imSize(1) + 1, 2:imSize(2) + 1) = im;

   % Creamos una tabla para realizar el etiquetado de cada pixel. En la
   % primera columna tenemos el patrón (en decimal) y en la segunda su
   % correspondiente etiqueta. En este proceso se calculan el número de
   % transiciones de 1 a 0 para realizar el etiquetado correctamente.
   tab = zeros(256, 2);
   label = 0;
   for i = 1:256
       tab(i) = i;
       bin = dec2bin(i-1, 8);
       bin = [bin, bin(1)];
      
       % Cálculo del número de transiciones
       state = bin(1);
       cont = 0;
       for t = 1:9
           if(bin(t) ~= state)
               cont = cont + 1;
               state = bin(t);
           end
       end
      
       % Etiquetado
       if(cont <= 2)
           tab(i, 2) = label;
           label = label + 1;
       else
           tab(i, 2) = 58;
       end
   end
  
   % Cálculo LBP de cada pixel. Para cada uno de ellos se consulta en la
   % tabla anteriormente calculada para obtener la etiqueta y escribirla
   % en la nueva imagen.
   for i = 2:imSize(1)+1
       for j = 2:imSize(2)+1
          
           % Calculamos el vector binario
           binaryPattern = zeros(1,8);
           if(abs(imP(i-1, j-1) - imP(i, j)) = T) binaryPattern(1) = 1; else binaryPattern(1) = 0; end
           if(abs(imP(i-1, j) - imP(i, j)) = T) binaryPattern(2) = 1; else binaryPattern(2) = 0; end
           if(abs(imP(i-1, j+1) - imP(i, j)) = T) binaryPattern(3) = 1; else binaryPattern(3) = 0; end
           if(abs(imP(i, j+1) - imP(i, j)) = T) binaryPattern(4) = 1; else binaryPattern(4) = 0; end
           if(abs(imP(i+1, j+1) - imP(i, j)) = T) binaryPattern(5) = 1; else binaryPattern(5) = 0; end
           if(abs(imP(i+1, j) - imP(i, j)) = T) binaryPattern(6) = 1; else binaryPattern(6) = 0; end
           if(abs(imP(i+1, j-1) - imP(i, j)) = T) binaryPattern(7) = 1; else binaryPattern(7) = 0; end
           if(abs(imP(i, j-1) - imP(i, j)) = T) binaryPattern(8) = 1; else binaryPattern(8) = 0; end
          
           imNew(i, j) = tab(bin2dec(int2str(binaryPattern))+ 1, 2); 
       end
   end
  
   % Devolvemos la imagen sin el padding
   lbp = imNew(2:imSize(1)+1, 2:imSize(2)+1);
  
end
