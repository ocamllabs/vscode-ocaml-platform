(lang dune 3.16)

(name vscode-ocaml-platform)

(source
 (github ocamllabs/vscode-ocaml-platform))

(license ISC)

(maintainers "Rudi Grinberg <me@rgrinberg.com>")

(authors "Rudi Grinberg <me@rgrinberg.com>"
 "Sora Morimoto <sora@morimoto.io>" "Max Lantas <mnxndev@outlook.com>"
 "Manas <prometheansacrifice@gmail.com>" "Rusty Key <iam@stfoo.ru>"
 "Louis Roché <louis@louisroche.net>"
 "Ulugbek Abdullaev <ulugbekna@gmail.com>"
 "Javier Chávarri <javier.chavarri@gmail.com>")

(generate_opam_files true)

(package
 (name vscode-ocaml-platform)
 (synopsis "Visual Studio Code extension for OCaml")
 (allow_empty)
 (depends
  (vscode
   (= :version))
  (ocaml
   (>= 5.2.0))
  (js_of_ocaml
   (>= 4.1.0))
  (gen_js_api
   (= 1.1.2))
  (base
   (>= v0.14.1))
  (promise_jsoo
   (>= 0.3.1))
  (jsonoo
   (>= 0.2.1))
  (ocaml-version
   (>= 3.5.0))
  (ppxlib
   (>= 0.26.0))
  (opam-file-format
   (>= 2.1.2))
  (ocamlformat
   (and
    (= 0.27.0)
    :with-dev-setup))
  (ocaml-lsp-server :with-dev-setup)))

(package
 (name vscode)
 (synopsis "Visual Studio Code Bindings")
 (depends
  (ocaml
   (>= 4.13))
  (js_of_ocaml
   (>= 4.1.0))
  (gen_js_api
   (= 1.1.2))
  (promise_jsoo
   (>= 0.3.1))
  (jsonoo
   (>= 0.2.1))
  (ocamlformat
   (and
    (= 0.27.0)
    :with-dev-setup))
  (ocaml-lsp-server :with-dev-setup)))
