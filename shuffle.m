function shuffle(input)
    edit=input;
    for i=1:40
        edit((i-1)*5 +1,:)=input(i,:);
        edit((i-1)*5 +2,:)=input(40+i,:);
        edit((i-1)*5 +3,:)=input(80+i,:);
        edit((i-1)*5 +4,:)=input(120+i,:);
        edit((i-1)*5 +5,:)=input(160+i,:);
    end
    
    fid = fopen('Shuffled.txt','wt');
    for ii = 1:size(edit,1)
        fprintf(fid,'%g\t',edit(ii,:));
        fprintf(fid,'\n');
    end
    fclose(fid);