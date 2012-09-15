function TLEs = loadTLEs(filename)
fd = fopen(filename,'r');

TLEs = {};
line_num = 0;
cnt = 1;

while ~feof(fd)
   
   % Get the next line:
   line_num = line_num + 1;
   line = fgetl(fd);
   
   % Parse line:
   parsed_line = regexp(line,' ','split');
   if(strcmp(parsed_line(1),'1'))
        line1 = parsed_line;
        
        % Get the next line:
        line_num = line_num + 1;
        line = fgetl(fd);
        
        % Parse line:
        parsed_line = regexp(line,' ','split');
        if(strcmp(parsed_line(1),'2'))
            line2 = parsed_line;
        else
           % fprintf('Invalid TLE found on line %d.\n',line_num);
           % fclose(fd);
            continue;
        end
   else
      %  fprintf('Invalid TLE found on line %d.\n',line_num);
      %  fclose(fd);
        continue;
   end 
   
   % Store TLE:
   if( length(line2) > length(line1))
        TLE(2,1:length(line2)) = line2;
        TLE(1,1:length(line1)) = line1;
   else
        TLE(1,1:length(line1)) = line1;
        TLE(2,1:length(line2)) = line2;
   end
   TLEs{cnt,1} = TLE;
   cnt = cnt + 1;
   
end

fclose(fd);
end