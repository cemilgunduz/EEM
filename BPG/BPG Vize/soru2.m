initial_matrix = randi([0,255],200,200);
studentID = '200517005';
student_name = 'Cemil';

[st_row, st_col] = calculateStart(studentID, student_name);
[fin_row, fin_col] = calculateFinish(student_name);
finish_value = initial_matrix(fin_row, fin_col)

for i=st_row:fin_row
    row_mins = zeros(1,fin_col-st_col+1)
    k=1
    for j=st_col:fin_col
        dist = sqrt((fin_row-i)^2 + (fin_col-j)^2);
        row_mins(k)= dist;
        initial_matrix(i,j)=0;
        k=k+1
    end
    [M, ind] = min(row_mins);
    initial_matrix(i,st_col+ind-1) = 1;
end
imshow(initial_matrix)


function [st_row, st_col] = calculateStart(studentID, student_name)
    last_two = str2double(studentID(end-1:end));
    first_char = double(student_name(1));
    st_row = mod(last_two,10)
    st_col = mod(first_char,10)
end

function [fin_row, fin_col] = calculateFinish(student_name)
    first_char = double(student_name(1));
    fin_row = maxPrime(first_char);
    fin_col = minPrime(first_char);
end

function min_prime = minPrime(n)
    n=n+1;
    while isPrime(n)==false
        n=n+1;
    end
    min_prime = n;
end

function max_prime = maxPrime(n)
    max_prime = 2;
    for i=3:2:n 
        if isPrime(i)==true
            max_prime = i;
        end
    end
end

function is_prime = isPrime(n)
    is_prime = true;
    for i=2:n-1
        if mod(n,i)==0
            is_prime = false;
            break
        end
    end
end