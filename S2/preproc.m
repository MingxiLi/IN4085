function [img_prop] = preproc(img)

% resize
img_prop = im_box(img,0,1);
img_prop = im_resize(img_prop, [16, 16]);

end