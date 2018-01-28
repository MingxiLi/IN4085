function a = my_rep(nist)

    obj = im_box(nist,0,1);
    obj = preproc(obj);
    a = prdataset(obj);
end