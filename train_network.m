clear

clc

load Shuffled_normalised_250.txt;

x=Shuffled_normalised_250;

z=x(:,1:25);

zn=z(:,1:25);

zn=zn';

t=x(:,26:30);

tn=t(:,1:5);

tn=tn';

NET{1,1}='Network';
NET{2,1}='Total Samples';

NET{3,1} = 'True Positive';
NET{4,1} = 'True Negetive';

NET{5,1} = 'False Positive';

NET{6,1} = 'False Negetive';

NET{7,1} = 'Accuracy';
NET{8,1} = 'Precision';
NET{9,1} = 'Recall';
NET{10,1} = 'f-measure';
NET{11,1} = 'Algorithm';
NET{12,1}  ='Train Index';
NET{13,1}  ='Val Index';
NET{14,1}  ='Test Index';
accuracy=-1;
iterations=30;

for index=(2):(iterations+1)

net = feedforwardnet(10,'traingd');
net.trainParam.epochs = 10000;
net.trainParam.lr = 0.3;

net.divideFcn='dividerand';

net.divideParam.trainRatio =0.8; %train at 200 samples
net.divideParam.valRatio =0.04; %validate at 10 samples
net.divideParam.testRatio =0.16; %test at 40 samples

% Train the Network
%tr.trainInd=ABC{2}{2};
%tr.valInd=ABC{2}{3};
%tr.testInd=ABC{2}{4};

[net, tr] = train(net, zn, tn);

% Training Confusion Plot Variables

%yTrn = net(zn(:,tr.trainInd));
tr.trainInd;
%tTrn = tn(:,tr.trainInd);
trainX=zn(:,tr.trainInd);
tTrn = tn(:,tr.trainInd);
yTrn = net(trainX);

%testIndices = vec2ind(yTrn);

% Validation Confusion Plot Variables
yVal = net(zn(:,tr.valInd));
tr.valInd;
tVal = tn(:,tr.valInd);
% Test Confusion Plot Variables

testX=zn(:,tr.testInd);
tTst = tn(:,tr.testInd);
%tr.testInd;
yTst = net(testX);

%saving indexes
    %all_index=[tr.trainInd tr.valInd tr.testInd];
    %fid = fopen('indexes.txt','wt');
   
     %   fprintf(fid,all_index);
        %fprintf(fid,' ');
    %fprintf(fid,'\n');
    %fclose(fid);


%testIndices = vec2ind(yTst);
[c,cm] = confusion(tTst,yTst);
cm;
size(cm);

%plotconfusion(testT,testY)

%[c,cm] = confusion(tTst,yTst);
%cm;
%size(cm);
%Calculating accuracy
dig_sum=0;
for i=1:size(cm,1)
    dig_sum=dig_sum+cm(i,i);
end

false_p=sum(cm(:))-dig_sum;
false_n=sum(cm(:))-dig_sum;
true_p=dig_sum;
true_n=dig_sum;

total=sum(cm(:));
acc=(true_p + true_n)/(true_p+false_p+true_n+false_n);
pre=(true_p)/(true_p+false_p);
recall=(true_p)/(true_p+false_n);
fmeasure=((2*pre*recall)/(pre+recall));

%if acc>accuracy
    %accuracy=acc;
    %DATA{1}=accuracy;
    %DATA{2}=net;
    %DATA{2}=tr.trainInd;
    %DATA{3}=tr.valInd;
    %DATA{4}=tr.testInd;
%end
% Overall Confusion Plot Variables

yAll = net(zn);

tAll = tn;

NET{1,index} = net;
NET{2,index} = total;
NET{3,index} = true_p;
NET{4,index} = true_n;
NET{5,index} = false_p;
NET{6,index} = false_n;
NET{7,index} = acc;
NET{8,index} = pre;
NET{9,index} = recall;
NET{10,index} = fmeasure;
NET{11,index} = 'trainlm';
NET{12,index}  =tr.trainInd;
NET{13,index}  =tr.valInd;
NET{14,index}  =tr.testInd;
% Plot Confusion

plotconfusion(tTrn, yTrn, 'Training', tVal, yVal, 'Validation', tTst, yTst, 'Test', tAll, yAll, 'Overall');
%plotconfusion(tTrn, yTrn, 'Training');
end
%end
ABC={NET};

str = sprintf('AllNetworks');
save(str,'ABC');