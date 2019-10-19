function [Face P1 P2 P3] = InitFace(P)
    % find highest point and its value (z-dimension)
    theta = zeros(1,size(P,2));
    [~,P1] = max(P(3,:));
    % angle between points from the horiz plane
    for i = 1 : size(P,2)
        if i == P1
            theta(P1) = nan;
            continue
        end
        z = P(3,i) - P(3,P1);
        x = P(1,i) - P(1,P1);
        theta(i) = atan2(z,x);
    end
    % the point corresponding to the smallest angle
%     theta(P1) = [];
%     theta=theta*-1;
    [~,P2] = max(theta,[],'omitnan');
    % angle between perpendicular vector of P1 and P2
        for i = 1 : size(P,2)
            if i == P2
                theta(P2) = nan;
                continue
            end
            if i == P1
                theta(P1) = nan;
                continue
            end
        z = P(3,i) - P(3,P1);
        y = P(2,i) - P(2,P1);
        theta(i) = atan2(z,y);
        end
    % the point corresponding to the smallest angle
    [~,P3] = max(theta,[],'omitnan');
    Face = [P(:,P1) P(:,P2) P(:,P3)];
end