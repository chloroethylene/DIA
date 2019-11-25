function data = loaddata(img_num, img_dim, filetype, filedir)

data = zeros(img_dim, img_num);
for iii = 1:size(filetype,1)
    filedirpath = [filedir filetype(iii,:)];
    dirs=dir(filedirpath);
    if size(dirs,1) > 0
        num_img = size(dirs,1);
        for jjj = 1:size(dirs,1)
%             disp(jjj);
            filename = dirs(jjj).name;
            img_face = imread([filedir filename]);
            data(:, jjj) = reshape(img_face, [], 1);
        end
    end
end

end