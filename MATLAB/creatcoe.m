%mcode to create a coe file
%生成的数据是一行行进行读取的
src = imread('noise.bmp');
gray = rgb2gray(src);
[m,n] = size( gray );                  % m行 n列
 
N = m*n;                               %%数据的长度，即存储器深度。
word_len = 8;                          %%每个单元的占据的位数，需自己设定
data = reshape(gray', 1, N);% 1行N列
 
%fid=fopen('gray_image.mif', 'w');       %打开文件
fid=fopen('noise.coe', 'wt');       %打开文件
fprintf(fid, 'MEMORY_INITIALIZATION_RADIX=16;\n');
fprintf(fid, 'MEMORY_INITIALIZATION_VECTOR=\n');
 
 
for i = 1 : N-1
    fprintf(fid, '%x,\n', data(i));%使用%x表示十六进制数
end
fprintf(fid, '%x;\n', data(N));                 %%输出结尾,每个数据后面用逗号或者空格或者换行符隔开，最后一个数据后面加分号
fclose(fid);                            %%关闭文件