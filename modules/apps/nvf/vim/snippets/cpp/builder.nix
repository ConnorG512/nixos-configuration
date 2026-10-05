[
  {
    trigger = "builderFunctionDefinition";
    body = ''
      $1& $1::$2($3) noexcept {
        // Implementation:
        return *this;
      }
    '';
  }

  {
    trigger = "builderClass";
    body = ''
      class Builder {
        friend class $1;

        public:
          Builder& $2($3) noexcept;
          $1 build($4) const;
        
        private:
          // Data: $0
      };
    '';
  }
]
