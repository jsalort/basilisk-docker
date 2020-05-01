#include "saint-venant.h"

event graphs (i++) {
    stats s = statsf (h);
    fprintf(stderr, "%g %g %g\n", t, s.min, s.max);
}

event images (t += 4./300.) {
    output_ppm(h);
}

event init (t = 0) {
    foreach()
        h[] = 0.1 + 1.*exp(-200.*(x*x + y*y));
}

event end (t = 4) {
    printf("i = %d t = %g\n", i, t);
}

int main() {
    origin (-0.5, -0.5);
    init_grid(256);
    run();
}
