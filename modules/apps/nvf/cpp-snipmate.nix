[
  {
    trigger = "turnary";
    body = ''
      $1 ? $2 : $3$0;
    '';
  }

  {
    trigger = "mkArrayWInc";
    body = ''
      #include <array>
      $1 auto $2 = std::to_array<$3>
      ({
        $0
      });
    '';
  }

  {
    trigger = "mkArray";
    body = ''
      $1 auto $2 = std::to_array<$3>
      ({
        $0
      });
    '';
  }

  {
    trigger = "ruleOfFiveClass";
    body = ''
      class $1 $2 $3 
      {
        public:
        $1() = default;
        ~$1() = default;

        $1(const $1 &other) = default;                // Copy constructor.
        $1& operator=(const $1 &other) = default;     // Copy assignment.
        $1($1&& other) noexcept = default;            // Move constructor.
        $1& operator=($1 &&other) noexcept = default; // Move assignment.
        
        private:
      };
    '';
  }

  {
    trigger = "basicClass";
    body = ''
      class $1 $2 $3 
      {
        public:
        $1($0) = default;
        ~$1() = default;

        private:
      };
    '';
  }

  {
    trigger = "uniqPtrWithDeleterWInc";
    body = ''
      #include <memory>
      std::unique_ptr<$1, decltype(&$2)> $0 {nullptr, &$2}; 
    '';
  }
  
  {
    trigger = "uniqPtrWithDeleter";
    body = ''
      std::unique_ptr<$1, decltype(&$2)> $0 {nullptr, &$2}; 
    '';
  }

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
    trigger = "forEachIndexed";
    body = ''
      for (const auto& [index, value] : $1 | std::views::enumerate)
      {
        // Implementation $0
      }
    '';
  }
  
  {
    trigger = "forEachIndexedWInc";
    body = ''
      #include <ranges>
      for (const auto& [index, value] : $1 | std::views::enumerate)
      {
        // Implementation $0
      }
    '';
  }
]

