[
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

]
