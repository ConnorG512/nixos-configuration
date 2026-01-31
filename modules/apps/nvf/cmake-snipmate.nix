[
  {
    trigger = "cmake_minimum_required";
    body = ''
      cmake_minimum_required(VERSION $1)
    '';
  }

  {
    trigger = "project";
    body = ''
      project($1 $2)
    '';
  }

  {
    trigger = "standard";
    body = ''
      set(CMAKE_$1_STANDARD $2)
      set(CMAKE_$1_STANDARD_REQUIRED $3)
    '';
  }

  {
    trigger = "add_executable";
    body = ''
      add_executable($1 $2)
    '';
  }

  {
    trigger = "function";
    body = ''
      function($1)
        # Implementation
        $0
      endfunction()
    '';
  }
  
  {
    trigger = "set";
    body = ''
      set($1 $2)
    '';
  }

  {
    trigger = "if";
    body = ''
      if()
        $0
      else()
      endif()
    '';
  }
  
  {
    trigger = "if_elseif";
    body = ''
      if()
        $0
      elseif()
      endif()
    '';
  }
  
  {
    trigger = "if_elseif_else";
    body = ''
      if()
        $0
      elseif()
      else()
      endif()
    '';
  }
  
  {
    trigger = "find_package";
    body = ''
      find_package($1 $2)
    '';
  }

  {
    trigger = "pkg_check_modules";
    body = ''
      pkg_check_modules($1 REQUIRED
        $2
      )
    '';
  }

  {
    trigger = "target_link_libraries";
    body = ''
      target_link_libraries($1 PRIVATE
        # Libraries:
        $0
      )
    '';
  }
  
  {
    trigger = "target_include_directories";
    body = ''
      target_include_directories($1 PRIVATE
        # Include directories:
        $0
      )
    '';
  }

  {
    trigger = "install";
    body = ''
      install(TARGETS $1 $2 DESTINATION $3)
    '';
  }
  
  {
    trigger = "target_compile_options";
    body = ''
      target_compile_options($1 PRIVATE 
        # Compile options.
        $0
      )
    '';
  }

  {
    trigger = "if_strequal";
    body = ''
      if($1 STREQUAL $2)
        # Implementation
        $0
      else()
      endif()
    '';
  }

  {
    trigger = "add_subdirectory";
    body = ''
      add_subdirectory($1 $2)
    '';
  }
]
