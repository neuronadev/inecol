// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'flowbite'
import "trix"
import "@rails/actiontext"
addEventListener("trix-initialize", (event) => {
    //configTrix();
    //extendTrix(event);
    //console.log("Event trix")
})

window.process = {
    env: {
        NODE_ENV: 'development'
    }
}

