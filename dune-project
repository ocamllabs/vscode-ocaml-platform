(lang dune 3.20)

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
   (>= 5.4))
  (js_of_ocaml
   (>= 6.0))
  (gen_js_api
   (= 1.1.6))
  (base
   (>= v0.17))
  (promise_jsoo
   (>= 0.4.3))
  (jsonoo
   (>= 0.3))
  (ocaml-version
   (>= 4.0))
  (ppxlib
   (>= 0.36))
  (opam-file-format
   (>= 2.1.6))
  (ocamlformat
   (and
    (= 0.28.1)
    :with-dev-setup))
  (ocaml-lsp-server :with-dev-setup)))

(package
 (name vscode-interop)
 (synopsis
  "Interop library compatible with the vscode and vscode-node bindings")
 (depends
  (ocaml
   (>= 4.08))
  (js_of_ocaml
   (>= 6.0))
  (gen_js_api
   (= 1.1.6))
  (ocamlformat
   (and
    (= 0.28.1)
    :with-dev-setup))
  (ocaml-lsp-server :with-dev-setup)))

(package
 (name vscode)
 (synopsis "Visual Studio Code Bindings")
 (depends
  (ocaml
   (>= 4.08))
  (js_of_ocaml
   (>= 6.0))
  (gen_js_api
   (= 1.1.6))
  (promise_jsoo
   (>= 0.4.3))
  (jsonoo
   (>= 0.3))
  (vscode-interop
   (= :version))
  (ocamlformat
   (and
    (= 0.28.1)
    :with-dev-setup))
  (ocaml-lsp-server :with-dev-setup)))

(package
 (name vscode-node)
 (synopsis
  "Bindings for Node.js that are used by the Visual Studio Code extension")
 (depends
  (ocaml
   (>= 4.08))
  (js_of_ocaml
   (>= 6.0))
  (gen_js_api
   (= 1.1.6))
  (promise_jsoo
   (>= 0.4.3))
  (jsonoo
   (>= 0.3))
  (vscode-interop
   (= :version))
  (ocamlformat
   (and
    (= 0.28.1)
    :with-dev-setup))
  (ocaml-lsp-server :with-dev-setup)))
