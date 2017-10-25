function [] = extractFeatures(pathFiles, nameFile, T)
    d = dir(strcat(pathFiles, '*.png'));
    r = zeros(length(d), 6195);
    for i = 1:length(d)
        path = strcat(pathFiles, d(i).name);
        im = rgb2gray(imread(path));
        patch = LBPu(im, T);
        no = lbp_features(patch, [16, 16], 8);
        disp([i, length(d)]);
        r(i,:) = no;
    end
    csvwrite(nameFile, r);
end