function [P1,P2,P3,P4,P5,P6,C] = F(P1,P2,P3,C,mov)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [FACE ONE]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    global MASTER
    global P
    
    C = C + 1;
    theta = zeros(1,size(P,2));
   
    midpoint = P(:,P2);

    N = P(:,P2) - P(:,P1);
    N = N/norm(N);
    
    v = P(:,P3) - midpoint(:);
    v_proj_N = v - dot(v,N)*N;
        
    if P1 > P2
        temp = P2;
        P2t = P1;
        P1t = temp;
    else 
        P1t = P1;
        P2t = P2;
    end
    
    if MASTER(P1t,P2t) == false
        F1 = 0;
        for i = 1 : size(P,2)
            if i == P1t
                theta(i) = 0;
                continue
            end
            if i == P2t
                theta(i) = 0;
                continue
                
            end
            u = P(:,i) - midpoint;
            u_proj_N = u - (dot(u,N)).*N;

            theta(i) = acos((dot(v_proj_N,u_proj_N)/(norm(v_proj_N)*norm(u_proj_N))));     
        end
        [~,P4] = max(theta);         
        points = [P(:,P1) P(:,P2) P(:,P4)];
        fill3(points(1,:),points(2,:),points(3,:),'yellow')
        MASTER(P1t,P2t) = true;
    else
        F1 = 1;
    end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [FACE TWO]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

    midpoint = P(:,P3);

    N = P(:,P3) - P(:,P1);
    N = N/norm(N);
    
    v = P(:,P2) - midpoint;
    v_proj_N = v - dot(v,N)*N;
    
    if P3 > P1
        temp = P1;
        P1t = P3;
        P3t = temp;
    else 
        P1t = P1;
        P3t = P3;
    end
    
    if MASTER(P3t,P1t) == false
        F2 = 0;
        for i = 1 : size(P,2)
            if i == P3t
                continue
            end
            if i == P1t
                continue
            end
            u = P(:,i) - midpoint;
            u_proj_N = u - dot(u,N)*N;

            theta(i) = acos((dot(v_proj_N,u_proj_N)/(norm(v_proj_N)*norm(u_proj_N))));
        end
        [~,P5] = max(theta);
        points = [P(:,P1) P(:,P3) P(:,P5)];
        fill3(points(1,:),points(2,:),points(3,:),'cyan')
        MASTER(P3t,P1t) = true;
    else
        F2 = 1;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [FACE THREE] - FINAL FACE OF THE TRIANGULAR FACE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

    midpoint = P(:,P3);

    N = P(:,P2) - P(:,P3);
    N = N/norm(N);
    
    v = P(:,P1) - midpoint;
    v_proj_N = v - dot(v,N)*N;
    
    if P2 > P3
        temp = P3;
        P3t = P2;
        P2t = temp;
    else
        P3t = P3;
        P2t = P2;
    end
    
    if MASTER(P2t,P3t) == false
        F3 = 0;
        for i = 1 : size(P,2)
            if i == P2t
                continue
            end
            if i == P3t
                continue
            end
            u = P(:,i) - midpoint;
            u_proj_N = u - dot(u,N)*N;

            theta(i) = acos((dot(v_proj_N,u_proj_N)/(norm(v_proj_N)*norm(u_proj_N))));
        end
        [~,P6] = max(theta);
        points = [P(:,P2) P(:,P3) P(:,P6)];
        fill3(points(1,:),points(2,:),points(3,:),'green')
        MASTER(P2t,P3t) = true;
    else 
        F3 = 1;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [RECURSIVE]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    if F1 + F2 + F3 == 3
%         disp('All sides of P1, P2, and P3 have been found')
    else
        if F1 == false
            F(P1,P2,P4,C,mov);
        end
        if F2 == false
            F(P1,P3,P5,C,mov);
        end
        if F3 == false
            F(P2,P3,P6,C,mov);
        end
    end
end

