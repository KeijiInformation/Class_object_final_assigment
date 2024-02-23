function h = createColorHistgram(imgPath)
  I = imread(imgPath);
  r = I(:, :, 1);
  g = I(:, :, 2);
  b = I(:, :, 3);
  frecColors = zeros(64, 1);

  IdecreaseColor = floor(double(r)/64) *4*4 + floor(double(g)/64) *4 + floor(double(b)/64);
  IdecreaseColor = reshape(IdecreaseColor, 1, numel(IdecreaseColor));
  h = histc(IdecreaseColor, [0:63]);
end
