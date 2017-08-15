clear; close all;
load raw-data.mat
load substd-data.mat
load paired-data.mat
load image-subject.mat

%% ====================== Superimposed Histogram ======================= %%

% trait indices
tr = [33,9,5,38,22,15]; 
% memorable 33, forgettable 9
% common 5, uncommon 38
% attractive 22, unattractive 15

% individual plot
figure(1); clf; hold on
h1 = histogram(final(:,tr(1)));
h2 = histogram(final(:,tr(2)));
legend([finalHeader(tr(1)),finalHeader(tr(2))])
title('Antonym-pair histogram on raw ratings')
xlabel('Raw ratings')
ylabel('# images')
set(gca,'FontSize',14)

%% subplot
figure(2); clf; 

ax(1) = subplot(3,1,1); hold on
histogram(final(:,tr(1)),1:0.25:9);
histogram(final(:,tr(2)),1:0.25:9);
legend([finalHeader(tr(1)),finalHeader(tr(2))])
ylabel('# images')
set(gca,'FontSize',16)

title('Antonym-pair histogram on raw ratings')

ax(2) = subplot(3,1,2); hold on
linkaxes(ax,'x');
histogram(final(:,tr(3)),1:0.25:9);
histogram(final(:,tr(4)),1:0.25:9);
legend([finalHeader(tr(3)),finalHeader(tr(4))])
ylabel('# images')
set(gca,'FontSize',16)

ax(3) = subplot(3,1,3); hold on
linkaxes(ax,'x');
histogram(final(:,tr(5)),1:0.25:9);
histogram(final(:,tr(6)),1:0.25:9);
legend([finalHeader(tr(5)),finalHeader(tr(6))])
ylabel('# images')
set(gca,'FontSize',16)

xlabel('Raw ratings')
