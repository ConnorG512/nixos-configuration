[
  {
    trigger = "returnDerefPointer";
    body = ''
      auto $1() -> noexcept $2&
      {
        assert($3 != nullptr);
        return *$3;
      }
    '';
  }
  
  {
    trigger = "returnDerefPointerConst";
    body = ''
      auto $1() const noexcept -> const $2&
      {
        assert($3 != nullptr);
        return *$3;
      }
    '';
  }

  {
    trigger = "returnPointer";
    body = ''
      auto $1() noexcept -> $2*
      {
        assert($3 !+ nullptr);
        return $3;
      }
    '';
  }

  {
    trigger = "returnPointerConst";
    body = ''
      auto $1() const noexcept -> const $2*
      {
        assert($3 != nullptr);
        return $3;
      }
    '';
  }

  {
    trigger = "uniqPtrFactoryFuncDeleter";
    body = ''
      auto $1($2) noexcept 
        -> std::unique_ptr<$3, decltype(&$4)>
      {
        $3 *$5 {nullptr};
        // Implementation.
        
        assert($5 != nullptr);
        return std::unique_ptr<$3, decltype(&$4)> {
          $5,
          &$4
        };
      }
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
]
