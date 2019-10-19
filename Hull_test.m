function Hull_test()
    global MASTER
    global P

    figure()

    plot3(P(1,:),P(2,:),P(3,:),'o','MarkerEdgeColor','k',...
            'MarkerFaceColor','red','MarkerSize',5)
    hold on
    grid on
%     axis equal
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    title('Convex Hull 3D')

    for i = 1 : size(P,2)
        for j = 1 : size(P,2)
            if MASTER(i,j) == 1
                plot3([P(1,i) P(1,j)],[P(2,i) P(2,j)],[P(3,i) P(3,j)],'-b')

            end
        end
    end

    for i = 1:.08:45
        view([i i])
        drawnow
        if i >= 50
            view([50 50+i])
            drawnow
        end
    end
end