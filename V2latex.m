function V2latex(V)
fprintf('\\begin{align*}\n');
fprintf('\\dot{\\vec{r}} &= \n');
fprintf('\t\\begin{bmatrix}\n');
fprintf(1,'\t\t %f \\\\ \n',V(1));
fprintf(1,'\t\t %f \\\\ \n',V(2));
fprintf(1,'\t\t %f \\\\ \n',V(3));
fprintf('\t\\end{bmatrix} \\ km/s\n');
fprintf('\\end{align*}\n');