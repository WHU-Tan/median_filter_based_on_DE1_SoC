%mcode to create a coe file
%���ɵ�������һ���н��ж�ȡ��
src = imread('noise.bmp');
gray = rgb2gray(src);
[m,n] = size( gray );                  % m�� n��
 
N = m*n;                               %%���ݵĳ��ȣ����洢����ȡ�
word_len = 8;                          %%ÿ����Ԫ��ռ�ݵ�λ�������Լ��趨
data = reshape(gray', 1, N);% 1��N��
 
%fid=fopen('gray_image.mif', 'w');       %���ļ�
fid=fopen('noise.coe', 'wt');       %���ļ�
fprintf(fid, 'MEMORY_INITIALIZATION_RADIX=16;\n');
fprintf(fid, 'MEMORY_INITIALIZATION_VECTOR=\n');
 
 
for i = 1 : N-1
    fprintf(fid, '%x,\n', data(i));%ʹ��%x��ʾʮ��������
end
fprintf(fid, '%x;\n', data(N));                 %%�����β,ÿ�����ݺ����ö��Ż��߿ո���߻��з����������һ�����ݺ���ӷֺ�
fclose(fid);                            %%�ر��ļ�