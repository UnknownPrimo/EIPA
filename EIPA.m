%% ELEC 4700 
%% PA 5 - Harmonic Wave Equation in 2D FD and Modes

clf;

%i. Create a sparse G matrix (nx*ny,nx*ny) in size. Initially set nx = ny = 50;
nx = 50;
ny = 50;

%Sparse G matrix
G = sparse(nx*ny,nx*ny);

% Main Loop
%-----------   
for i=1:nx
    for j=1:ny
                
        %Mapping equation
        m = j + (i-1)*ny;
        
        %ii. For the BC's nodes you will need to set the diagonal value G(m,m) to 1 and 
        %all other entries to 0 (G(m,:))
        if i == 1  
            G(m, :) = 0;
            G(m, m) = 1;
        elseif i == nx
            G(m, :) = 0;
            G(m, m) = 1;
        elseif j == 1
            G(m, :) = 0;
            G(m, m) = 1;
        elseif j == ny
            G(m, :) = 0;
            G(m, m) = 1;
        else
            %iii. For the bulk nodes the G entries are set by the FD equation
            G(m, m) = -4;
            G(m, m+ny) = 1;
            G(m, m-ny) = 1;
            G(m, m+1) = 1;
            G(m, m-1) = 1;
        end
        %ix. Change the `-4' in the G matrix diagonal to `-2' for a region of space (say i > 10 & i < 20 & j
        % > 10 & j < 20)
        if (i > 10 && i < 20 && j > 10 && j < 20)
            G(m,m) = -2;
        end
    end
end

%Plots
%------
figure(1)
%iv. Plot G using spy()
spy(G)

%v. Use [E,D] = eigs(g,9,'SM') to get 9 eigenvectors and values. E is a matrix of vectors and D's 
%diagonal is the eigenvalues.
[E,D] = eigs(G,9,'SM');

%vi. Plot the eigenvalues.
%vii. Plot the eigenvectors using surf(). 
figure(2)
for z = 1:9
    subplot(3,3,z)
    l = squeeze(map(z,:,:));
    surf(l)
end