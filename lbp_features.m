function x = lbp_features(patch, windowSize, desp)
    patchSize = size(patch);
    
    % Número de ventanas posibles que recorrerán la imagen y por tanto número de histogramas
    nWindows = (patchSize(1)/windowSize(1) + ((patchSize(1)/windowSize(1))-1) * ((windowSize(1)/desp)-1)) * ...
    (patchSize(2)/windowSize(2) + ((patchSize(2)/windowSize(2))-1) * ((windowSize(2)/desp)-1));  

    x = zeros(1, nWindows*59);
    index = 1;
    for i = 1:desp:patchSize(1)- desp
        for j = 1:desp:patchSize(2)-desp
           h = hist(patch(i:i+windowSize(1)-1, j:j+windowSize(2)-1), 59);
           x(index:index+58) = sum(h');
           index = index + 59;
        end
    end
    x = x/norm(x);
end