function bof = createBoFDB(dirPath, fnameDB, codebook)
  numofI = length(fnameDB);
  bof = zeros(numofI,1000);
  for j=1:numofI  % 各画像についての for-loop
      I = rgb2gray(imread(strcat(dirPath, "/", fnameDB{j})));
      p=createRandomPoints(I, 3000);
      [f,p2]=extractFeatures(I,p);
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      % 類似度計算
      vecs1 = f;
      vecs2 = codebook;

      dim  = size(vecs1, 2); % 次元数がvecs1==vecs2になっている必要あり
      row1 = size(vecs1, 1);
      row2 = size(vecs2, 1);

      vecs1_ = reshape(reshape(repmat(vecs1', row2, 1), 1, row1*row2*dim), dim, row1*row2)';
      vecs2_ = repmat(vecs2, row1, 1);

      similarityList = sqrt(sum(((vecs1_ - vecs2_).^2), 2));
      similarityList = reshape(similarityList, row2, row1)';
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      % 投票
      [minval, minindex] = min(similarityList, [], 2);
      for i = 1:size(minindex, 1)
          bof(j, minindex(i)) = bof(j, minindex(i)) + 1;
      end
  end
  bof = bof ./ sum(bof,2);
end