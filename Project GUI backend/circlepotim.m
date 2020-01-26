function [circlePixels] = circlepotim(radius,n)

imageSizeX = n;
imageSizeY = n;
[columnsInImage,rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);

centerX = n/2;
centerY = n/2;

circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;
