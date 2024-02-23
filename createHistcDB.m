function DB = createHistcDB(dirPath, fnameDB, numOfRows)
  DB = ones(numOfRows, 64);
  n=0;
  for i=1:length(fnameDB)
    h = createColorHistgram(strcat(dirPath, "/", fnameDB(i)));
    n=n+1;
    DB(n, :) = h;
  end
end