require "./lib/custom_helpers"
require "./lib/deployment_walkthrough_helpers"
require "./lib/kramdown_patch"
helpers CustomHelpers
helpers DeploymentWalkthroughHelpers

#################################################
# Page options, layouts, aliases and proxies
#################################################

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
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###### Deployment walkthrough ######

define_deployment_walkthrough_pages do |*proxy_args|
  proxy(*proxy_args)
end

ignore "/walkthroughs/deploy/intro.html"
ignore "/walkthroughs/deploy/integration_mode.html"
ignore "/walkthroughs/deploy/open_source_vs_enterprise.html"
ignore "/walkthroughs/deploy/launch_server.html"
ignore "/walkthroughs/deploy/install_language_runtime.html"
ignore "/walkthroughs/deploy/install_passenger_main.html"
ignore "/walkthroughs/deploy/install_passenger.html"
ignore "/walkthroughs/deploy/deploy_app_main.html"
ignore "/walkthroughs/deploy/deploy_app.html"
ignore "/walkthroughs/deploy/deploy_updates.html"
ignore "/walkthroughs/deploy/conclusion.html"

###### Installation, upgrade and uninstallation ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/install/#{integration_mode_type}/index.html",
    "/install/index2.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/install/index.html",
    "/install/install/step1.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/upgrade.html",
    "/install/upgrade.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/uninstall/index.html",
    "/install/uninstall/step1.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/moving.html",
    "/install/moving.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/noninteractive_install.html",
    "/install/noninteractive_install.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/customizing_compilation_process.html",
      "/install/customizing_compilation_process.html",
      locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/upgrading_from_oss_to_enterprise.html",
    "/install/upgrading_from_oss_to_enterprise.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/apt_repo.html",
    "/install/apt_repo.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/yum_repo.html",
    "/install/yum_repo.html",
    locals: integration_mode_spec

  PASSENGER_EDITIONS.each do |edition_spec|
    edition_type = edition_spec[:edition_type]
    locals = integration_mode_spec.merge(edition_spec)

    proxy "/install/#{integration_mode_type}/install/#{edition_type}/index.html",
      "/install/install/step2.html",
      locals: locals
    proxy "/install/#{integration_mode_type}/uninstall/#{edition_type}/index.html",
      "/install/uninstall/step2.html",
      locals: locals

    available_os_configs(locals).each do |os_config_spec|
      os_config = os_config_spec[:os_config_type]

      proxy "/install/#{integration_mode_type}/install/#{edition_type}/#{os_config}/index.html",
        "/install/install/step3.html",
        locals: locals.merge(os_config_spec)
    end
  end
end

# Miscellaneous pages
proxy "/install/nginx/disable.html",
  "/install/disable.html",
  locals: INTEGRATION_MODE_NGINX
proxy "/install/apache/disable.html",
  "/install/disable.html",
  locals: INTEGRATION_MODE_APACHE

ignore "/install/index2.html"
ignore "/install/upgrade.html"
ignore "/install/disable.html"
ignore "/install/moving.html"
ignore "/install/noninteractive_install.html"
ignore "/install/upgrading_from_oss_to_enterprise.html"
ignore "/install/apt_repo.html"
ignore "/install/yum_repo.html"
ignore "/install/install/step1.html"
ignore "/install/install/step2.html"
ignore "/install/install/step3.html"
ignore "/install/uninstall/step1.html"
ignore "/install/uninstall/step2.html"

###### Configuration and optimization ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/config/#{integration_mode_type}/index.html",
    "/config/index2.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/howto.html",
    "/config/howto.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/optimization.html",
    "/config/optimization.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/tuning_sse_and_websockets.html",
    "/config/tuning_sse_and_websockets.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/cloud_licensing_configuration.html",
    "/config/cloud_licensing_configuration.html",
    locals: integration_mode_spec
end

ignore "/config/index2.html"
ignore "/config/howto.html"
ignore "/config/optimization.html"
ignore "/config/cloud_licensing_configuration.html"

###### Deployment, scaling and high availability ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/deploy/#{integration_mode_type}/index.html",
    "/deploy/index2.html",
    locals: integration_mode_spec

  proxy "/deploy/#{integration_mode_type}/user_sandboxing.html",
    "/deploy/user_sandboxing.html",
    locals: integration_mode_spec
  proxy "/deploy/#{integration_mode_type}/flying_passenger.html",
    "/deploy/flying_passenger.html",
    locals: integration_mode_spec

  proxy "/deploy/#{integration_mode_type}/deploy/index.html",
    "/deploy/deploy/language_selection.html",
    locals: integration_mode_spec
  proxy "/deploy/#{integration_mode_type}/automating_app_updates/index.html",
    "/deploy/automating_app_updates/language_selection.html",
    locals: integration_mode_spec
  DEPLOYMENT_WALKTHROUGH_LANGUAGES.each do |language_spec|
    locals = integration_mode_spec.merge(language_spec)

    proxy "/deploy/#{integration_mode_type}/deploy/#{language_spec[:language_type]}/index.html",
      "/deploy/deploy/deploy.html",
      locals: locals
    proxy "/deploy/#{integration_mode_type}/automating_app_updates/#{language_spec[:language_type]}/index.html",
      "/deploy/automating_app_updates/automating_app_updates.html",
      locals: locals
  end
end

ignore "/deploy/index2.html"
ignore "/deploy/deploy/language_selection.html"
ignore "/deploy/automating_app_updates/language_selection.html"
ignore "/deploy/automating_app_updates/automating_app_updates.html"
ignore "/deploy/user_sandboxing.html"
ignore "/deploy/flying_passenger.html"

###### Administration and troubleshooting ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/admin/#{integration_mode_type}/index.html",
    "/admin/index2.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/troubleshooting/index.html",
    "/admin/troubleshooting/language_selection.html",
    locals: integration_mode_spec
  DEPLOYMENT_WALKTHROUGH_LANGUAGES.each do |language_spec|
    next if language_spec[:language_type] == :iojs
    proxy "/admin/#{integration_mode_type}/troubleshooting/#{language_spec[:language_type]}/index.html",
      "/admin/troubleshooting/troubleshooting.html",
      locals: integration_mode_spec.merge(language_spec)
  end
end

ignore "/admin/index2.html"
ignore "/admin/troubleshooting/language_selection.html"
ignore "/admin/troubleshooting/troubleshooting.html"

###### In-depth ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/indepth/app_autodetection/#{integration_mode_type}/index.html",
    "/indepth/app_autodetection/app_autodetection.html",
    locals: integration_mode_spec
end

ignore "/indepth/app_autodetection/app_autodetection.html"

#################################################

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :markdown_engine, :kramdown
set :relative_links, true
set :display_guides, true

activate :syntax
activate :relative_assets

configure :development do
  set :url_root, DEVELOPMENT_URL_ROOT
  activate :livereload, :port => 35730
end

# Build-specific configuration
configure :build do
  set :url_root, PRODUCTION_URL_ROOT

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  activate :search_engine_sitemap
end
