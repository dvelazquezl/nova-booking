# Be sure to restart your server when you modify this file.
# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.connect_src :self, :https
  policy.font_src :self, :https, 'https://fonts.gstatic.com'
  policy.form_action :self, :https
  policy.img_src :self, :https, :data, 'https://maps.googleapis.com',
                 'https://maps.gstatic.com',
                 'https://*.cloudinary.com'
  policy.object_src :none
  policy.script_src :self, :https, :unsafe_inline, 'https://maps.googleapis.com'
  policy.style_src :self, :https, :unsafe_inline, 'http://fonts.googleapis.com'
# From Laboratory, Firefox Add-Ons
# default-src 'none';
# connect-src 'self';
# font-src 'self' data: https://fonts.gstatic.com
# form-action 'self';
# img-src 'self' data: https://maps.googleapis.com
#   https://maps.gstatic.com
#   https://res-1.cloudinary.com
#   https://res-2.cloudinary.com
#   https://res-3.cloudinary.com
#   https://res-4.cloudinary.com
#   https://res-5.cloudinary.com
# script-src 'self' 'unsafe-inline'
#   https://maps.googleapis.com/maps-api-v3/api/js/40/12/common.js
#   https://maps.googleapis.com/maps-api-v3/api/js/40/12/controls.js
#   https://maps.googleapis.com/maps-api-v3/api/js/40/12/map.js
#   https://maps.googleapis.com/maps-api-v3/api/js/40/12/marker.js
#   https://maps.googleapis.com/maps-api-v3/api/js/40/12/onion.js
#   https://maps.googleapis.com/maps-api-v3/api/js/40/12/util.js
#   https://maps.googleapis.com/maps/api/js
#   https://maps.googleapis.com/maps/api/js/AuthenticationService.Authenticate
#   https://maps.googleapis.com/maps/api/js/QuotaService.RecordEvent
#   https://maps.googleapis.com/maps/api/js/ViewportInfoService.GetViewportInfo
#   https://maps.googleapis.com/maps/vt
# style-src 'self' 'unsafe-inline'
#   https://fonts.googleapis.com/
# Specify URI for violation reports
# policy.report_uri "/csp-violation-report-endpoint"
end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
