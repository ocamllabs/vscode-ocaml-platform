let () = Js.log @@ Js.String.replace "foo" "bar" "this foo"

module Foo = struct
    let a = "Oh, this seems to work!"
end

let () = print_endline @@ "How is this even working?!" ^ Foo.a