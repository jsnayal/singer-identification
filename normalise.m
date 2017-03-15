function norm_INPUT=normalise(input)
    input=input';
    ra=1;
    rb=-1;
    size_in = size(input,1);
    size_l=size_in-5;
    for i=1:size_l;
        min_input{i,1}=min(input(i,:));
        max_input{i,1}=max(input(i,:));

        norm_INPUT(i,:)=  (( (ra-rb) * (input(i,:) - min_input{i,1})) / (max_input{i,1} - min_input{i,1})) + rb;
    
    end
    
    for i=size_l+1 : size_in
            norm_INPUT(i,:)=input(i,:);
    end
    norm_INPUT=norm_INPUT';
    
    fid = fopen('Final_dataset_200_samples.txt','wt');
    for ii = 1:size(norm_INPUT,1)
        fprintf(fid,'%g\t',norm_INPUT(ii,:));
        fprintf(fid,'\n');
    end
    fclose(fid);
end