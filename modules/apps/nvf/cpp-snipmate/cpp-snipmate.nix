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

  {
    trigger = "operator";
    body = ''
      auto operator()($1) $2 -> $3 {$4;}
    '';
  }

  {
    trigger = "template";
    body = ''
      template <$1>
    '';
  }

  {
    trigger = "concept";
    body = ''
      concept $1 = $2;
    '';
  }
  
  {
  trigger = "concept requires";
  body = ''
    concept $1 = requires($2)
    {
      
    };
  '';
  }

  {
    trigger = "lambda expression";
    body = ''
      [$1]($2){$3}
    '';
  }
] ++ loopsArrays ++ classes ++ patterns ++ pointers

