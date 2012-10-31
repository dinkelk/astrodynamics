function R2latex(R)
fprintf('\\begin{align*}\n');
fprintf('\\vec{r} &= \n');
fprintf('\t\\begin{bmatrix}\n');
fprintf(1,'\t\t %f \\\\ \n',R(1));
fprintf(1,'\t\t %f \\\\ \n',R(2));
fprintf(1,'\t\t %f \\\\ \n',R(3));
fprintf('\t\\end{bmatrix} \\ km \n');
fprintf('\\end{align*}\n');


