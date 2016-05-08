function[lbpfeatures]=computelbp(fea,gnd)
lbpfeatures=[]; 
    for i=1:length(gnd)
        I=reshape(fea(i,:),[100,100]);
        B=extractLBPFeatures(I);
        lbpfeatures=[lbpfeatures;B];
    end
end