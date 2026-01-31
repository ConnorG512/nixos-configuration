[
  {
    trigger = "addStandard";
    body = ''
      set(CMAKE_$1_STANDARD $2)
      set(CMAKE_$1_STANDARD_REQUIRED $3)
    '';
  }

  {
    trigger = "createOutput";
    body = ''
      set($1 $2)

      set ($1_SOURCE 
        # Source files:  
      )
      
      add_executable(\$\{$1} \$\{$1_SOURCE})

      target_compile_options(\$\{$1} PRIVATE
        -Wall
        -Wextra
        -Wpedantic
      )

      target_include_directories(\$\{$1} PRIVATE "\$\{CMAKE_SOURCE_DIR}/include")

      install(TARGETS \$\{$1} RUNTIME DESTINATION bin)
    '';
  }
]
