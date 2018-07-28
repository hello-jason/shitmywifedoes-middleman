# ========================================================================
# Hello Jason
# http://hellojason.net
# ========================================================================

# Copy ./source/environment_variables.example to ./source/environment_variables.rb
# then update settings there.
require "./source/environment_variables.rb"

# ========================================================================
# Site settings
# ========================================================================
set :site_title,            "Shit My Wife Does"
set :site_description,      "Miscellaneous shit that my wife does."
set :site_url_production,   ENV['site_url_production']
set :site_url_development,  ENV['site_url_development']
set :css_dir,               'assets/css'
set :js_dir,                'assets/js'
set :images_dir,            'assets/img'
set :fonts_dir,             'assets/fonts'

# Sitemap URLs (use trailing slashes)
set :url_home,              "/"
set :url_page2,             "/page2/"
set :url_page3,             "/page3/"
set :url_page4,             "/page4/"

# Slim template engine
require "slim"

# Internationalization
# activate :i18n

# Use relative URLs
activate :relative_assets

# Pretty URLs
activate :directory_indexes

# Autoprefixer
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
  config.inline   = false
end

# Reload the browser automatically whenever files change
activate :livereload

# ========================================================================
# Page options, layouts, aliases and proxies
# ========================================================================

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html",
# :locals => {:which_fake_page => "Rendering a fake page with a local
# variable" }

# ========================================================================
# Helpers
# ========================================================================

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do

  # Gets partials from the _partials directory
  def _partial(partial_filename)
    partial "_partials/#{partial_filename}"
  end

  # Post helper
  # = post "Post title", "image-name.jpg", "2015-09-05"
  def post(title, image, datetime)
    date_object = datetime.to_time
    date_human_readable = date_object.strftime('%B %d, %Y')
    "
    <article class='panel'>
      <div class='panel-heading'>
        <h1>#{title}</h1>
      </div>
      <div class='panel-body'>
        <img src='/#{images_dir}/#{image}'>
      </div>
      <div class='panel-footer'>
        <time datetime='#{datetime}'>#{date_human_readable}</time>
      </div>
    </article>
    "
  end

end


# ========================================================================
# Development-specific configuration
# ========================================================================
configure :development do
  set :site_url, "#{site_url_development}"
end

# ========================================================================
# Build-specific configuration
# ========================================================================
configure :build do
  set :site_url, "#{site_url_production}"
  set :sass, line_comments: false, style: :nested

  activate :minify_css
  activate :minify_html
  activate :minify_javascript
  activate :gzip

  # Enable cache buster
  activate :asset_hash, :exts => ['.css']

  # Ignore files/dir during build process
  ignore "environment_variables.rb"
  ignore "environment_variables.rb.sample"
  ignore "favicon_template.png"
  ignore "imageoptim.manifest.yml"
  ignore "assets/js"

  # Compress and optimise images during build
  # Documentation: https://github.com/plasticine/middleman-imageoptim
  activate :imageoptim do |options|
    # Image extensions to attempt to compress
    options.image_extensions = %w(.png .jpg .gif .svg)
    # Cause image_optim to be in shouty-mode
    options.verbose = false
  end

  # Create favicon and device-specific icons
  # Edit favicon_template.png for custom icon
  activate :favicon_maker, :icons => {
    "favicon_template.png" => [
      { icon: "apple-touch-icon-152x152-precomposed.png" },
      { icon: "apple-touch-icon-144x144-precomposed.png" },
      { icon: "apple-touch-icon-120x120-precomposed.png" },
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      { icon: "apple-touch-icon-76x76-precomposed.png" },
      { icon: "apple-touch-icon-72x72-precomposed.png" },
      { icon: "apple-touch-icon-60x60-precomposed.png" },
      { icon: "apple-touch-icon-57x57-precomposed.png" },
      { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
      { icon: "apple-touch-icon.png", size: "57x57" },
      { icon: "favicon-196x196.png" },
      { icon: "favicon-160x160.png" },
      { icon: "favicon-96x96.png" },
      { icon: "favicon-32x32.png" },
      { icon: "favicon-16x16.png" },
      { icon: "favicon.png", size: "16x16" },
      { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
      { icon: "mstile-144x144", format: "png" },
    ]
  }
end

# ========================================================================
# Deployment-specific configuration
# ========================================================================
# Middleman-deploy can deploy a site via rsync, ftp, sftp, or git.
# Documentation: https://github.com/karlfreeman/middleman-deploy
# ========================================================================
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method       = :git
  deploy.remote       = 'origin'
  deploy.branch       = 'gh-pages'
  deploy.strategy     = :force_push
  deploy.clean        = true
end
