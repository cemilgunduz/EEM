%num = -50.001;
num = input('Ondalýklý bir sayý giriniz : ');
floatToBinary(num)

function result = floatToBinary(num)
    %this is the main function that calculates 
    %binary representation of float value
    sign = double(not(num>0));
    [intnum, dec] = splitNumber(num);
    int_binary = toBinary(intnum);
    dec_binary = toDecBinary(dec);
    exponent_val = length(int_binary)-1;
    exp_binary = toBinary(exponent_val+127);
    mantissa =  [int_binary(2:end),dec_binary];
    if length(mantissa)>23
        mantissa = mantissa(1:23); %if longer: take 23 digits
    end
    mantissa(23) = 0;%normalize mantissa to 23 digits
    result = strjoin([sign, exp_binary, string(mantissa)]);
end

function result = toBinary(n)
    rem = [];
    while n>1
        remainder = mod(n,2);
        division = fix(n/2);
        rem(end+1) = remainder;
        n=division;
    end
    rem(end+1) = 1;
    result = flip(rem);
end

function dec_bin = toDecBinary(n)
    cnt = 1;
    intparts = [];
    [~, dec] = splitNumber(n);
    while cnt<24 && dec ~=0
        [intnum, dec] = splitNumber(n*2);
        intparts = [intparts, intnum];
        n = dec;
        cnt=cnt+1;
    end
    dec_bin = intparts;
end

function [intnum, dec] = splitNumber(n)
    abnum = abs(n);
    intnum = fix(abnum);   %tamsayý kýsmý
    dec = abnum-intnum; %decimal kýsmý
end