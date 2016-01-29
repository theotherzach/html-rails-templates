Adds HTML templates into the JST global object using Rails asset pipeline.

in *app/assets/javascripts/my-component/foo.html*

```html
<h2>I can be found in <code>app/assets/javascripts/my-component/foo.html</code></h2>
```

in the JavaScript Console

```javascript
JST['my-component/foo.html']
//=> "<h2>I can be found in <code>app/assets/javascripts/my-component/foo.html</code></h2>"
```


## Thank You

This gem is forked from [angular-rails-templates](https://github.com/pitr/angular-rails-templates). Thank you Pitr, Damien Mathieu, and Jeremy Ebler.

## Usage

### 1. Add the Gem

In Gemfile

```ruby
gem 'rails_html_javascript_templates'
```

### 2. Add HTML files to your JavaScript

Name your templates like you would name any other Rails view. **The `.html` part is required.** If it is not present your views will not be added to the 'JST' Object.

```
foo.html
foo.html.erb
foo.html.haml
foo.html.slim
```

Caution: *`.ngslim` and `.nghaml` are no longer supported!*

Rails HTML Javascript Templates will try to load support for the following markups if their gems are present:

| Extension | Required gem                                             |
|---------- |----------------------------------------------------------|
| .erb      | -                                                        |
| .str      | -                                                        |
| .haml     | haml                                                     |
| .slim     | slim                                                     |
| .md       | liquid, rdiscount, redcarpet, bluecloth, kramdown, maruku |

See [Advanced](#advanced-configuration) if you would like to use other markup languages.


### 3. Use your Templates

No matter what the source file extension is, your template's url will be  `#{base_name}.html`

For example:
```ruby
main.html => main.html
widget.html.haml => widget.html
modals/confirm.html.slim => modals/confirm.html
modals/dialog.html.slim.erb.str => modals/dialog.html # don't do this
```

The templates can then be accessed via `templateUrl` as expected:

```javascript
// Template: app/assets/templates/yourTemplate.html.haml
JST['app/assets/templates/yourTemplate.html'];
//Returns compiled string template
```


### 5. Avoid name collisions

If you have `app/assets/javascript/user.js` and `app/assets/templates/user.html`, the former one will actually hide the latter. This is due to how Rails asset pipeline sees asset files, both are served under `/assets/user.js`. Please use namespacing to combat this issue.

## Advanced Configuration

Rails HTML Javascript Templates has some configuration options that can be set inside `config/application.rb`

Here are their default values:
```ruby
# config/application.rb
config.html_js_templates.namespace    = 'JST'
config.html_js_templates.ignore_prefix  = %w(templates/)
config.html_js_templates.inside_paths   = [Rails.root.join('app', 'assets')]
config.html_js_templates.markups        = %w(erb str haml slim md)
config.html_js_templates.htmlcompressor = false
```

### Configuration Option: `namespace`

This configures the name of the global object that your templates will be placed into.
It is used to generate javascript like:

```javascipt
window.<%= namespace %> = window.<%= namespace %> || {}
```

Which defaults to `JST`

### Configuration Option: `ignore_prefix`

*If you place your templates in `app/assets/templates` this option is mostly useless.*

`ignore_prefix` will be stripped from the beginning of your template's key on the `JST` object.

Since the default ignore_prefix is [`templates/`], any templates placed under `app/assets/javascripts/templates` will automatically have short names. If your templates are not in this location, you will need to use the full path to the template.

You can set `config.html_js_templates.ignore_prefix` to change the default ignore prefix. Default is [`templates/`].


``` javascript
// Templates in: app/assets/javascripts/templates (default)
// ignore_prefix: templates/ (default)
{
  templateUrl: 'yourTemplate.html'
}
// This won't work:
{
  templateUrl: 'templates/yourTemplate.html'
}
```

``` javascript
// Templates in: app/assets/javascripts/my_app/templates (custom)
// ignore_prefix: templates/ (default)
{
  templateUrl: 'my_app/templates/yourTemplate.html'
}

// ignore_prefix: my_app/templates/ (custom)
{
  templateUrl: 'yourTemplate.html'
}
```


### Configuration Option: `inside_paths`

Templates only from paths matched by `inside_paths` will be used. By default anything under app/assets can be templates. This option is useful if you are using this gem inside an engine. Also useful if you DON'T want some files to be processed by this gem (see issue #88)


### Configuration Option: `markups`

Any markup that Tilt supports can be used, but you may need to add a gem to your Gemfile. See [Tilt](https://github.com/rtomayko/tilt) for a list of the supported markups and required libraries.

```ruby
# Gemfile
gem "asciidoctor"
gem "radius"
gem "creole"
gem "tilt-handlebars"

# config/application.rb
config.html_js_templates.markups.push 'asciidoc', 'radius', 'wiki', 'hbs'
```
If you would like to use a non-standard extension or you would like to use a custom template, you just need to tell Tilt about it.

```ruby
# config/initializers/rails_html_javascript_templates.rb
Tilt.register Tilt::HamlTemplate, 'nghaml'

# config/application.rb
config.html_js_templates.markups.push 'nghaml'
```
Note: You would still need to use `foo`**`.html`**`.nghaml`

## License

MIT License. Copyright 2015 TheOtherZach

## Theif

* Zach Briggs

## Original Authors & contributors

* Damien Mathieu <42@dmathieu.com>
* pitr <pitr.vern@gmail.com>
* Jeremy Ebler <jebler@gmail.com>
