% iで何番目のデータをテストとして用いるかを指定
function [trainingIDX, testingIDX] = splitData(n, dataLength, i)
  numOfUnit  = fix(dataLength / n);

  trainingIDX = [1:numOfUnit*(i-1), numOfUnit*i+1:dataLength]';
  testingIDX  = [numOfUnit*(i-1)+1:numOfUnit*(i-1)+numOfUnit]';
  if (i == n)
    trainingIDX = [1:numOfUnit*(i-1)]';
  end
end