/* global acquireVsCodeApi, search_urls, createWebWorker: writable */

(() => {
  const vscode = acquireVsCodeApi();
  const config = JSON.parse(document.getElementById("ocaml-documentation-config").textContent);
  const root = new URL(config.root);
  const workers = new Set();
  let workerUrl;

  function send(type, values = {}) {
    vscode.postMessage({
      ...values,
      type,
      nonce: config.nonce,
      scroll: Math.round(window.scrollY),
    });
  }

  function localPath(url) {
    if (url.origin !== root.origin || !url.pathname.startsWith(root.pathname)) return null;
    return decodeURIComponent(url.pathname.slice(root.pathname.length));
  }

  function scrollToFragment(fragment) {
    const target = document.getElementById(decodeURIComponent(fragment.replace(/^#/, "")));
    if (target) {
      target.scrollIntoView();
      if (!target.hasAttribute("tabindex")) target.tabIndex = -1;
      target.focus({ preventScroll: true });
    }
  }

  document.addEventListener("click", (event) => {
    const link = event.target.closest("a[href]");
    if (!link) return;
    event.preventDefault();
    // VS Code also opens trusted link clicks, even when their default is prevented.
    event.stopPropagation();
    const href = link.getAttribute("href");
    if (href.startsWith("#")) {
      scrollToFragment(href);
      return;
    }
    const url = new URL(href, document.baseURI);
    const path = localPath(url);
    if (path !== null) send("navigate", { path, fragment: url.hash });
    else if (["https:", "http:", "mailto:"].includes(url.protocol)) {
      // Resource URLs belong to this Webview and must not escape to a browser.
      if (url.origin !== root.origin) send("external", { href: url.href });
    }
  });

  document.addEventListener("keydown", (event) => {
    if (!event.altKey || event.ctrlKey || event.metaKey || event.shiftKey) return;
    if (event.key === "ArrowLeft" && config.back) {
      event.preventDefault();
      send("back");
    } else if (event.key === "ArrowRight" && config.forward) {
      event.preventDefault();
      send("forward");
    }
  });

  function toolbar() {
    document.documentElement.classList.add("ocaml-documentation");
    const nav = document.createElement("nav");
    nav.className = "ocaml-documentation-toolbar";
    nav.setAttribute("aria-label", "Documentation navigation");
    for (const [type, label, title, enabled] of [
      ["back", "Back", "Back (Alt+Left)", config.back],
      ["forward", "Forward", "Forward (Alt+Right)", config.forward],
      ["reload", "Reload", "Reload documentation", true],
    ]) {
      const button = document.createElement("button");
      button.type = "button";
      button.textContent = label;
      button.title = title;
      button.disabled = !enabled;
      button.dataset.action = type;
      button.addEventListener("click", () => send(type));
      nav.append(button);
    }
    document.body.prepend(nav);
    const sticky = [...document.querySelectorAll(".odoc-search, .odoc-toc")].map((element) => ({
      element,
      top: element.style.top,
      maxHeight: element.style.maxHeight,
    }));
    function positionNavigation() {
      const height = nav.getBoundingClientRect().height;
      document.documentElement.style.setProperty(
        "--ocaml-documentation-toolbar-height",
        `${height}px`,
      );
      for (const { element, top, maxHeight } of sticky) {
        element.style.top = top;
        element.style.maxHeight = maxHeight;
        const style = getComputedStyle(element);
        if (!["sticky", "fixed"].includes(style.position)) continue;
        element.style.top = `${(Number.parseFloat(style.top) || 0) + height}px`;
        if (style.maxHeight !== "none") {
          element.style.maxHeight = `${Math.max(0, Number.parseFloat(style.maxHeight) - height)}px`;
        }
      }
    }
    positionNavigation();
    window.addEventListener("resize", positionNavigation);
  }

  async function prepareSearch() {
    const input = document.querySelector(".search-bar");
    if (!input || typeof search_urls === "undefined") return;
    const status = document.createElement("span");
    status.className = "ocaml-documentation-search-status";
    status.setAttribute("role", "status");
    input.after(status);
    input.disabled = true;
    status.textContent = "Loading search…";
    try {
      if (typeof createWebWorker !== "function") throw new Error("Unsupported odoc search loader");
      const sources = await Promise.all(
        search_urls.map(async (source) => {
          const url = new URL(source, document.baseURI);
          if (localPath(url) === null)
            throw new Error("Search source is outside the documentation directory");
          const response = await fetch(url);
          if (!response.ok) throw new Error(`Could not load search source (${response.status})`);
          return response.text();
        }),
      );
      // Webview workers cannot import local resources. Fetch them on the page
      // and build a self-contained worker, as the VS Code Webview guide recommends.
      workerUrl = URL.createObjectURL(
        new Blob(
          sources.flatMap((source) => [source, "\n;\n"]),
          {
            type: "application/javascript",
          },
        ),
      );
      createWebWorker = () => {
        const worker = new Worker(workerUrl);
        workers.add(worker);
        worker.addEventListener("error", () => {
          status.textContent = "Search could not run. Reload to try again.";
          input.disabled = true;
        });
        return worker;
      };
      status.textContent = "";
      input.disabled = false;
    } catch (error) {
      console.error("Could not initialise documentation search", error);
      status.textContent = "Search could not be loaded. Reload to try again.";
    }
  }

  document.addEventListener("DOMContentLoaded", () => {
    toolbar();
    void prepareSearch();
  });

  window.addEventListener("load", () => {
    if (config.scroll !== null) window.scrollTo(0, config.scroll);
    else if (config.fragment) scrollToFragment(config.fragment);
  });

  window.addEventListener("pagehide", () => {
    for (const worker of workers) worker.terminate();
    if (workerUrl) URL.revokeObjectURL(workerUrl);
  });
})();
