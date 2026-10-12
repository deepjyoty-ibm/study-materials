/*
 * Technical Study Knowledge Base — small client-side enhancements.
 * Material for MkDocs renders Mermaid natively when the superfences
 * custom fence is configured, so no Mermaid script is loaded here.
 */

(function () {
  "use strict";

  /**
   * Open external links in a new tab. Internal (relative) links are untouched.
   */
  function markExternalLinks() {
    var links = document.querySelectorAll(".md-content a[href^='http']");
    links.forEach(function (link) {
      if (link.hostname && link.hostname !== window.location.hostname) {
        link.setAttribute("target", "_blank");
        link.setAttribute("rel", "noopener noreferrer");
      }
    });
  }

  /**
   * Material uses "instant navigation" in some configurations, which fires
   * document$ instead of DOMContentLoaded. Support both.
   */
  if (typeof window.document$ !== "undefined" && window.document$.subscribe) {
    window.document$.subscribe(markExternalLinks);
  } else {
    document.addEventListener("DOMContentLoaded", markExternalLinks);
  }
})();
