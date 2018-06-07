function slices(r, fn= $fn, fs= $fs, fa= $fa)=
  let ( r= (r < 3 ? 3 : r))
    (fn > 0 ? (fn > 3 ? fn : 3) :
    ceil(max(min(360.0 / fa, r*2*PI / fs), 5)));
