import { Controller } from "@hotwired/stimulus"
import Trix from "trix"

export default class extends Controller {
  static targets = ['editor']
    connect() {
        this.editorTarget.reset()
        /*addEventListener("trix-initialize", function (event) {*/
              /* -----------------------------------------UNDERLINE---------------------------------------------------------------------------------- */
              Trix.config.textAttributes.underline = {
                  tagName: "u",
                  style: { textDecoration: "underline" },
                  inheritable: true,
                  parser: function (element) {
                    var style = window.getComputedStyle(element);
                    return style.textDecoration === "underline";
                  },
              };
              let underlineEl = document.createElement("button");
              underlineEl.setAttribute("type", "button");
              underlineEl.setAttribute("data-trix-attribute", "underline");
              underlineEl.setAttribute("data-trix-key", "u");
              underlineEl.setAttribute("tabindex", -1);
              underlineEl.setAttribute("title", "underline");
              underlineEl.classList.add("trix-button", "trix-button--icon-underline");
              underlineEl.innerHTML = `<svg fill="#000000" width="20px" height="20px" viewBox="-5.5 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
                                                                           <path d="M0 5.656l0.063 1.156c0.125 0.031 0.313 0.063 0.563 0.063 0.5 0 1.094 0.031 1.531 0.156s0.563 0.375 0.625 0.844c0.063 0.5 0.063 1.125 0.063 1.656v4.938c0 1.656 0.094 3.125 0.594 4.344 0.531 1.219 1.469 2.219 3.188 2.844 1.219 0.438 2.563 0.625 3.875 0.625s2.813-0.219 4.156-0.688c1.313-0.469 2.5-1.313 3.25-2.531 0.313-0.563 0.531-1.375 0.656-2.219 0.094-0.813 0.125-1.563 0.125-2.25 0-0.219 0-0.969-0.063-1.844 0-0.438-0.031-0.906-0.031-1.406-0.063-1-0.094-1.875-0.125-2.469-0.031-0.25-0.063-0.438-0.063-0.5-0.063-0.25-0.063-0.469-0.063-0.719s0.094-0.438 0.25-0.531c0.344-0.219 0.906-0.281 1.438-0.313 0.25-0.031 0.531-0.063 0.719-0.125 0.063-0.125 0.063-0.25 0.063-0.375 0-0.219-0.031-0.469-0.094-0.688h-0.281c-0.344 0-0.688 0-1.031 0.063-0.344 0.031-0.719 0.063-1.063 0.063-0.781 0-1.5-0.031-2.25-0.094s-1.469-0.094-2.25-0.031v1.094c0.125 0.063 0.438 0.063 0.781 0.063h0.469c0.156-0.031 0.281-0.031 0.344-0.031 0.406 0 0.75 0.156 1.031 0.438 0.063 0.063 0.156 0.313 0.219 0.625 0.063 0.344 0.125 0.75 0.188 1.219 0.094 0.938 0.219 2.094 0.25 3.125 0.063 1.063 0.094 1.938 0.094 2.281 0 2.094-0.313 3.656-1.219 4.719-0.875 1.063-2.281 1.594-4.563 1.594-2.844 0-4.281-1.781-4.438-4.438-0.094-2.469-0.188-4.875-0.188-7.344 0-0.719 0.063-1.25 0.125-1.5 0.156-0.563 0.563-0.656 1.344-0.594 0.344 0.031 0.875 0 1.438-0.094v-0.094c0-0.156 0-0.375-0.031-0.531-0.031-0.188-0.031-0.344 0-0.5-1.75 0.063-3.625 0.125-5.406 0.125-0.594 0-1.25-0.031-1.844-0.063-0.594-0.063-1.281-0.094-1.906-0.094h-0.281c-0.063 0-0.156 0.031-0.25 0.031zM0 26.438h20.813v-2.125h-20.813v2.125z"></path>
                                                                     </svg>`;
              document.querySelector(".trix-button-group--text-tools").appendChild(underlineEl);
              /* -----------------------------------------YELLOW----------------------------------------------------------------------------------- */
              Trix.config.textAttributes.yellow = {
                  tagName: "y",
                  style: { backgroundColor: "yellow" },
                  inheritable: true,
                  parser: function (element) {
                    var style = window.getComputedStyle(element);
                    return style.backgroundColor === "yellow";
                  },
              };
              let underlineElY = document.createElement("button");
              underlineElY.setAttribute("type", "button");
              underlineElY.setAttribute("data-trix-attribute", "yellow");
              underlineElY.setAttribute("data-trix-key", "y");
              underlineElY.setAttribute("tabindex", -1);
              underlineElY.setAttribute("title", "yellow");
              underlineElY.classList.add("trix-button", "trix-button--icon-yellow");
              underlineElY.innerHTML = `<button type="button" class="trix-button trix-button--icon-yellow" data-trix-attribute="yellow" title="Color">
                                             <svg width="20px" height="20px" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--twemoji" preserveAspectRatio="xMidYMid meet"><path fill="#FDCB58" d="M36 32a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4h28a4 4 0 0 1 4 4v28z"></path></svg>
                                        </button>`;
              document.querySelector(".trix-button-group--text-tools").appendChild(underlineElY);
              /* ------------------------------------------------------------------------------------------------------------------------------------ */
              Trix.config.textAttributes.green = {
                tagName: "g",
                style: { backgroundColor: "#09FF09" },
                inheritable: true,
                parser: function (element) {
                  var style = window.getComputedStyle(element);
                  return style.backgroundColor === "#09FF09";
                },
              };
              let underlineElG = document.createElement("button");
              underlineElG.setAttribute("type", "button");
              underlineElG.setAttribute("data-trix-attribute", "green");
              underlineElG.setAttribute("data-trix-key", "g");
              underlineElG.setAttribute("tabindex", -1);
              underlineElG.setAttribute("title", "green");
              underlineElG.classList.add("trix-button", "trix-button--icon-green");
              underlineElG.innerHTML = `<button type="button" class="trix-button trix-button--icon-green" data-trix-attribute="green" title="Color">
                                            <svg width="20px" height="20px" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--twemoji" preserveAspectRatio="xMidYMid meet"><path fill="#78B159" d="M36 32a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4h28a4 4 0 0 1 4 4v28z"></path></svg>
                                        </button>`;
              document.querySelector(".trix-button-group--text-tools").appendChild(underlineElG);
              /* ------------------------------------------------------------------------------------------------------------------------------------ */
              Trix.config.textAttributes.blue = {
                tagName: "b",
                style: { backgroundColor: "#00FFFF" },
                inheritable: true,
                parser: function (element) {
                  var style = window.getComputedStyle(element);
                  return style.backgroundColor === "#00FFFF";
                },
              };
              let underlineElB = document.createElement("button");
              underlineElB.setAttribute("type", "button");
              underlineElB.setAttribute("data-trix-attribute", "blue");
              underlineElB.setAttribute("data-trix-key", "b");
              underlineElB.setAttribute("tabindex", -1);
              underlineElB.setAttribute("title", "blue");
              underlineElB.classList.add("trix-button", "trix-button--icon-blue");
              underlineElB.innerHTML = `<button type="button" class="trix-button trix-button--icon-blue" data-trix-attribute="blue" title="Color">
                                           <svg width="20px" height="20px" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--twemoji" preserveAspectRatio="xMidYMid meet"><path fill="#55ACEE" d="M36 32a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4h28a4 4 0 0 1 4 4v28z"></path></svg>
                                        </button>`;
              document.querySelector(".trix-button-group--text-tools").appendChild(underlineElB);
              /* ------------------------------------------------------------------------------------------------------------------------------------ */          
              Trix.config.textAttributes.red = {
                tagName: "r",
                style: { backgroundColor: "#FF0000" },
                inheritable: true,
                parser: function (element) {
                  var style = window.getComputedStyle(element);
                  return style.backgroundColor === "#FF0000";
                },
              };
              let underlineElR = document.createElement("button");
              underlineElR.setAttribute("type", "button");
              underlineElR.setAttribute("data-trix-attribute", "red");
              underlineElR.setAttribute("data-trix-key", "R");
              underlineElR.setAttribute("tabindex", -1);
              underlineElR.setAttribute("title", "red");
              underlineElR.classList.add("trix-button", "trix-button--icon-red");
              underlineElR.innerHTML = `<button type="button" class="trix-button trix-button--icon-red" data-trix-attribute="red" title="Color">
                                           <svg width="20px" height="20px" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--twemoji" preserveAspectRatio="xMidYMid meet"><path fill="#DD2E44" d="M36 32a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4h28a4 4 0 0 1 4 4v28z"></path></svg>
                                        </button>`;
              document.querySelector(".trix-button-group--text-tools").appendChild(underlineElR);
              /* ------------------------------------------------------------------------------------------------------------------------------------ */
              Trix.config.textAttributes.letterblue = {
                style: { color: "#0000CC" },
                inheritable: true,
                parser: function (element) {
                  var style = window.getComputedStyle(element);
                  return style.color === "#0000CC";
                },
              };
              let underlineElLB = document.createElement("button");
              underlineElLB.setAttribute("type", "button");
              underlineElLB.setAttribute("data-trix-attribute", "letterb");
              underlineElLB.setAttribute("tabindex", -1);
              underlineElLB.setAttribute("title", "letter");
              underlineElLB.classList.add("trix-button", "trix-button--icon-letterb");
              underlineElLB.innerHTML = `<button type="button" class="trix-button trix-button--icon-letterb" data-trix-attribute="letterblue" title="Color">
                                          <svg width="20px" height="20px" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--twemoji" preserveAspectRatio="xMidYMid meet" fill="#ffffff">  <g id="SVGRepo_bgCarrier" stroke-width="0"/>  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>  <g id="SVGRepo_iconCarrier">  <path fill="#0000CC" d="M36 32a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4h28a4 4 0 0 1 4 4v28z"/>  <path fill="#0000CCFFF" d="M14.747 9.125c.527-1.426 1.736-2.573 3.317-2.573c1.643 0 2.792 1.085 3.318 2.573l6.077 16.867c.186.496.248.931.248 1.147c0 1.209-.992 2.046-2.139 2.046c-1.303 0-1.954-.682-2.264-1.611l-.931-2.915h-8.62l-.93 2.884c-.31.961-.961 1.642-2.232 1.642c-1.24 0-2.294-.93-2.294-2.17c0-.496.155-.868.217-1.023l6.233-16.867zm.34 11.256h5.891l-2.883-8.992h-.062l-2.946 8.992z"/>  </g>  </svg>
                                         </button>`;
              document.querySelector(".trix-button-group--text-tools").appendChild(underlineElLB);
              /* ------------------------------------------------------------------------------------------------------------------------------------ */
              Trix.config.textAttributes.letterred = {
                style: { color: "#FF0000" },
                inheritable: true,
                parser: function (element) {
                  var style = window.getComputedStyle(element);
                  return style.color === "#FF0000";
                },
              };
              let underlineElLR = document.createElement("button");
              underlineElLR.setAttribute("type", "button");
              underlineElLR.setAttribute("data-trix-attribute", "letterr");
              underlineElLR.setAttribute("tabindex", -1);
              underlineElLR.setAttribute("title", "letter");
              underlineElLR.classList.add("trix-button", "trix-button--icon-letterr");
              underlineElLR.innerHTML = `<button type="button" class="trix-button trix-button--icon-letterr" data-trix-attribute="letterred" title="Color">
                                             <svg width="20px" height="20px" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--twemoji" preserveAspectRatio="xMidYMid meet" fill="#ffffff">  <g id="SVGRepo_bgCarrier" stroke-width="0"/>  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>  <g id="SVGRepo_iconCarrier">  <path fill="#FF0000" d="M36 32a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4h28a4 4 0 0 1 4 4v28z"/>  <path fill="#FF0000FFF" d="M14.747 9.125c.527-1.426 1.736-2.573 3.317-2.573c1.643 0 2.792 1.085 3.318 2.573l6.077 16.867c.186.496.248.931.248 1.147c0 1.209-.992 2.046-2.139 2.046c-1.303 0-1.954-.682-2.264-1.611l-.931-2.915h-8.62l-.93 2.884c-.31.961-.961 1.642-2.232 1.642c-1.24 0-2.294-.93-2.294-2.17c0-.496.155-.868.217-1.023l6.233-16.867zm.34 11.256h5.891l-2.883-8.992h-.062l-2.946 8.992z"/>  </g>  </svg>
                                         </button>`;
              document.querySelector(".trix-button-group--text-tools").appendChild(underlineElLR);
              /* ------------------------------------------------------------------------------------------------------------------------------------ */
              
        /*}, true);*/
    }
    
}
