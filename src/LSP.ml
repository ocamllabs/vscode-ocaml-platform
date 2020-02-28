open Bindings
module Server =
  struct
    module type MTYPE  =
      sig
        type t
        val make : unit -> t
        val onProgress : t -> (float -> unit) -> unit
        val onEnd : t -> (unit -> unit) -> unit
        val onError : t -> (string -> unit) -> unit
        val reportProgress : t -> float -> unit
        val reportEnd : t -> unit
        val reportError : t -> string -> unit
        val run : t -> string -> unit Js.Promise.t
      end
    let setupWithProgressIndicator m folder =
      let module M = (val (m : (module MTYPE))) in
        let open M in
          Window.withProgress
            ([%bs.obj { location = 15; title = "Setting up toolchain..." }])
            (fun progress ->
               let succeeded = ref ((Ok (()))) in
               let eventEmitter = make () in
               onProgress eventEmitter
                 (fun percent ->
                    ((progress.report
                        ([%bs.obj
                           { increment = (int_of_float (percent *. 100.)) }]))
                    [@bs ]));
               onEnd eventEmitter
                 (fun () ->
                    ((progress.report ([%bs.obj { increment = 100 }]))
                    [@bs ]));
               onError eventEmitter
                 (fun errorMsg ->
                    succeeded := ((Error (errorMsg))));
               (let open Js.Promise in
                  (run eventEmitter folder) |>
                    (then_ (fun () -> resolve (!succeeded)))))
    let make =
      (fun toolchain ->
         let (command, args) = Toolchain.lsp toolchain in
         ({ command; args; options = { env = Process.env } } : Vscode.LanguageClient.serverOptions) :
      Toolchain.t -> Vscode.LanguageClient.serverOptions)
  end
module Client =
  struct
    let make =
      (fun () ->
         {
           documentSelector =
             [|{ scheme = "file"; language = "ocaml" };{
                                                         scheme = "file";
                                                         language = "reason"
                                                       }|]
         } : unit -> Vscode.LanguageClient.clientOptions)
  end
