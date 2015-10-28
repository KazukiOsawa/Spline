%de Boor�ɂ��3���̑o�X�v���C���̒萔a0,0~a3,3�����߂�A���������Ŏg�p����s����擾
function[Q] = matrixForEquations()
    degree = 3;  %3���̑o�X�v���C��
    size = (degree + 1)^2;
    Q = zeros(size, size);    
    for row = 1 : size
        parameters = parametersForDifferential(row);
        for col = 1 : size
            deg_x = floor((col - 1) / 4); % x�̎���
            deg_y = rem((col - 1), 4);    % y�̎���
            Q(row, col) = coefficientByDifferential(deg_x, deg_y, parameters);
        end
    end
end

%�@�s�����ƂɁA�����Ɋւ��e��p�����[�^���擾
function[parameters] = parametersForDifferential(row)
    val_x = rem(floor((row - 1)/ 2), 2); % (x-xi)/(xi+1-xi)�̒l
    val_y = rem((row - 1), 2);           % (y-yi)/(yi+1-yi)�̒l
    dif_x = rem(floor((row - 1)/ 4), 2); % x�ł̔����K��
    dif_y = floor((row - 1)/ 8);         % y�ł̔����K��
    parameters = struct('val_x', val_x,'val_y', val_y, 'dif_x', dif_x, 'dif_y', dif_y);
end

%  �����ɂ��W�����擾
function[coefficient] = coefficientByDifferential(deg_x, deg_y, parameters)
    val_x = parameters.val_x;
    val_y = parameters.val_y;
    dif_x = parameters.dif_x;
    dif_y = parameters.dif_y;  
    flag = coefficientIsValiable(deg_x, deg_y, dif_x, dif_y, val_x, val_y);
    if flag
        coefficient = coefficientSize(deg_x, deg_y, dif_x, dif_y);
    else
        coefficient = 0;
    end
end

%  �W���̑傫�����擾
function[size] = coefficientSize(deg_x, deg_y, dif_x, dif_y)
    if dif_x == 0 && dif_y == 0
        size = 1;
    elseif dif_x == 1 && dif_y == 0
        size = deg_x;
    elseif dif_x == 0 && dif_y == 1
        size = deg_y;
    else
        size = deg_x * deg_y;
    end
end

%  �W�����L�������f
function[flag] = coefficientIsValiable(deg_x, deg_y, dif_x, dif_y, val_x, val_y)
    if val_x == 0 && val_y == 0
        flag = (deg_x == dif_x && deg_y == dif_y);
    elseif val_x == 0 && val_y == 1
        flag = (deg_x == dif_x);
    elseif val_x == 1 && val_y == 0
        flag = (deg_y == dif_y);
    else
        flag = true;
    end
end

