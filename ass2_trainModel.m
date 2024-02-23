% 初期設定
n = 50;
posImgdir = "imgdir/ass2-2";
negImgdir = "imgdir/random";
posFnameDB = createFnameDB(posImgdir);
posFnameDB = posFnameDB(1:n);
negFnameDB = createFnameDB(negImgdir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AlexNetによるDCNN特徴量+線形SVM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% データの作成
posDcnnDB = createDcnnDB(posImgdir, posFnameDB);
negDcnnDB = createDcnnDB(negImgdir, negFnameDB);
dcnnDB = cat(1, posDcnnDB, negDcnnDB);

% テストデータと学習データの作成
trainingLabel = [ones(n, 1); zeros(500, 1)];
trainingData   = dcnnDB;

% 学習
model = fitcsvm(trainingData, trainingLabel, 'KernelFunction','rbf', 'KernelFunction','linear');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%