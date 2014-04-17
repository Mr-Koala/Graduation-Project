function []=Serial_Read(BoundRate)
	s=serial('COM2','BoundRate',BoundRate);
	fopen(s);
	l=fread(s);
	disp(l);
	fclose(s);
end
