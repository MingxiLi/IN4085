function a = my_rep(nist)

    img = preproc(nist);
    prwaitbar off;

    %%%%%% Creates a PRdataset from the nist with features %%%%%%
    img_data = prdataset(img);

    %%%%%% Representation %%%%%%
    % Features
    img_feat = im_features(img_data, img_data, 'all');

    % Dissimilarity
    img_Euclidean = img_data * proxm(img_data);  % Euclidean

    a = [img_data img_feat img_Euclidean];
end