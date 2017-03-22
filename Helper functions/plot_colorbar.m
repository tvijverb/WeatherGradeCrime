fig1 = figure;

left=100; bottom=100 ; width=20 ; height=500;
pos=[left bottom width height];
axis off
caxis([-1 1]);

h = colorbar('Position',[0.1 0.1  0.7  0.8],'TickDirection','out');
cpos=get(h,'position'); %get position of colorbar

h1=axes('position',(get(h,'position')+ [0 0.7 0 0]),'color','none','ylim',[0 100],'xtick',[]); %introduce second scale on colorbar
axis off;

