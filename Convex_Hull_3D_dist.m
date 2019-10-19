%%%%%%%%%%%%%%%%%%%%%%%%% CONVEX HULL ALGORITHM %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Joshua Ferrigno
% Department of Mechanical and Aerospace Engineering - UT Arlington
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [non function]
% #1 Randomize points 
% [function]
% #2 Find a face on CH, f (InitFace(P))
% #3 Find the angle theta from edge of face f, e to P(i) for all N points
% #4 find the point with the smallest angle
% #5 create new face f between e and P(i) with smallest angle
% #6 repeat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrix MASTER is the matrix that shows which particle is connected to which
% other particle, such that a convex hull is made. Hull_test at the very
% end just graphs the MASTER(i,j) vectors, constituting the boundary edges
% of the hull
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sum(MASTER(:) == 4)

clc
clear all
clear global
close all

tic

global MASTER
global P

% points
n = 50;
P(1:3,n) = 0;
MASTER = false(n,n);
check = 0;

set(gca,'nextplot','replacechildren'); 
mov = VideoWriter('crossover.avi');
mov.Quality = 100;
mov.FrameRate = 60;
open(mov);

while any(P(3,n)) == 0
    test = 2*rand(3,1)-1;
    if norm(test) <= 1
        check = check + 1;
        P(:,check) = test;
    end
end

plot3(P(1,:),P(2,:),P(3,:),'.','MarkerEdgeColor','k',...
        'MarkerFaceColor','k','MarkerSize',5)
    
axis equal
hold on
grid on

[points,P1,P2,P3] = InitFace(P);

Found(P1) = 1;
Found(P2) = 1;
Found(P3) = 1;

% Plot new points on Initface
fill3(points(1,:),points(2,:),points(3,:),'blue')

% % P1 - GREEN
% plot3(P(1,P1),P(2,P1),P(3,P1),'g.','MarkerSize',50)
% % P2 - CYAN
% plot3(P(1,P2),P(2,P2),P(3,P2),'c.','MarkerSize',50)
% % P3 - BLUE
% plot3(P(1,P3),P(2,P3),P(3,P3),'b.','MarkerSize',50)

xlabel('X')
ylabel('Y')
zlabel('Z')
title('3D Convex-Hull')

frame = getframe(gcf);
writeVideo(mov,frame);

% How many times F gets called
Callcount = 0;

F(P1,P2,P3,Callcount,mov)

toc

close(mov);
fprintf('Finished\n')

Hull_test
disp('done')