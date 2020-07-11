%mcode to create a mif file
src = imread('noise.bmp');
gray = rgb2gray(src);
[m,n] = size( gray );                  % m�� n��
 
N = m*n;                               %%���ݵĳ��ȣ����洢����ȡ�
word_len = 8;                          %%ÿ����Ԫ��ռ�ݵ�λ�������Լ��趨
data = reshape(gray', 1, N);% 1��N��
 
%fid=fopen('gray_image.mif', 'w');       %���ļ�
fid=fopen('gray_image.mif', 'w');       %���ļ�
fprintf(fid, 'DEPTH=%d;\n', N);
fprintf(fid, 'WIDTH=%d;\n', word_len);
 
fprintf(fid, 'ADDRESS_RADIX = UNS;\n'); %% ָ����ַΪʮ����
fprintf(fid, 'DATA_RADIX = HEX;\n');    %% ָ������Ϊʮ������
fprintf(fid, 'CONTENT\t');
fprintf(fid, 'BEGIN\n');
for i = 0 : N-1
    fprintf(fid, '\t%d\t:\t%x;\n',i, data(i+1));
end
fprintf(fid, 'END;\n');                 %%�����β
fclose(fid);                            %%�ر��ļ�