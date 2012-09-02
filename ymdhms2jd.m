function jd = ymdhms2jd(year, month, day, hour, minute, second)
%
% - converts year, month, day, hour, minute, second to julian date
% - valid for all positive julian dates
%
% jd = ymdhms2jd(year, month, day, hour, minute, second)
%
% 2000 - Rodney L. Anderson
%
day = day + ((second/60 + minute)/60 + hour)/24;

if(month < 3)
  year = year - 1;
  month = month + 12;
end

A = floor(year/100);
B = 2 - A + floor(A/4);

if(year < 1583)
  B = 0;
  if(year == 1582 & month > 9)
    if(day > 14)
      B = 2 - A + floor(A/4);
    end
  end
end
jd = floor(365.25*(year+4716)) + floor(30.6001*(month+1)) + day + B - 1524.5;