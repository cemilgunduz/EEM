x = [1 6 3 8 2 7 5];
srtedx = bubsort(x)

function y = bubsort(x)
    swapped = 1
    while swapped == 1
        swapped = 0
        for i=1:length(x)-1
            if x(i)>x(i+1)
                tmp = x(i)
                x(i)=x(i+1)
                x(i+1)=tmp
                swapped=1
            end
        end
    end
    y=x
end