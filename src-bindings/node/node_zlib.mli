[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> int -> bool or_number [@@js.index_get]

  val set : t -> int -> bool or_number -> unit [@@js.index_set]
end

module Zlib : sig
  open Node_stream

  module Zlib_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_flush : t -> int [@@js.get "flush"]

    val set_flush : t -> int -> unit [@@js.set "flush"]

    val get_finish_flush : t -> int [@@js.get "finishFlush"]

    val set_finish_flush : t -> int -> unit [@@js.set "finishFlush"]

    val get_chunk_size : t -> int [@@js.get "chunkSize"]

    val set_chunk_size : t -> int -> unit [@@js.set "chunkSize"]

    val get_window_bits : t -> int [@@js.get "windowBits"]

    val set_window_bits : t -> int -> unit [@@js.set "windowBits"]

    val get_level : t -> int [@@js.get "level"]

    val set_level : t -> int -> unit [@@js.set "level"]

    val get_mem_level : t -> int [@@js.get "memLevel"]

    val set_mem_level : t -> int -> unit [@@js.set "memLevel"]

    val get_strategy : t -> int [@@js.get "strategy"]

    val set_strategy : t -> int -> unit [@@js.set "strategy"]

    val get_dictionary : t -> (Array_buffer.t, Array_buffer_view.t) union2
      [@@js.get "dictionary"]

    val set_dictionary :
      t -> (Array_buffer.t, Array_buffer_view.t) union2 -> unit
      [@@js.set "dictionary"]

    val get_info : t -> bool [@@js.get "info"]

    val set_info : t -> bool -> unit [@@js.set "info"]

    val get_max_output_length : t -> int [@@js.get "maxOutputLength"]

    val set_max_output_length : t -> int -> unit [@@js.set "maxOutputLength"]
  end
  [@@js.scope "ZlibOptions"]

  module Brotli_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_flush : t -> int [@@js.get "flush"]

    val set_flush : t -> int -> unit [@@js.set "flush"]

    val get_finish_flush : t -> int [@@js.get "finishFlush"]

    val set_finish_flush : t -> int -> unit [@@js.set "finishFlush"]

    val get_chunk_size : t -> int [@@js.get "chunkSize"]

    val set_chunk_size : t -> int -> unit [@@js.set "chunkSize"]

    val get_params : t -> Anonymous_interface0.t [@@js.get "params"]

    val set_params : t -> Anonymous_interface0.t -> unit [@@js.set "params"]

    val get_max_output_length : t -> int [@@js.get "maxOutputLength"]

    val set_max_output_length : t -> int -> unit [@@js.set "maxOutputLength"]
  end
  [@@js.scope "BrotliOptions"]

  module Zlib : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]
  end
  [@@js.scope "Zlib"]

  module Zlib_params : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val params :
      t -> level:int -> strategy:int -> callback:(unit -> unit) -> unit
      [@@js.call "params"]
  end
  [@@js.scope "ZlibParams"]

  module Zlib_reset : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val reset : t -> unit [@@js.call "reset"]
  end
  [@@js.scope "ZlibReset"]

  module Brotli_compress : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]
  end
  [@@js.scope "BrotliCompress"]

  module Brotli_decompress : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]
  end
  [@@js.scope "BrotliDecompress"]

  module Gzip : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]
  end
  [@@js.scope "Gzip"]

  module Gunzip : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]
  end
  [@@js.scope "Gunzip"]

  module Deflate : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val reset : t -> unit [@@js.call "reset"]

    val params :
      t -> level:int -> strategy:int -> callback:(unit -> unit) -> unit
      [@@js.call "params"]
  end
  [@@js.scope "Deflate"]

  module Inflate : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val reset : t -> unit [@@js.call "reset"]
  end
  [@@js.scope "Inflate"]

  module Deflate_raw : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val reset : t -> unit [@@js.call "reset"]

    val params :
      t -> level:int -> strategy:int -> callback:(unit -> unit) -> unit
      [@@js.call "params"]
  end
  [@@js.scope "DeflateRaw"]

  module Inflate_raw : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val reset : t -> unit [@@js.call "reset"]
  end
  [@@js.scope "InflateRaw"]

  module Unzip : sig
    include module type of struct
      include Stream.Transform
    end

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val flush : t -> ?kind:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]

    val flush' : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "flush"]
  end
  [@@js.scope "Unzip"]

  val create_brotli_compress :
    ?options:Brotli_options.t -> unit -> Brotli_compress.t
    [@@js.global "createBrotliCompress"]

  val create_brotli_decompress :
    ?options:Brotli_options.t -> unit -> Brotli_decompress.t
    [@@js.global "createBrotliDecompress"]

  val create_gzip : ?options:Zlib_options.t -> unit -> Gzip.t
    [@@js.global "createGzip"]

  val create_gunzip : ?options:Zlib_options.t -> unit -> Gunzip.t
    [@@js.global "createGunzip"]

  val create_deflate : ?options:Zlib_options.t -> unit -> Deflate.t
    [@@js.global "createDeflate"]

  val create_inflate : ?options:Zlib_options.t -> unit -> Inflate.t
    [@@js.global "createInflate"]

  val create_deflate_raw : ?options:Zlib_options.t -> unit -> Deflate_raw.t
    [@@js.global "createDeflateRaw"]

  val create_inflate_raw : ?options:Zlib_options.t -> unit -> Inflate_raw.t
    [@@js.global "createInflateRaw"]

  val create_unzip : ?options:Zlib_options.t -> unit -> Unzip.t
    [@@js.global "createUnzip"]

  module Input_type : sig
    type t = (Array_buffer.t, Array_buffer_view.t) union2 or_string

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Compress_callback : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val apply : t -> error:Error.t or_null -> result:Buffer.t -> unit
      [@@js.apply]
  end
  [@@js.scope "CompressCallback"]

  val brotli_compress :
       buf:Input_type.t
    -> options:Brotli_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "brotliCompress"]

  val brotli_compress_promisify :
       buffer:Input_type.t
    -> ?options:Brotli_options.t
    -> unit
    -> Buffer.t Promise.t
    [@@js.global "brotliCompress.__promisify__"]

  val brotli_compress_sync :
    buf:Input_type.t -> ?options:Brotli_options.t -> unit -> Buffer.t
    [@@js.global "brotliCompressSync"]

  val brotli_decompress :
       buf:Input_type.t
    -> options:Brotli_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "brotliDecompress"]

  val brotli_decompress :
    buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "brotliDecompress"]

  val brotli_decompress_promisify :
       buffer:Input_type.t
    -> ?options:Brotli_options.t
    -> unit
    -> Buffer.t Promise.t
    [@@js.global "brotliDecompress.__promisify__"]

  val brotli_decompress_sync :
    buf:Input_type.t -> ?options:Brotli_options.t -> unit -> Buffer.t
    [@@js.global "brotliDecompressSync"]

  val deflate : buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "deflate"]

  val deflate :
       buf:Input_type.t
    -> options:Zlib_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "deflate"]

  val deflate__promisify__ :
    buffer:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t Promise.t
    [@@js.global "deflate.__promisify__"]

  val deflate_sync :
    buf:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t
    [@@js.global "deflateSync"]

  val deflate_raw : buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "deflateRaw"]

  val deflate_raw :
       buf:Input_type.t
    -> options:Zlib_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "deflateRaw"]

  val deflate_raw_promisify :
    buffer:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t Promise.t
    [@@js.global "deflateRaw.__promisify__"]

  val deflate_raw_sync :
    buf:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t
    [@@js.global "deflateRawSync"]

  val gzip : buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "gzip"]

  val gzip :
       buf:Input_type.t
    -> options:Zlib_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "gzip"]

  val gzip__promisify__ :
    buffer:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t Promise.t
    [@@js.global "gzip.__promisify__"]

  val gzip_sync :
    buf:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t
    [@@js.global "gzipSync"]

  val gunzip : buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "gunzip"]

  val gunzip :
       buf:Input_type.t
    -> options:Zlib_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "gunzip"]

  val gunzip__promisify__ :
    buffer:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t Promise.t
    [@@js.global "gunzip.__promisify__"]

  val gunzip_sync :
    buf:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t
    [@@js.global "gunzipSync"]

  val inflate : buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "inflate"]

  val inflate :
       buf:Input_type.t
    -> options:Zlib_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "inflate"]

  val inflate__promisify__ :
    buffer:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t Promise.t
    [@@js.global "inflate.__promisify__"]

  val inflate_sync :
    buf:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t
    [@@js.global "inflateSync"]

  val inflate_raw : buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "inflateRaw"]

  val inflate_raw :
       buf:Input_type.t
    -> options:Zlib_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "inflateRaw"]

  val inflate_raw_promisify :
    buffer:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t Promise.t
    [@@js.global "inflateRaw.__promisify__"]

  val inflate_raw_sync :
    buf:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t
    [@@js.global "inflateRawSync"]

  val unzip : buf:Input_type.t -> callback:Compress_callback.t -> unit
    [@@js.global "unzip"]

  val unzip :
       buf:Input_type.t
    -> options:Zlib_options.t
    -> callback:Compress_callback.t
    -> unit
    [@@js.global "unzip"]

  val unzip__promisify__ :
    buffer:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t Promise.t
    [@@js.global "unzip.__promisify__"]

  val unzip_sync :
    buf:Input_type.t -> ?options:Zlib_options.t -> unit -> Buffer.t
    [@@js.global "unzipSync"]

  module Constants : sig
    val b_rotli_decode : int [@@js.global "BROTLI_DECODE"]

    val b_rotli_decoder_error_alloc_block_type_trees : int
      [@@js.global "BROTLI_DECODER_ERROR_ALLOC_BLOCK_TYPE_TREES"]

    val b_rotli_decoder_error_alloc_context_map : int
      [@@js.global "BROTLI_DECODER_ERROR_ALLOC_CONTEXT_MAP"]

    val b_rotli_decoder_error_alloc_context_modes : int
      [@@js.global "BROTLI_DECODER_ERROR_ALLOC_CONTEXT_MODES"]

    val b_rotli_decoder_error_alloc_ring_buffer1 : int
      [@@js.global "BROTLI_DECODER_ERROR_ALLOC_RING_BUFFER_1"]

    val b_rotli_decoder_error_alloc_ring_buffer2 : int
      [@@js.global "BROTLI_DECODER_ERROR_ALLOC_RING_BUFFER_2"]

    val b_rotli_decoder_error_alloc_tree_groups : int
      [@@js.global "BROTLI_DECODER_ERROR_ALLOC_TREE_GROUPS"]

    val b_rotli_decoder_error_dictionary_not_set : int
      [@@js.global "BROTLI_DECODER_ERROR_DICTIONARY_NOT_SET"]

    val b_rotli_decoder_error_format_block_length1 : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_BLOCK_LENGTH_1"]

    val b_rotli_decoder_error_format_block_length2 : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_BLOCK_LENGTH_2"]

    val b_rotli_decoder_error_format_cl_space : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_CL_SPACE"]

    val b_rotli_decoder_error_format_context_map_repeat : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_CONTEXT_MAP_REPEAT"]

    val b_rotli_decoder_error_format_dictionary : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_DICTIONARY"]

    val b_rotli_decoder_error_format_distance : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_DISTANCE"]

    val b_rotli_decoder_error_format_exuberant_meta_nibble : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_EXUBERANT_META_NIBBLE"]

    val b_rotli_decoder_error_format_exuberant_nibble : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_EXUBERANT_NIBBLE"]

    val b_rotli_decoder_error_format_huffman_space : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_HUFFMAN_SPACE"]

    val b_rotli_decoder_error_format_padding1 : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_PADDING_1"]

    val b_rotli_decoder_error_format_padding2 : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_PADDING_2"]

    val b_rotli_decoder_error_format_reserved : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_RESERVED"]

    val b_rotli_decoder_error_format_simple_huffman_alphabet : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_SIMPLE_HUFFMAN_ALPHABET"]

    val b_rotli_decoder_error_format_simple_huffman_same : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_SIMPLE_HUFFMAN_SAME"]

    val b_rotli_decoder_error_format_transform : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_TRANSFORM"]

    val b_rotli_decoder_error_format_window_bits : int
      [@@js.global "BROTLI_DECODER_ERROR_FORMAT_WINDOW_BITS"]

    val b_rotli_decoder_error_invalid_arguments : int
      [@@js.global "BROTLI_DECODER_ERROR_INVALID_ARGUMENTS"]

    val b_rotli_decoder_error_unreachable : int
      [@@js.global "BROTLI_DECODER_ERROR_UNREACHABLE"]

    val b_rotli_decoder_needs_more_input : int
      [@@js.global "BROTLI_DECODER_NEEDS_MORE_INPUT"]

    val b_rotli_decoder_needs_more_output : int
      [@@js.global "BROTLI_DECODER_NEEDS_MORE_OUTPUT"]

    val b_rotli_decoder_no_error : int [@@js.global "BROTLI_DECODER_NO_ERROR"]

    val b_rotli_decoder_param_disable_ring_buffer_reallocation : int
      [@@js.global "BROTLI_DECODER_PARAM_DISABLE_RING_BUFFER_REALLOCATION"]

    val b_rotli_decoder_param_large_window : int
      [@@js.global "BROTLI_DECODER_PARAM_LARGE_WINDOW"]

    val b_rotli_decoder_result_error : int
      [@@js.global "BROTLI_DECODER_RESULT_ERROR"]

    val b_rotli_decoder_result_needs_more_input : int
      [@@js.global "BROTLI_DECODER_RESULT_NEEDS_MORE_INPUT"]

    val b_rotli_decoder_result_needs_more_output : int
      [@@js.global "BROTLI_DECODER_RESULT_NEEDS_MORE_OUTPUT"]

    val b_rotli_decoder_result_success : int
      [@@js.global "BROTLI_DECODER_RESULT_SUCCESS"]

    val b_rotli_decoder_success : int [@@js.global "BROTLI_DECODER_SUCCESS"]

    val b_rotli_default_mode : int [@@js.global "BROTLI_DEFAULT_MODE"]

    val b_rotli_default_quality : int [@@js.global "BROTLI_DEFAULT_QUALITY"]

    val b_rotli_default_window : int [@@js.global "BROTLI_DEFAULT_WINDOW"]

    val b_rotli_encode : int [@@js.global "BROTLI_ENCODE"]

    val b_rotli_large_max_window_bits : int
      [@@js.global "BROTLI_LARGE_MAX_WINDOW_BITS"]

    val b_rotli_max_input_block_bits : int
      [@@js.global "BROTLI_MAX_INPUT_BLOCK_BITS"]

    val b_rotli_max_quality : int [@@js.global "BROTLI_MAX_QUALITY"]

    val b_rotli_max_window_bits : int [@@js.global "BROTLI_MAX_WINDOW_BITS"]

    val b_rotli_min_input_block_bits : int
      [@@js.global "BROTLI_MIN_INPUT_BLOCK_BITS"]

    val b_rotli_min_quality : int [@@js.global "BROTLI_MIN_QUALITY"]

    val b_rotli_min_window_bits : int [@@js.global "BROTLI_MIN_WINDOW_BITS"]

    val b_rotli_mode_font : int [@@js.global "BROTLI_MODE_FONT"]

    val b_rotli_mode_generic : int [@@js.global "BROTLI_MODE_GENERIC"]

    val b_rotli_mode_text : int [@@js.global "BROTLI_MODE_TEXT"]

    val b_rotli_operation_emit_metadata : int
      [@@js.global "BROTLI_OPERATION_EMIT_METADATA"]

    val b_rotli_operation_finish : int [@@js.global "BROTLI_OPERATION_FINISH"]

    val b_rotli_operation_flush : int [@@js.global "BROTLI_OPERATION_FLUSH"]

    val b_rotli_operation_process : int [@@js.global "BROTLI_OPERATION_PROCESS"]

    val b_rotli_param_disable_literal_context_modeling : int
      [@@js.global "BROTLI_PARAM_DISABLE_LITERAL_CONTEXT_MODELING"]

    val b_rotli_param_large_window : int
      [@@js.global "BROTLI_PARAM_LARGE_WINDOW"]

    val b_rotli_param_lgblock : int [@@js.global "BROTLI_PARAM_LGBLOCK"]

    val b_rotli_param_lgwin : int [@@js.global "BROTLI_PARAM_LGWIN"]

    val b_rotli_param_mode : int [@@js.global "BROTLI_PARAM_MODE"]

    val b_rotli_param_ndirect : int [@@js.global "BROTLI_PARAM_NDIRECT"]

    val b_rotli_param_npostfix : int [@@js.global "BROTLI_PARAM_NPOSTFIX"]

    val b_rotli_param_quality : int [@@js.global "BROTLI_PARAM_QUALITY"]

    val b_rotli_param_size_hint : int [@@js.global "BROTLI_PARAM_SIZE_HINT"]

    val d_eflate : int [@@js.global "DEFLATE"]

    val d_eflateraw : int [@@js.global "DEFLATERAW"]

    val g_unzip : int [@@js.global "GUNZIP"]

    val g_zip : int [@@js.global "GZIP"]

    val i_nflate : int [@@js.global "INFLATE"]

    val i_nflateraw : int [@@js.global "INFLATERAW"]

    val u_nzip : int [@@js.global "UNZIP"]

    val z_no_flush : int [@@js.global "Z_NO_FLUSH"]

    val z_partial_flush : int [@@js.global "Z_PARTIAL_FLUSH"]

    val z_sync_flush : int [@@js.global "Z_SYNC_FLUSH"]

    val z_full_flush : int [@@js.global "Z_FULL_FLUSH"]

    val z_finish : int [@@js.global "Z_FINISH"]

    val z_block : int [@@js.global "Z_BLOCK"]

    val z_trees : int [@@js.global "Z_TREES"]

    val z_ok : int [@@js.global "Z_OK"]

    val z_stream_end : int [@@js.global "Z_STREAM_END"]

    val z_need_dict : int [@@js.global "Z_NEED_DICT"]

    val z_errno : int [@@js.global "Z_ERRNO"]

    val z_stream_error : int [@@js.global "Z_STREAM_ERROR"]

    val z_data_error : int [@@js.global "Z_DATA_ERROR"]

    val z_mem_error : int [@@js.global "Z_MEM_ERROR"]

    val z_buf_error : int [@@js.global "Z_BUF_ERROR"]

    val z_version_error : int [@@js.global "Z_VERSION_ERROR"]

    val z_no_compression : int [@@js.global "Z_NO_COMPRESSION"]

    val z_best_speed : int [@@js.global "Z_BEST_SPEED"]

    val z_best_compression : int [@@js.global "Z_BEST_COMPRESSION"]

    val z_default_compression : int [@@js.global "Z_DEFAULT_COMPRESSION"]

    val z_filtered : int [@@js.global "Z_FILTERED"]

    val z_huffman_only : int [@@js.global "Z_HUFFMAN_ONLY"]

    val z_rle : int [@@js.global "Z_RLE"]

    val z_fixed : int [@@js.global "Z_FIXED"]

    val z_default_strategy : int [@@js.global "Z_DEFAULT_STRATEGY"]

    val z_default_windowbits : int [@@js.global "Z_DEFAULT_WINDOWBITS"]

    val z_min_windowbits : int [@@js.global "Z_MIN_WINDOWBITS"]

    val z_max_windowbits : int [@@js.global "Z_MAX_WINDOWBITS"]

    val z_min_chunk : int [@@js.global "Z_MIN_CHUNK"]

    val z_max_chunk : int [@@js.global "Z_MAX_CHUNK"]

    val z_default_chunk : int [@@js.global "Z_DEFAULT_CHUNK"]

    val z_min_memlevel : int [@@js.global "Z_MIN_MEMLEVEL"]

    val z_max_memlevel : int [@@js.global "Z_MAX_MEMLEVEL"]

    val z_default_memlevel : int [@@js.global "Z_DEFAULT_MEMLEVEL"]

    val z_min_level : int [@@js.global "Z_MIN_LEVEL"]

    val z_max_level : int [@@js.global "Z_MAX_LEVEL"]

    val z_default_level : int [@@js.global "Z_DEFAULT_LEVEL"]

    val z_lib_vernum : int [@@js.global "ZLIB_VERNUM"]
  end
  [@@js.scope "constants"]

  val z_no_flush : int [@@js.global "Z_NO_FLUSH"]

  val z_partial_flush : int [@@js.global "Z_PARTIAL_FLUSH"]

  val z_sync_flush : int [@@js.global "Z_SYNC_FLUSH"]

  val z_full_flush : int [@@js.global "Z_FULL_FLUSH"]

  val z_finish : int [@@js.global "Z_FINISH"]

  val z_block : int [@@js.global "Z_BLOCK"]

  val z_trees : int [@@js.global "Z_TREES"]

  val z_ok : int [@@js.global "Z_OK"]

  val z_stream_end : int [@@js.global "Z_STREAM_END"]

  val z_need_dict : int [@@js.global "Z_NEED_DICT"]

  val z_errno : int [@@js.global "Z_ERRNO"]

  val z_stream_error : int [@@js.global "Z_STREAM_ERROR"]

  val z_data_error : int [@@js.global "Z_DATA_ERROR"]

  val z_mem_error : int [@@js.global "Z_MEM_ERROR"]

  val z_buf_error : int [@@js.global "Z_BUF_ERROR"]

  val z_version_error : int [@@js.global "Z_VERSION_ERROR"]

  val z_no_compression : int [@@js.global "Z_NO_COMPRESSION"]

  val z_best_speed : int [@@js.global "Z_BEST_SPEED"]

  val z_best_compression : int [@@js.global "Z_BEST_COMPRESSION"]

  val z_default_compression : int [@@js.global "Z_DEFAULT_COMPRESSION"]

  val z_filtered : int [@@js.global "Z_FILTERED"]

  val z_huffman_only : int [@@js.global "Z_HUFFMAN_ONLY"]

  val z_rle : int [@@js.global "Z_RLE"]

  val z_fixed : int [@@js.global "Z_FIXED"]

  val z_default_strategy : int [@@js.global "Z_DEFAULT_STRATEGY"]

  val z_binary : int [@@js.global "Z_BINARY"]

  val z_text : int [@@js.global "Z_TEXT"]

  val z_ascii : int [@@js.global "Z_ASCII"]

  val z_unknown : int [@@js.global "Z_UNKNOWN"]

  val z_deflated : int [@@js.global "Z_DEFLATED"]
end
[@@js.scope Import.zlib]
