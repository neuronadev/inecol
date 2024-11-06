import { Controller } from "@hotwired/stimulus"
import Trix from "trix";
import "@rails/actiontext"
const { lang } = Trix.config

// Connects to data-controller="trixtool"
export default class extends Controller {
  static targets = ['editor', 'foregroundColorPicker', 'backgroundColorPicker']
  
  connect () {
    const UNUSED_TOOLBAR_CLASSES = [
      ".trix-button--icon-strike",
      ".trix-button--icon-link",
      ".trix-button--icon-quote",
      ".trix-button--icon-code",
      ".trix-button-group--file-tools",
      ".trix-button-group--history-tools"
    ];

    this.initTrix()
    this.reloadOriginalContent()
    UNUSED_TOOLBAR_CLASSES.forEach((cls) => {
      document.querySelector(cls).remove();
    });

    Trix.config.textAttributes.underline = {
      tagName: "u",
      style: { textDecoration: "underline" },
      inheritable: true,
      parser: function (element) {
        var style = window.getComputedStyle(element);
        return style.textDecoration === "underline";
      },
    };

    Trix.config.textAttributes.yellow = {
      style: { backgroundColor: "yellow" },
      inheritable: true,
      parser: function (element) {
        return style.backgroundColor === "yellow";
      },
    };

    const toolbar = this.editorTarget.previousSibling
    const sibling1 = toolbar.querySelector(".trix-button--icon-italic")
    const sibling2 = toolbar.querySelector(".trix-button--icon-backgroundColor")

    const underButtonHTML = `<button type="button" class="trix-button" data-trix-attribute="underline" title="Underline">
                             <span class="icon"> <svg fill="#000000" width="20px" height="20px" viewBox="-5.5 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
                                                  <path d="M0 5.656l0.063 1.156c0.125 0.031 0.313 0.063 0.563 0.063 0.5 0 1.094 0.031 1.531 0.156s0.563 0.375 0.625 0.844c0.063 0.5 0.063 1.125 0.063 1.656v4.938c0 1.656 0.094 3.125 0.594 4.344 0.531 1.219 1.469 2.219 3.188 2.844 1.219 0.438 2.563 0.625 3.875 0.625s2.813-0.219 4.156-0.688c1.313-0.469 2.5-1.313 3.25-2.531 0.313-0.563 0.531-1.375 0.656-2.219 0.094-0.813 0.125-1.563 0.125-2.25 0-0.219 0-0.969-0.063-1.844 0-0.438-0.031-0.906-0.031-1.406-0.063-1-0.094-1.875-0.125-2.469-0.031-0.25-0.063-0.438-0.063-0.5-0.063-0.25-0.063-0.469-0.063-0.719s0.094-0.438 0.25-0.531c0.344-0.219 0.906-0.281 1.438-0.313 0.25-0.031 0.531-0.063 0.719-0.125 0.063-0.125 0.063-0.25 0.063-0.375 0-0.219-0.031-0.469-0.094-0.688h-0.281c-0.344 0-0.688 0-1.031 0.063-0.344 0.031-0.719 0.063-1.063 0.063-0.781 0-1.5-0.031-2.25-0.094s-1.469-0.094-2.25-0.031v1.094c0.125 0.063 0.438 0.063 0.781 0.063h0.469c0.156-0.031 0.281-0.031 0.344-0.031 0.406 0 0.75 0.156 1.031 0.438 0.063 0.063 0.156 0.313 0.219 0.625 0.063 0.344 0.125 0.75 0.188 1.219 0.094 0.938 0.219 2.094 0.25 3.125 0.063 1.063 0.094 1.938 0.094 2.281 0 2.094-0.313 3.656-1.219 4.719-0.875 1.063-2.281 1.594-4.563 1.594-2.844 0-4.281-1.781-4.438-4.438-0.094-2.469-0.188-4.875-0.188-7.344 0-0.719 0.063-1.25 0.125-1.5 0.156-0.563 0.563-0.656 1.344-0.594 0.344 0.031 0.875 0 1.438-0.094v-0.094c0-0.156 0-0.375-0.031-0.531-0.031-0.188-0.031-0.344 0-0.5-1.75 0.063-3.625 0.125-5.406 0.125-0.594 0-1.25-0.031-1.844-0.063-0.594-0.063-1.281-0.094-1.906-0.094h-0.281c-0.063 0-0.156 0.031-0.25 0.031zM0 26.438h20.813v-2.125h-20.813v2.125z"></path>
                                                 </svg>
                             </span>
                              </button>`
    const yellowButtonHTML = `<button type="button" class="trix-button" data-trix-attribute="yellow" title="Color">Y</button>`

    sibling1.insertAdjacentHTML("afterend", underButtonHTML)
    sibling2.insertAdjacentHTML("afterend", yellowButtonHTML)


/*
    const toolbar = this.editorTarget.previousSibling
    const h2ButtonHTML = '<button type="button" class="trix-button" data-trix-attribute="heading" title="Subheading">H1</button>'
    const h3ButtonHTML = '<button type="button" class="trix-button" data-trix-attribute="subHeading" title="Subheading">H3</button>'

    const once = {
            once: true
    }

    addEventListener("trix-initialize", function(event) {

      Trix.config.textAttributes.heading = {
          tagName: "h1",
          style: { textDecoration: "heading" },
          inheritable: true,
          parser: function (element) {
            var style = window.getComputedStyle(element);
            return style.textDecoration === "heading";
          },
      }

      const sibling1 = toolbar.querySelector(".trix-button--icon-increase-nesting-level")
      sibling1.insertAdjacentHTML("afterend", h2ButtonHTML)
      const sibling2 = toolbar.querySelector("[data-trix-attribute='heading']")
      sibling2.insertAdjacentHTML("afterend", h3ButtonHTML)
    }, once)

*/

    
  }

  openfile(){
      console.log("open file")
  }

  initTrix () {
    
    
    if (this.hasForegroundColorPickerTarget) { return }

    Trix.config.blockAttributes.heading1.tagName = 'h3'
    this.addForegroundButtonInToolbar()
    this.addBackgroundButtonInToolbar()
    this.addTextAlignCenterButtonInToolbar()
  }

  reloadOriginalContent () {
    this.editorTarget.reset()
  }

  openForegroundColorPicker () {
    this.foregroundColorPickerTarget.click()
    
  }

  openBackgroundColorPicker () {
    this.backgroundColorPickerTarget.click()
  }

  foregroundColorChanged () {
    this.editorTarget.editor.activateAttribute('foregroundColor', this.foregroundColorPickerTarget.value)
  }

  backgroundColorChanged () {
    this.editorTarget.editor.activateAttribute('backgroundColor', this.backgroundColorPickerTarget.value)
  }

  addForegroundButtonInToolbar () {
    Trix.config.textAttributes.foregroundColor = {
      styleProperty: 'color',
      inheritable: true
    }

    this.element
      .querySelector('.trix-button-group.trix-button-group--text-tools')
      .insertAdjacentHTML('beforeend', this.foregroundColorButtons)
  }

  addBackgroundButtonInToolbar () {
    Trix.config.textAttributes.backgroundColor = {
      styleProperty: 'background-color',
      inheritable: true
    }

    this.element
      .querySelector('.trix-button-group.trix-button-group--text-tools')
      .insertAdjacentHTML('beforeend', this.backgroundColorButtons)
  }

  addTextAlignCenterButtonInToolbar () {
    Trix.config.blockAttributes.textAlignCenter = {
      tagName: 'centered-div'
    }

    this.element
      .querySelector('.trix-button-group.trix-button-group--block-tools')
      .insertAdjacentHTML('beforeend', this.textAlignButtons)
  }

  get foregroundColorButtons () {
    
    return `<input type="color" style="width:0;height:0;padding:0;margin-top:20px;visibility:hidden"
                   data-trix-target="foregroundColorPicker" data-action="trix#foregroundColorChanged">
            <button type="button" class="trix-button" data-action="click->trix#openForegroundColorPicker" title="Text color">
              <span class="icon"><svg xmlns="http://www.w3.org/2000/svg" id="Outline" viewBox="0 0 24 24" width="20" height="20"><path d="M17.115,8.05A1.5,1.5,0,1,0,18.95,9.115,1.5,1.5,0,0,0,17.115,8.05Z"/><path d="M12.115,5.05A1.5,1.5,0,1,0,13.95,6.115,1.5,1.5,0,0,0,12.115,5.05Z"/><path d="M7.115,8.05A1.5,1.5,0,1,0,8.95,9.115,1.5,1.5,0,0,0,7.115,8.05Z"/><path d="M7.115,14.05A1.5,1.5,0,1,0,8.95,15.115,1.5,1.5,0,0,0,7.115,14.05Z"/><path d="M12.5.007A12,12,0,0,0,.083,12a12.014,12.014,0,0,0,12,12c.338,0,.67-.022,1-.05a1,1,0,0,0,.916-1l-.032-3.588A3.567,3.567,0,0,1,20.057,16.8l.1.1a1.912,1.912,0,0,0,1.769.521,1.888,1.888,0,0,0,1.377-1.177A11.924,11.924,0,0,0,24.08,11.7,12.155,12.155,0,0,0,12.5.007Zm8.982,15.4-.014-.014a5.567,5.567,0,0,0-9.5,3.985L11.992,22a10,10,0,0,1,.09-20c.117,0,.235,0,.353.006a10.127,10.127,0,0,1,9.645,9.743A9.892,9.892,0,0,1,21.485,15.4Z"/></svg></span>
            </button>`
  }

  get backgroundColorButtons () {
    return `<input type="color" style="width:0;height:0;padding:0;margin-top:20px;visibility:hidden"
                   data-trix-target="backgroundColorPicker" data-action="trix#backgroundColorChanged">
            <button type="button" class="trix-button trix-button--icon trix-button--icon-backgroundColor" data-action="click->trix#openBackgroundColorPicker" title="Text background color">
              <span class="icon"><svg id="Layer_1" height="20" viewBox="0 0 24 24" width="20" xmlns="http://www.w3.org/2000/svg" data-name="Layer 1"><path d="m22.327 18.422c.728 1.034 1.673 2.229 1.673 3.078a2.5 2.5 0 0 1 -5 0c0-.775.961-2.008 1.692-3.069a1 1 0 0 1 1.635-.009zm-.877-4.558-8.672 8.672a5.006 5.006 0 0 1 -7.071 0l-4.242-4.243a5 5 0 0 1 0-7.071l5.709-5.71-2.856-2.89a1 1 0 0 1 1.422-1.406l2.848 2.884 1.548-1.55-.843-.843a1 1 0 0 1 1.414-1.414l13 13a1 1 0 1 1 -1.414 1.414zm-1.414-1.414-8.486-8.486-1.557 1.558 4.718 4.778a1 1 0 1 1 -1.422 1.4l-4.709-4.765-5.7 5.7a3 3 0 0 0 0 4.243l4.242 4.243a3.005 3.005 0 0 0 4.243 0z"/></svg></span>
            </button>`
  }

  get textAlignButtons () {
    return `<button type="button" class="trix-button" data-trix-attribute="textAlignCenter">
              <span class="icon"><svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 24 24" width="20" height="20"><g id="_01_align_center" data-name="01 align center"><rect y="4" width="24" height="2"/><rect x="4" y="9" width="16" height="2"/><rect x="4" y="19" width="16" height="2"/><rect y="14" width="24" height="2"/></g></svg></span>
            </button>`
  }
    

}
