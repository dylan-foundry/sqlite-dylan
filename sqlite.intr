module: sqlite

define interface
  #include "sqlite3.h",
    equate: {"char *" => <c-string>},
    import: {
      "sqlite3_libversion",
      "sqlite3_sourceid",
      "sqlite3_libversion_number",

      "sqlite3_threadsafe",

      "sqlite3_close",

      "sqlite3_interrupt",

      "sqlite3_open",
      "sqlite3_open_v2",

      "sqlite3_errcode",
      "sqlite3_extended_errcode",
      "sqlite3_errmsg",

      "sqlite3_prepare_v2" => sqlite3-prepare,
      "sqlite3_sql",
      "sqlite3_stmt_readonly",
      "sqlite3_stmt_busy",
      "sqlite3_bind_blob",
      "sqlite3_bind_double",
      "sqlite3_bind_int",
      "sqlite3_bind_int64",
      "sqlite3_bind_null",
      "sqlite3_bind_text",
      "sqlite3_bind_value",
      "sqlite3_bind_zeroblob",
      "sqlite3_bind_parameter_count",
      "sqlite3_bind_parameter_name",
      "sqlite3_bind_parameter_index",
      "sqlite3_clear_bindings",
      "sqlite3_column_count",
      "sqlite3_column_name",
      "sqlite3_column_decltype",
      "sqlite3_step",
      "sqlite3_data_count",
      "sqlite3_column_blob",
      "sqlite3_column_bytes",
      "sqlite3_column_double",
      "sqlite3_column_int",
      "sqlite3_column_int64",
      "sqlite3_column_text",
      "sqlite3_column_type",
      "sqlite3_column_value",
      "sqlite3_finalize",
      "sqlite3_reset"
    };

    function "sqlite3_threadsafe",
      map-result: <C-boolean>;

    function "sqlite3_open",
      output-argument: 2;

    function "sqlite3_open_v2",
      output-argument: 2;

    function "sqlite3_prepare_v2",
      output-argument: 4,
      output-argument: 5;

    function "sqlite3_stmt_readonly",
      map-result: <C-boolean>;

    function "sqlite3_stmt_busy",
      map-result: <C-boolean>;
end interface;
