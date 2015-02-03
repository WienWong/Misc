% Coursera Online course : Image and video processing: 
% From Mars to Hollywood with a stop at the hospital

% Image before histogram equalization
I = imread('tire.tif');

figure; imshow(I); 
figure; imhist(I); 
figure; imshow(255-I); 
figure; imhist(255-I);

% Image after histogram equalization
figure; imshow(I); 
figure; imhist(I); 
figure; histeq(I); 
figure; imhist(histeq(I));

% Noise types
RGB=imread('saturn.png');
I=rgb2gray(RGB);
I2G=imnoise(I,'gaussian',0.02);
I2=imnoise(I,'salt & pepper',0.02);
I20=imnoise(I,'salt & pepper',0.2);
figure,imshow(RGB);
figure,imshow(I);
figure,imshow(I2G);
figure,imshow(I2);
figure,imshow(I20);

% Quiz Ex
vec1=[50.5 51 50 49];
y1=zeros(size(vec1));
for i=1:4
    for j=1:99
        y1(i)=sum(abs(vec1(i)-j));
    end
end
y1


vec2=[1 2 3 4];
y2=zeros(size(vec2));
for m=1:4
    for n=1:3
        y2(m)=sum((vec2(m)-n).^2);
    end
end
y2
