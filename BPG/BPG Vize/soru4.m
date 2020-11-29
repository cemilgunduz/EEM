%num = -50.0001;
num = input('Ondalýklý bir sayý giriniz : ');
binary_vector = floatToBinary(num);
binary_representation = strjoin(binary_vector, ' ')
hexadecimal = binaryToHex(floatToBinary(num));
hex_representation = strjoin(['0 x ', string(hexadecimal)], '')

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
    else
        mantissa(23) = 0;%normalize mantissa to 23 digits
    end
    result = [sign, exp_binary, string(mantissa)];
end

function hex = binaryToHex(binary_vector)
    %this method calculates hexadecimal representation of a binary float
    hex = strings(1,8);
    bv = double(binary_vector); % for readability
    for i = 0:7
        sumX = bv(i*4+1)*2^3 + bv(i*4+2)*2^2 + bv(i*4+3)*2^1 + bv(i*4+4)*2^0;
        hex_Values = ["A", "B", "C", "D", "E", "F"];
        if sumX > 9
            sumX = hex_Values(mod(sumX, 10)+1);
        end
        hex(i+1) = string(sumX);
    end
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
    while cnt<25 && dec ~=0
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