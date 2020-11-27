(lang dune 2.7)

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
 (depends
  (vscode (= :version))
  (ocaml
   (>= 4.11))
  (js_of_ocaml
   (>= 3.7.0))
  (gen_js_api
   (>= 1.0.6))
  (core_kernel
   (>= v0.14.0))
  (promise_jsoo
   (>= 0.3.0))
  (jsonoo
   (>= 0.2.0))))

(package
 (name vscode)
 (synopsis "Visual Studio Code Bindings")
 (depends
  (ocaml
   (>= 4.11))
  (js_of_ocaml
   (>= 3.7.0))
  (gen_js_api
   (>= 1.0.6))
  (promise_jsoo
   (>= 0.3.0))
  (jsonoo
   (>= 0.2.0))))
