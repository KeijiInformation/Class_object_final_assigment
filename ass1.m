% 初期設定
imgdir = "imgdir/ass1-2";
fnameDB = createFnameDB(imgdir);
posIdx = 1:100;
negIdx = 101:200;
numOfData = 200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% カラーヒストグラム+線形SVM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("Color Histgram + Linear SVM");
% データの作成
histcDB = createHistcDB(imgdir, fnameDB, numOfData);
posData = histcDB(posIdx, :);
negData = histcDB(negIdx, :);

evalSum = 0;
for unitNumber = 1:5
  % テストデータと学習データの作成
  [trainingPosIDX, testingPosIDX] = splitData(5, size(posData, 1), unitNumber);
  [trainingNegIDX, testingNegIDX] = splitData(5, size(negData, 1), unitNumber);
  trainingLabel = [ones(1, size(trainingPosIDX, 1)), zeros(1, size(trainingNegIDX, 1))]';
  trainingData   = cat(1, posData(trainingPosIDX, :), negData(trainingNegIDX, :));

  % 学習
  model = fitcsvm(trainingData, trainingLabel, 'KernelFunction','rbf', 'KernelFunction','linear');

  % 評価
  testingLabel = [ones(1, size(testingPosIDX, 1)), zeros(1, size(testingNegIDX, 1))]';
  testingData  = cat(1, posData(testingPosIDX, :), negData(testingNegIDX, :));
  eval = eval2Classify(model, testingData, testingLabel);
  evalSum = evalSum + eval;
  disp(strcat("test unit = ", num2str(unitNumber), ": ", num2str(eval)));
end

disp(strcat("result: ", num2str(evalSum / 5)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BoF+非線形SVM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("BoF + Not Linear SVM");
% データの作成
codebook = createCodebook(imgdir, fnameDB, posIdx, negIdx);
bof = createBoFDB(imgdir, fnameDB, codebook);
posData = bof(posIdx, :);
negData = bof(negIdx, :);

evalSum = 0;
for unitNumber = 1:5
  % テストデータと学習データの作成
  [trainingPosIDX, testingPosIDX] = splitData(5, size(posData, 1), unitNumber);
  [trainingNegIDX, testingNegIDX] = splitData(5, size(negData, 1), unitNumber);
  trainingLabel = [ones(1, size(trainingPosIDX, 1)), zeros(1, size(trainingNegIDX, 1))]';
  trainingData   = cat(1, posData(trainingPosIDX, :), negData(trainingNegIDX, :));

  % 学習
  model = fitcsvm(trainingData, trainingLabel,'KernelFunction','rbf', 'KernelScale','auto');

  % 評価
  testingLabel = [ones(1, size(testingPosIDX, 1)), zeros(1, size(testingNegIDX, 1))]';
  testingData  = cat(1, posData(testingPosIDX, :), negData(testingNegIDX, :));
  eval = eval2Classify(model, testingData, testingLabel);
  evalSum = evalSum + eval;
  disp(strcat("test unit = ", num2str(unitNumber), ": ", num2str(eval)));
end

disp(strcat("result: ", num2str(evalSum / 5)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AlexNetによるDCNN特徴量+線形SVM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("AlexNet DCNN + Linear SVM");
% データの作成
dcnnDB = createDcnnDB(imgdir, fnameDB);
posData = dcnnDB(posIdx, :);
negData = dcnnDB(negIdx, :);

evalSum = 0;
for unitNumber = 1:5
  % テストデータと学習データの作成
  [trainingPosIDX, testingPosIDX] = splitData(5, size(posData, 1), unitNumber);
  [trainingNegIDX, testingNegIDX] = splitData(5, size(negData, 1), unitNumber);
  trainingLabel = [ones(1, size(trainingPosIDX, 1)), zeros(1, size(trainingNegIDX, 1))]';
  trainingData   = cat(1, posData(trainingPosIDX, :), negData(trainingNegIDX, :));

  % 学習
  model = fitcsvm(trainingData, trainingLabel, 'KernelFunction','rbf', 'KernelFunction','linear');

  % 評価
  testingLabel = [ones(1, size(testingPosIDX, 1)), zeros(1, size(testingNegIDX, 1))]';
  testingData  = cat(1, posData(testingPosIDX, :), negData(testingNegIDX, :));
  eval = eval2Classify(model, testingData, testingLabel);
  evalSum = evalSum + eval;
  disp(strcat("test unit = ", num2str(unitNumber), ": ", num2str(eval)));
end

disp(strcat("result: ", num2str(evalSum / 5)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
