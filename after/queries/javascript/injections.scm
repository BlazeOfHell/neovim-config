;; inherits: javascript

((pair
  key: (property_identifier) @k
  value: (template_string 
    (string_fragment) @injection.content))
 (#eq? @k "template")
 (#set! injection.language "vue")
 (#set! injection.priority "120"))
