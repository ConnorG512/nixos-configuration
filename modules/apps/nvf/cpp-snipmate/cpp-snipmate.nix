let
  loopsArrays = import ./loops-arrays.nix;
  classes = import ./classes.nix;
  patterns = import ./patterns.nix;
  pointers = import ./pointers.nix;
in 
[
  {
    trigger = "turnary";
    body = ''
      $1 ? $2 : $3$0;
    '';
  }
] ++ loopsArrays ++ classes ++ patterns ++ pointers

