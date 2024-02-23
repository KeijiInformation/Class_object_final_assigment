function dcnnDB = createDcnnDB(dirPath, fnameDB)
  dcnnDB = zeros(size(fnameDB, 1), 4096);
  net = alexnet;
  for i = 1:size(fnameDB, 1)
    img = imread(strcat(dirPath, "/", fnameDB(i)));
    reimg = imresize(img,net.Layers(1).InputSize(1:2));
    dcnnf = activations(net,reimg,'fc7');
    dcnnf = squeeze(dcnnf);
    dcnnf = dcnnf/norm(dcnnf);
    dcnnDB(i, :) = dcnnf;
  end
end