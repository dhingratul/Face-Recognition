function[out]=count_frequency(x)
a = unique(x);
out = [a,histc(x(:),a)];
end