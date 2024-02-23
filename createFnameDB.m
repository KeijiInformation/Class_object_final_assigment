function fnameDB = createFnameDB(dirPath)
  % DBの作成
  fnames=dir(strcat(dirPath,'/'));
  numOfFiles = size(fnames);
  numOfFiles = numOfFiles(1) - 2;
  fnameDB = cell(numOfFiles, 1);
  for i=3:size(fnames)
      if (strfind(fnames(i).name, ".jpg"))
        fnameDB{i-2} = fnames(i).name;
      end
  end
end