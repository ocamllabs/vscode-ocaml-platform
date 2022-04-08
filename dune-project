(lang dune 3.0)

(name vscode-ocaml-platform)

(source
 (github ocamllabs/vscode-ocaml-platform))

(license ISC)

(maintainers "Rudi Grinberg <me@rgrinerg.com>")

(authors
 "Rudi Grinberg <me@rgrinerg.com>"
 "Sora Morimoto <sora@morimoto.io>"
 "Max Lantas <mnxndev@outlook.com>"
 "Manas <prometheansacrifice@gmail.com>"
 "Rusty Key <iam@stfoo.ru>"
 "Louis Roché <louis@louisroche.net>"
 "Ulugbek Abdullaev <ulugbekna@gmail.com>"
 "Javier Chávarri <javier.chavarri@gmail.com>")

(generate_opam_files true)

(package
 (name vscode-ocaml-platform)
 (synopsis "Visual Studio Code extension for OCaml")
 (allow_empty) ; without this line, dune complains "The package vscode-ocaml-platform does not have any user defined
               ; stanzas attached to it.""
 (depends
  (vscode
   (= :version))
  (ocaml
   (>= 4.11))
  (js_of_ocaml
   (>= 4.0.0))
  (gen_js_api
   (>= 1.1.0))
  (base
   (>= v0.14.1))
  (promise_jsoo
   (>= 0.3.1))
  (jsonoo
   (>= 0.2.1))
  (ocaml-version
   (>= 3.4.0))
  (ppxlib
   (>= 0.23.0))
  (opam-file-format
   (>= 2.1.2))))

(package
 (name vscode)
 (synopsis "Visual Studio Code Bindings")
 (depends
  (ocaml
   (>= 4.11))
  (js_of_ocaml
   (>= 4.0.0))
  (gen_js_api
   (>= 1.1.0))
  (promise_jsoo
   (>= 0.3.1))
  (jsonoo
   (>= 0.2.1))))
