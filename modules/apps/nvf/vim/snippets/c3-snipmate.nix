[
  {
    trigger = "comment-doc";
    body = ''
      <*

      *>
    '';
  }
  
  {
    trigger = "require";
    body = ''
      @require $1 : "$2"
    '';
  }
  
  {
    trigger = "ensure";
    body = ''
      @ensure return $2
    '';
  }
  
  {
    trigger = "param";
    body = ''
      @param $1 : '$2'
    '';
  }
  
  {
    trigger = "vector";
    body = ''
      $1[<$2>] $0 = {};
    '';
  }
  
  {
    trigger = "enum";
    body = ''
      enum $1 : $2 
      {
        $0
      }
    '';
  }
  
  {
    trigger = "constset";
    body = ''
      constset $1
      {
        $0
      }
    '';
  }
]
