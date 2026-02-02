[
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
]
