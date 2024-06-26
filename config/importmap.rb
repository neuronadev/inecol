# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-rails-nested-form", to: "https://ga.jspm.io/npm:stimulus-rails-nested-form@4.1.0/dist/stimulus-rails-nested-form.mjs"
pin "slim-select", to: "https://ga.jspm.io/npm:slim-select@2.5.0/dist/slimselect.es.js"
pin "flowbite", to: "https://ga.jspm.io/npm:flowbite@1.6.5/lib/esm/index.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.7/lib/index.js"
pin "numbro", to: "https://ga.jspm.io/npm:numbro@2.3.6/dist/numbro.min.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "activestorage", to: "https://ga.jspm.io/npm:activestorage@5.2.8-1/app/assets/javascripts/activestorage.js"
pin "numeral", to: "https://ga.jspm.io/npm:numeral@2.0.6/numeral.js"
pin "@kanety/stimulus-contextmenu", to: "https://ga.jspm.io/npm:@kanety/stimulus-contextmenu@1.0.1/dist/index.module.js"
pin "@kanety/stimulus-static-actions", to: "https://ga.jspm.io/npm:@kanety/stimulus-static-actions@1.0.1/dist/index.modern.js"
pin "tabulator-tables", to: "https://ga.jspm.io/npm:tabulator-tables@6.2.1/dist/js/tabulator_esm.js"
pin "xlsx", to: "https://ga.jspm.io/npm:xlsx@0.18.5/xlsx.mjs"
