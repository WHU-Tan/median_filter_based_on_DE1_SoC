中值滤波器的FPGA实现，引脚规范为基于Altera Cyclone V的DE1-SoC，通过Quartus17.0编译综合并通过ModelSim10.1仿真测试。
material文件夹：保存了项目实现所需要的图片素材，原图为作者的自画像。
MATLAB文件夹：包含中值滤波器算法验证的MATLAB实现medfilter.m；以及彩色图转灰度，添加椒盐噪声，bmp位图转mif、coe等ROM数据等基本图像处理。
Python文件夹：包含bmp位图转txt文档、txt文档转jpg图片等基本图像处理，基于Python3.7与OpenCV。
Verilog文件夹：FPGA实现所需的所有支持文件（.v .qpf等），以及ModelSim的仿真输出result.mif。
report：课程设计的最终报告。
File Directory：整个项目的目录树结构。

#联系作者：haiantanxiao@whu.edu.cn