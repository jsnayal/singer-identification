clear

clc

load Shuffled_normalised_250.txt
x=Shuffled_normalised_250;
z=x(:,1:25);

testIn=z(:,1:25);

testIn=testIn';

t=x(:,26:30);

testOut=t(:,1:5);

testOut=testOut';

load AllNetworks.mat;
NET_test{1,1}='Network';
%NET_test{2,1}='Total Samples';
NET_test{2,1}='Class 1';
%NET_test{3,1} = 'True Positive';
NET_test{3,1}='Class 2';
%NET_test{4,1} = 'True Negetive';
NET_test{4,1}='Class 3';
%NET_test{5,1} = 'False Positive';
NET_test{5,1}='Class 4';
%NET_test{6,1} = 'False Negetive';
NET_test{6,1}='Class 5';
NET_test{7,1} = 'True Positive';
NET_test{8,1} = 'True Negetive';
NET_test{9,1} = 'False Positive';
NET_test{10,1} = 'False Negetive';
NET_test{11,1} = 'Accuracy';

%accuracy=-1;
%iterations=1;
max_acc=-1;
for i=2:31
    if( ABC{1}{7,i} > max_acc)
        max_acc=ABC{1}{7,i};
        max_index=i;
    end
end
    
net=ABC{1}{1,max_index};
%net = feedforwardnet(15,algo{idx});
%net = feedforwardnet(15,'trainlm');
%net.trainParam.epochs = 450;
%net.trainParam.lr = 0.3;

%net.divideFcn='divideblock';

%net.divideParam.trainRatio = 80/100;
%net.divideParam.valRatio = 10/100;
%net.divideParam.testRatio = 10/100;
               
% Train the Network

%[net, tr] = train(net, zn, tn);

% Training Confusion Plot Variables

%yTrn = net(zn(:,tr.trainInd));
%tr.trainInd;
%tTrn = tn(:,tr.trainInd);

% Validation Confusion Plot Variables

%yVal = net(zn(:,tr.valInd));
%tr.valInd;
%tVal = tn(:,tr.valInd);

% Test Confusion Plot Variables

testX=testIn(:,ABC{1}{14,max_index});
tTst = testOut(:,ABC{1}{14,max_index});


%testX=zn(:,);
%tTst = tn(:,tr.testInd);

%tr.testInd;
yTst = net(testX);
%tstPerform = perform(net,tTst,yTst)
%testIndices = vec2ind(output);

%plotconfusion(testT,testY)

[c,cm] = confusion(tTst,yTst);
cm;
size(cm);

cm_transpose=cm';
%Calculating accuracy
dig_sum=0;
for i=1:size(cm_transpose,1)
    dig_sum=dig_sum+cm_transpose(i,i);
end

tp_total=0;
tn_total=0;
fp_total=0;
fn_total=0;
for i=1:size(cm_transpose,1)
    false_p{i}=sum(cm_transpose(i,:))-cm_transpose(i,i);
    false_n{i}=sum(cm_transpose(:,i))-cm_transpose(i,i);
    true_p{i}=cm_transpose(i,i);
    true_n{i}=dig_sum-cm_transpose(i,i);

    acc_class{i}=(true_p{i} + true_n{i})/(true_p{i}+false_p{i}+true_n{i}+false_n{i});
    pre_class{i}=(true_p{i})/(true_p{i}+false_p{i});
    recall_class{i}=(true_p{i})/(true_p{i}+false_n{i});
    fmeasure_class{i}=((2*pre_class{i}*recall_class{i})/(pre_class{i}+recall_class{i}));
    tp_total=tp_total+true_p{i};
    tn_total=tn_total+true_n{i};
    fp_total=fp_total+false_p{i};
    fn_total=fn_total+false_n{i};
end
%acc=(tp_total+tn_total)/(tp_total+tn_total+fp_total+fn_total);
acc=(1-c)*100;
%if acc>accuracy
  %  accuracy=acc;
 %   DATA_test{1}=accuracy;
  
%  DATA_test{2}=net;
 %   DATA_test{3}=index;
    %DATA_MAX{3}=tr.valInd;
    %DATA_MAX{4}=tr.testInd;
%end
% Overall Confusion Plot Variables

%yAll = net(zn);

%tAll = tn;
index=2;
NET_test{1,index} = net;
NET_test{2,index}(1,:) = {'true_p','true_n','false_p','false_n','accuracy','precision','fmeasure','recall'};
NET_test{2,index}(2,:) = {true_p{1},true_n{1},false_p{1},false_n{1},acc_class{1},pre_class{1},recall_class{1},fmeasure_class{1}};
NET_test{3,index}(1,:) = {'true_p','true_n','false_p','false_n','accuracy','precision','fmeasure','recall'};
NET_test{3,index}(2,:) = {true_p{2},true_n{2},false_p{2},false_n{2},acc_class{2},pre_class{2},recall_class{2},fmeasure_class{2}};
NET_test{4,index}(1,:) = {'true_p','true_n','false_p','false_n','accuracy','precision','fmeasure','recall'};
NET_test{4,index}(2,:) = {true_p{3},true_n{3},false_p{3},false_n{3},acc_class{3},pre_class{3},recall_class{3},fmeasure_class{3}};
NET_test{5,index}(1,:) = {'true_p','true_n','false_p','false_n','accuracy','precision','fmeasure','recall'};
NET_test{5,index}(2,:) = {true_p{4},true_n{4},false_p{4},false_n{4},acc_class{4},pre_class{4},recall_class{4},fmeasure_class{4}};
NET_test{6,index}(1,:) = {'true_p','true_n','false_p','false_n','accuracy','precision','fmeasure','recall'};
NET_test{6,index}(2,:) = {true_p{5},true_n{5},false_p{5},false_n{5},acc_class{5},pre_class{5},recall_class{5},fmeasure_class{5}};
NET_test{7,index} = tp_total;
NET_test{8,index} = tn_total;
NET_test{9,index} = fp_total;
NET_test{10,index} = fn_total;
NET_test{11,index} = acc;
% Plot Confusion

plotconfusion(tTst, yTst, 'Test');
%end
%end
ABC_test={NET_test};
str = sprintf('AllNetworks_test');
save(str,'ABC_test');