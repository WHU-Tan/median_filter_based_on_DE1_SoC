%mcode to create a mif file
src = imread('noise.bmp');
gray = rgb2gray(src);
[m,n] = size( gray );                  % m行 n列
 
N = m*n;                               %%数据的长度，即存储器深度。
word_len = 8;                          %%每个单元的占据的位数，需自己设定
data = reshape(gray', 1, N);% 1行N列
 
%fid=fopen('gray_image.mif', 'w');       %打开文件
fid=fopen('gray_image.mif', 'w');       %打开文件
fprintf(fid, 'DEPTH=%d;\n', N);
fprintf(fid, 'WIDTH=%d;\n', word_len);
 
fprintf(fid, 'ADDRESS_RADIX = UNS;\n'); %% 指定地址为十进制
fprintf(fid, 'DATA_RADIX = HEX;\n');    %% 指定数据为十六进制
fprintf(fid, 'CONTENT\t');
fprintf(fid, 'BEGIN\n');
for i = 0 : N-1
    fprintf(fid, '\t%d\t:\t%x;\n',i, data(i+1));
end
fprintf(fid, 'END;\n');                 %%输出结尾
fclose(fid);                            %%关闭文件