[
  {
    trigger = "table";
    body = ''
      $1 = {}
    '';
  }
  
  {
    trigger = "local";
    body = ''
      local $1 = $0
    '';
  }
  
  {
    trigger = "global";
    body = ''
      $1 = $0
    '';
  }
  
  {
    trigger = "while";
    body = ''
      while ($1)
      do
        $0
      end
    '';
  }
  
  {
    trigger = "function";
    body = ''
      function $1($2)
        $0

        return;
      end
    '';
  }
  
  {
    trigger = "if";
    body = ''
      if ($1) then 
        $0
      end
    '';
  }
  
  {
    trigger = "ifelse";
    body = ''
      if ($1) then 
        $0
      else
      end
    '';
  }

  {
    trigger = "array";
    body = ''
      $1 = {$0}
    '';
  }
]
