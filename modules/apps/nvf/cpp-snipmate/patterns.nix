[
  {
    trigger = "runtimeStraregy";
    body = ''
      class $1 
      {
      public:
        virtual ~$1() = default;
        virtual $2 $3() const = 0;
      };
      
      class $4 : public $1 
      {
        $2 $3() const override
        {
          // Implementation. $0
        }
      };
      
      class $5 : public $1 
      {
        $2 $3() const override
        {
          // Implementation.
        }
      };
    '';
  }

  {
    trigger = "staticPolymorphism";
    body = ''
      struct $1 { void name(this auto&& self) { self.$2(); } };

      struct $3 : public $1 
      { 
          // Consider constexpr static auto for data. $0
          void $2() { /* Implementation */ } 
      };

      struct $4 : public $1 
      { 
          void $2() { /* Implementation */ } 
      };
    '';
  }
  
  {
    trigger = "compileTimeDucktyping";
    body = ''
      #include <concepts>
      template<typename $1>
      concept executable = requires($1 $2) 
      {
          /* Ensures that only structs with the method "action" can be used with the template. */ $0
          $2.action();
      };

      template <executable $1>
      auto action($1 executable) noexcept -> void 
      {
          executable.action();
      }
    '';
  }
]
