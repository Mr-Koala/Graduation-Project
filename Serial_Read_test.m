function [ Tx, Ty, Tz ,temp] = Serial_Read(temp)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%% 产生一个串口对象，并定时从中读取数据
%s=serial('COM1');
%set(s,'BaudRate',1200,'DataBits',7);
%s.status
%fopen(s);
%fprintf(s,'abc');
%G=fscanf(s);
%[a b]=strread(G,'%d',2);
%fcolse(s);
%clear(s);
%% 
if nargin == 0    
   temp = 1;
end
fid=fopen('test.bin','rb');
if fid == -1
    error('Failed to open file!!');
end
fseek(fid,temp,'bof');
A=fread(fid,3,'uint16');
Tx = A(1)*360/65536;
Ty = A(2)*360/65536;
Tz = A(3)*360/65536;
temp=temp+8;
fclose(fid)
end

