function codebook = createCodebook(dirPath, fnameDB, posIdx, negIdx)
  % 対象データの選択
  list = fnameDB;
  PosList=list(posIdx);
  NegList=list(negIdx);
  Training={PosList{:} NegList{:}};

  % 特徴点の抽出
  Features=[];
  for i=1:size(Training, 2)
    I=rgb2gray(imread(strcat(dirPath, "/", Training{i})));
    p=createRandomPoints(I, 2000);
    [f,p2]=extractFeatures(I,p);
    Features=[Features; f];
  end

  if (length(Features) > 50000)
      Features=Features(randperm(length(Features),50000),:);
  end

  % コードブックの作成
  [IDX, C] = kmeans(Features, 1000);
  codebook = C;

end