function eval = eval2Classify(model, testingData, testingLabel)
  [predictedLabel, scores] = predict(model, testingData);
  numOfAccuracy = 0;
  for i = 1:size(predictedLabel, 1)
    if (predictedLabel(i, 1) == testingLabel(i, 1))
      numOfAccuracy = numOfAccuracy + 1;
    end
  end
  eval = numOfAccuracy / size(predictedLabel, 1);
end