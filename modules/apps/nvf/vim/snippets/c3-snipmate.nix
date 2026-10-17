[
  {
    trigger = "comment-doc";
    body = ''
      <*
        $0
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
    trigger = "cname";
    body = ''
      @cname("$1")$0
    '';
  }

  {
    trigger = "param";
    body = ''
      @param $1 : '$2'
    '';
  }

  {
    trigger = "extern";
    body = ''
      extern $0
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
  
  {
    trigger = "struct";
    body = ''
      struct $1 
      {
        $0
      }
    '';
  }

  {
    trigger = "bitstruct";
    body = ''
      bitstruct $1 : $2
      {
        $0
      }
    '';
  }
  
  {
    trigger = "module";
    body = ''
      module $1;
    '';
  }

  {
    trigger = "foreach";
    body = ''
      foreach ($1 : $2)
      {
        $0
      }
    '';
  }
  
  {
    trigger = "foreachreference";
    body = ''
      foreach (&$1 : $2)
      {
        $0
      }
    '';
  }
  
  {
    trigger = "for";
    body = ''
      for ($1; $2; $3)
      {
        $0
      }
    '';
  }
  
  {
    trigger = "forsemi";
    body = ''
      for (;;)
      {
        $0
      }
    '';
  }
  
  {
    trigger = "while";
    body = ''
      while ($1)
      {
        $0
      }
    '';
  }

  {
    trigger = "if";
    body = ''
      if($1)
      {
        $0
      }
    '';
  }
  
  {
    trigger = "else";
    body = ''
      else
      {
        $1
      }
    '';
  }

  {
    trigger = "function";
    body = ''
      fn $1 $2($3)
      {
        $0
      }
    '';
  }

  {
    trigger = "test-function";
    body = ''
      fn $1 $2($3) @test
      {

      }
    '';
  }

  {
    trigger = "cast";
    body = ''
      ($1)$0
    '';
  }

  {
    trigger = "notenull";
    body = ''
      != null$0
    '';
  }
  
  {
    trigger = "notezero";
    body = ''
      != 0$0
    '';
  }
]
