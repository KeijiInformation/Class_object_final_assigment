SVMModel = model;
imgdir = "imgdir/ass2-2_test";
fnameDB = createFnameDB(imgdir);
X = createDcnnDB(imgdir, fnameDB);

[label,score] = predict(SVMModel,X);

% 降順 ('descent') でソートして，ソートした値とソートインデックスを取得します．
[sorted_score,sorted_idx] = sort(score(:,2),'descend');

% sorted_idxを使って画像ファイル名，さらに
% sorted_score[i](=score[sorted_idx[i],2])の値を出力します．
for i=1:numel(sorted_idx)
  fprintf('%s %f\n',fnameDB{sorted_idx(i)},sorted_score(i));
end